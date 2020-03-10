//
//  ViewController.m
//  lab4
//
//  Created by Roman Pupin on 05.03.2020.
//  Copyright © 2020 Roman Pupin. All rights reserved.
//

#import "ViewController.h"
#import "Serializator.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect rect = CGRectMake(0, 0, 50, 50);
    
    NSDictionary *dict = @{
        @"NSDictionary": @{@1: @"odin", @2: @"dva"},
        @"NSArray": @[@"a", @"b", @"c", @"d", @[@"aa", @"bb"]],
        @"NSSet": [NSSet setWithArray:@[@"s1", @"s2", @"s3", @"s4", @"s5"]],
        @"NSNumber": @15,
        @"NSNull": [NSNull null],
        @"CGRect": [NSValue valueWithCGRect:rect],
    };

    NSDictionary *dict1 = @{
        [NSDate date]: [NSDate date],
        @"NSDictionary": @{@1: @"odin", @2: @"dva"},
        @"NSArray": @[@"a", @"b", @"c", @"d", @[@"aa", @"bb"]],
        @"NSSet": [NSSet setWithArray:@[@"s1", @"s2", @"s3", @"s4", @"s5"]],
        @"NSNumber": @15,
        @"NSNull": [NSNull null],
        @"CGRect": [NSValue valueWithCGRect:rect],
    };
    
    NSDictionary *dict2 = @{
        @"NSDictionary": @{@1: @"odin", @2: @"dva"},
        @"NSArray": @[@"a", @"b", @"c", @"d", @[@"aa", @"bb", [NSDate date]]],
        @"NSSet": [NSSet setWithArray:@[@"s1", @"s2", @"s3", @"s4", @"s5"]],
        @"NSNumber": @15,
        @"NSNull": [NSNull null],
        @"CGRect": [NSValue valueWithCGRect:rect],
    };
    
    NSDictionary *dict3 = @[];
    
    NSError *error;
    
    NSString *result = [Serializator serialize:dict error:&error];
        
    if(error){
        NSLog(@"error: %@", error);
    } else {
        NSLog(@"result: %@", result);
    }
}


@end
