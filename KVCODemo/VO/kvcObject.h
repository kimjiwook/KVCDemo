//
//  KVCObject.h
//  KVCODemo
//
//  Created by JW_Macbook on 18/01/2019.
//  Copyright © 2019 JW_Macbook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KVCObject : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic) NSInteger age;

// 객체를 추가하도록 하겠습니다.
@property (nonatomic, strong) KVCObject *kvcObject;

@end
