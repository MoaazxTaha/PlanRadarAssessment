//
//  Config.c
//  TryCitiesListView
//
//  Created by Moaaz Ahmed Fawzy Taha on 15/06/2024.
//

#import "Config.h"

@implementation Config

+ (NSString *)apiKey {
    return @"f5cb0b965ea1564c50c6f1b74534d823";
}
+ (NSString *)baseURL {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"BaseUrl"];
}

@end
