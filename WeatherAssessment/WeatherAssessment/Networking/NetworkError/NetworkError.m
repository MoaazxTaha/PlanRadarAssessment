//
//  NetworkError.c
//  TryCitiesListView
//
//  Created by Moaaz Ahmed Fawzy Taha on 15/06/2024.
//

#import "NetworkError.h"

@implementation NetworkError

+ (instancetype)errorWithCode:(NSInteger)code {
    NetworkErrorCode errorCode;
    switch (code) {
        case 400 ... 404:
            errorCode = NetworkErrorInvalidURL;
            break;
        case 408:
            errorCode = NetworkErrorTimeout;
            break;
        default:
            errorCode = NetworkErrorInvalidResponse;
            break;
    }
    return [NetworkError errorWithDomain:@"com.example.network" code:errorCode userInfo:nil];
}

@end

