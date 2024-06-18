//
//  NetworkError.h
//  TryCitiesListView
//
//  Created by Moaaz Ahmed Fawzy Taha on 15/06/2024.
//

#ifndef NetworkError_h
#define NetworkError_h

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, NetworkErrorCode) {
    NetworkErrorInvalidURL,
    NetworkErrorConnectionFailure,
    NetworkErrorTimeout,
    NetworkErrorInvalidResponse,
    NetworkErrorDataParsingFailure = (00) // to be able to reuse in the swift file (APIManagerWrapper)
};

@interface NetworkError : NSError

+ (instancetype)errorWithCode:(NSInteger)code;

@end

#endif /* NetworkError_h */
