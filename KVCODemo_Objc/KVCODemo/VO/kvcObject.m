//
//  KVCObject.m
//  KVCODemo
//
//  Created by JW_Macbook on 18/01/2019.
//  Copyright © 2019 JW_Macbook. All rights reserved.
//

#import "KVCObject.h"

@implementation KVCObject

- (instancetype)init {
    self = [super init];
    if (self) {
        self.name = @"";
        self.age = 0;
    }
    return self;
}

@end
