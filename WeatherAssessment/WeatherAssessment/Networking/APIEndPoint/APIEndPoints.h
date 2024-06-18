//
//  APIEndPoints.h
//  TryCitiesListView
//
//  Created by Moaaz Ahmed Fawzy Taha on 15/06/2024.
//

#ifndef APIEndPoints_h
#define APIEndPoints_h

#import <Foundation/Foundation.h>
#import "APIComponent.h"
#import <ReactiveObjC/ReactiveObjC.h>

typedef NS_ENUM(NSInteger, API) {
    getWeather,
    getWeatherImage
};

@interface APIEndPoints : NSObject

+ (instancetype)sharedInstance;

- (RACSignal *)requestWithAPI:(API)api parameters:(NSDictionary *)parameters;
- (RACSignal *)requestWithURL:(NSURL *)url method:(HTTPMethod)method;
+ (NSURL *)imageURLWithId:(NSString *)imageId;
@end

#endif /* APIEndPoints_h */
