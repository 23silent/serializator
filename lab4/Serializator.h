//
//  Serializator.h
//  lab4
//
//  Created by Roman Pupin on 05.03.2020.
//  Copyright © 2020 Roman Pupin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Serializator : NSObject

+ (NSString *) serialize:(id)dictionary error:(NSError **)error;

@end
