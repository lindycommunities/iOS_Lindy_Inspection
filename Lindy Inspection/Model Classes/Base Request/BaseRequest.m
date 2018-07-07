//
//  BaseModel.m
//  AxisWallet
//
//  Created by Hemant Chittora on 03/06/15.
//  Copyright (c) 2015 Hemant Chittora. All rights reserved.
//

#import "BaseRequest.h"
#import <objc/runtime.h>
@implementation BaseRequest


- (NSDictionary *)dictionary {
    unsigned int count = 0;
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    for (int i = 0; i < count; i++) {
        
        NSString *key = [NSString stringWithUTF8String:property_getName(properties[i])];
        id value = [self valueForKey:key];
        
        if (value == nil) {
            // nothing todo
        }
        else if ([value isKindOfClass:[NSNumber class]]
                 || [value isKindOfClass:[NSString class]]
                 || [value isKindOfClass:[NSDictionary class]] || [value isKindOfClass:[NSMutableArray class]]) {
            // TODO: extend to other types
            [dictionary setObject:value forKey:key];
        }
        else if ([value isKindOfClass:[NSObject class]]) {
            [dictionary setObject:[value dictionary] forKey:key];
        }
        else {
            NSLog(@"Invalid type for %@ (%@)", NSStringFromClass([self class]), key);
        }
    }
    free(properties);
    return dictionary;
}

- (NSArray *)paramsOrderArray{
    
    //Blank method to avoid warning.
    return nil;
}

@end
