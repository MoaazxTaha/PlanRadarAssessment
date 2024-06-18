//
//  APIEndPoints.c
//  TryCitiesListView
//
//  Created by Moaaz Ahmed Fawzy Taha on 15/06/2024.
//

#import "APIEndPoints.h"
#import "Config.h"
#import "NetworkError.h"
#import <ReactiveObjC/ReactiveObjC.h>

#define  ApiLocationWeatherDirectory @"locationName"
@implementation APIEndPoints

+ (instancetype)sharedInstance {
    static APIEndPoints *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (NSString *)base {
    return [Config baseURL];
}

- (NSString *)prefixForAPI:(API)api {
    switch (api) {
        case getWeather:
        case getWeatherImage:
            return [Config baseURL];
    }
}

- (NSString *)pathForAPI:(API)api parameters:(NSDictionary *)parameters {
    switch (api) {
        case getWeather:
        case getWeatherImage:
            return @"";
    }
}

- (HTTPMethod)methodForAPI:(API)api {
    switch (api) {
        case getWeather:
        case getWeatherImage:
            return HTTPMethodGET;
    }
}

- (NSArray<NSURLQueryItem *> *)queryItemsForAPI:(API)api parameters:(NSDictionary *)parameters {
    NSMutableArray <NSURLQueryItem *> *apiQueryParameters = [[NSMutableArray alloc] initWithObjects:[[NSURLQueryItem alloc] initWithName:@"appid" value: [Config apiKey]], nil];
    
    switch (api) {
        case getWeather:
            [apiQueryParameters addObject:[[NSURLQueryItem alloc] initWithName:@"q" value:parameters[@"locationName"]]];
            break;
        case getWeatherImage:
            return @[];
    }
    
    return [apiQueryParameters copy];
}

- (NSURLRequest *)urlRequestForAPI:(API)api parameters:(NSDictionary *)parameters {
    NSString *prefix = [self prefixForAPI:api];
    NSString *path = [self pathForAPI:api parameters:parameters];
    HTTPMethod method = [self methodForAPI:api];
    NSArray<NSURLQueryItem *> *queryItems = [self queryItemsForAPI:api parameters:parameters];

    NSURLComponents *components = [[NSURLComponents alloc] initWithString:self.base];
    components.path = [prefix stringByAppendingString:path];
    components.queryItems = queryItems;
    components.scheme = @"https";

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:components.URL];
    request.HTTPMethod = HTTPMethodString(method);

    return request;
}

- (RACSignal *)requestWithAPI:(API)api parameters:(NSDictionary *)parameters {
    NSURLRequest *request = [self urlRequestForAPI:api parameters:parameters];
    return [self performRequest:request];
}

- (RACSignal *)requestWithURL:(NSURL *)url method:(HTTPMethod)method authorised:(BOOL)isAuthorisedRequest  {
    NSURL *resultURL = url;
    if (isAuthorisedRequest) {
        NSURLComponents *components = [[NSURLComponents alloc] initWithString: [url absoluteString]];
        NSMutableArray <NSURLQueryItem *> *authorisationParameter = [[NSMutableArray alloc] initWithObjects:[[NSURLQueryItem alloc] initWithName:@"appid" value: [Config apiKey]], nil];
        components.queryItems = authorisationParameter;
        resultURL = components.URL;
    }
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = HTTPMethodString(method);

    return [self performRequest:request];
}

- (RACSignal *)performRequest:(NSURLRequest *)request {
    NSLog(@"## BE REQUEST: (%@)", request.URL);
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error) {
                [subscriber sendError:error];
                return;
            }
            
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            if (httpResponse.statusCode < 200 || httpResponse.statusCode >= 300) {
                NSError *statusError = [NSError errorWithDomain:@"NetworkError" code:httpResponse.statusCode userInfo:nil];
                [subscriber sendError:statusError];
                return;
            }
            
            NSError *jsonError;
            id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            if (jsonError) {
                [subscriber sendError:jsonError];
                return;
            }
            
            [subscriber sendNext:jsonObject];
            [subscriber sendCompleted];
        }];
        
        [task resume];
        
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }];
}

+ (NSURL *)imageURLWithId:(NSString *)imageId {
    NSString *imageURLString = [NSString stringWithFormat:@"http://openweathermap.org/img/w/%@.png", imageId];
    NSURLComponents *components = [[NSURLComponents alloc] initWithString: imageURLString];
    NSMutableArray <NSURLQueryItem *> *authorisationParameter = [[NSMutableArray alloc] initWithObjects:[[NSURLQueryItem alloc] initWithName:@"appid" value: [Config apiKey]], nil];
    components.queryItems = authorisationParameter;
    return components.URL;
}

@end
