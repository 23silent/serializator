//
//  Serializator.m
//  lab4
//
//  Created by Roman Pupin on 05.03.2020.
//  Copyright © 2020 Roman Pupin. All rights reserved.
//

#import "Serializator.h"
#import "ViewController.h"

@implementation Serializator


static NSString *SerialiseErrorDomain = @"SerialiseErrorDomain";

typedef NS_ENUM(NSUInteger, SerialiseErrorCode){
    SERIALISE_ERROR_NOT_DICTIONARY,
    SERIALISE_ERROR_INCORRECT_TYPE,
    SERIALISE_ERROR_INCORRECT_KEY
};

+ (NSString *) serialize:(id)dict error:(NSError **)error {
    NSMutableArray *arr = [NSMutableArray array];
    if ([dict isKindOfClass:[NSDictionary class]]) {
        for (NSString* key in dict) {
            if ([key isKindOfClass:[NSString class]] || [key isKindOfClass:[NSNumber class]]) {
                id value = dict[key];
                NSError *err;
                NSString * tempStr = [Serializator processObj:value error:&err];
                if (err) {
                    * error = err;
                    return nil;
                }
                [arr addObject:tempStr];
            } else {
                NSDictionary *userInfo = @{NSLocalizedDescriptionKey: [NSString stringWithFormat:@"Incorrect type of key (%@)", [key class]]};
                * error = [[NSError alloc] initWithDomain:SerialiseErrorDomain code:SERIALISE_ERROR_INCORRECT_KEY userInfo:userInfo];
                return nil;
            }
        }
    } else {
        NSDictionary *userInfo = @{NSLocalizedDescriptionKey: [NSString stringWithFormat:@"It is not a dictionary, but %@", [dict class]]};
        * error = [[NSError alloc] initWithDomain:SerialiseErrorDomain code:SERIALISE_ERROR_NOT_DICTIONARY userInfo:userInfo];
        return nil;
    }
    return [NSString stringWithFormat:@"[%@]", [arr componentsJoinedByString:@"\n"]];
}

+ (NSString *) processArray:(id)arr error:(NSError **)error {
    NSMutableArray *outArr = [NSMutableArray array];
    for (id item in arr){
        NSError *err;
        NSString * tempStr = [Serializator processObj:item error:&err];
        if (err) {
            * error = err;
            return nil;
        }
        [outArr addObject:tempStr];
    }
    return [NSString stringWithFormat:@"[%@]", [outArr componentsJoinedByString:@", "]];
}

+ (NSString *) processObj:(id)obj error:(NSError **)error {
    if ([obj isKindOfClass:[NSDictionary class]]) {
        return [NSString stringWithFormat: @"NSDictionary: %@", [Serializator serialize:obj error:error]];
    }
    if ([obj isKindOfClass:[NSArray class]]) {
        return [NSString stringWithFormat: @"NSArray: %@", [Serializator processArray:obj error:error]];
    }
    if ([obj isKindOfClass:[NSSet class]]) {
        return [NSString stringWithFormat: @"NSSet: %@", [Serializator processArray:[obj allObjects] error:error]];
    }
    if ([obj isKindOfClass:[NSNumber class]]) {
        return [NSString stringWithFormat: @"NSNumber: %@", obj];
    }
    if ([obj isKindOfClass:[NSNull class]]) {
        return @"NSNull: null";
    }
    if ([obj isKindOfClass:[NSString class]]) {
        return [NSString stringWithFormat:@"NSString: %@", obj];
    }
    if ([obj isKindOfClass:[NSValue class]] && ![obj isKindOfClass:[NSNumber class]]) {
        return [NSString stringWithFormat:@"CGRect: %@", NSStringFromCGRect([(NSValue*)obj CGRectValue])];
    }
    
    NSDictionary *userInfo = @{NSLocalizedDescriptionKey: [NSString stringWithFormat:@"Incorrect type of value (%@)", [obj class]]};
    * error = [[NSError alloc] initWithDomain:SerialiseErrorDomain code:SERIALISE_ERROR_INCORRECT_TYPE userInfo:userInfo];
    return nil;
}

@end
