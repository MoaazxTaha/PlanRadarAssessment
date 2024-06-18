//
//  APIComponent.h
//  TryCitiesListView
//
//  Created by Moaaz Ahmed Fawzy Taha on 15/06/2024.
//

#ifndef APIComponent_h
#define APIComponent_h

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, HTTPMethod) {
    HTTPMethodGET,
    HTTPMethodPOST,
    HTTPMethodPUT,
    HTTPMethodDELETE
};

static inline NSString *HTTPMethodString(HTTPMethod method) {
    switch (method) {
        case HTTPMethodGET: return @"GET";
        case HTTPMethodPOST: return @"POST";
        case HTTPMethodPUT: return @"PUT";
        case HTTPMethodDELETE: return @"DELETE";
    }
}

#endif /* APIComponent_h */
