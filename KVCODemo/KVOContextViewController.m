//
//  KVOContextViewController.m
//  KVCODemo
//
//  Created by JW_Macbook on 18/02/2019.
//  Copyright © 2019 JW_Macbook. All rights reserved.
//

#import "KVOContextViewController.h"
#import "KVCObject.h"

// KVO Context 구분값 포인터정보.
static void *kvo1Context = &kvo1Context;
static void *kvo2Context = &kvo2Context;

@interface KVOContextViewController ()


@property (nonatomic, strong) KVCObject *kvcObject1;
@property (nonatomic, strong) KVCObject *kvcObject2;
@property (nonatomic, strong) KVCObject *kvcObject3;

@end

@implementation KVOContextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"KVO ViewDidLoad=====================");
    
    // 생성자.
    self.kvcObject1 = [[KVCObject alloc] init];
    
    // 1. KVO 등록하는 방법.
    [self.kvcObject1 addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:kvo1Context];
    [self.kvcObject1 addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:kvo1Context];
    
    // 값 변경해보기.
    [self.kvcObject1 setValue:@"KimJw(KVC)" forKey:@"name"];
    [self.kvcObject1 setValue:[NSNumber numberWithInteger:31] forKey:@"age"];
    
    // 두번쨰 값 등록.
    self.kvcObject2 = [[KVCObject alloc] init];
    [self.kvcObject2 addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:kvo2Context];
    
    // 값 변경해보기.
    [self.kvcObject2 setValue:@"ParkSJ" forKey:@"name"];
}

- (void) viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSLog(@"KVO ViewDidDisappear");
    // 2. KVO 해지하는 방법.
    [self.kvcObject1 removeObserver:self forKeyPath:@"name"];
    [self.kvcObject1 removeObserver:self forKeyPath:@"age"];
    
    [self.kvcObject2 removeObserver:self forKeyPath:@"name"];
}


// 등록된 키값이 변경되면 알려주는 함수.
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if (kvo1Context == context) {
        NSLog(@"KVO1 의 값임.");
        if ([@"name" isEqualToString:keyPath]) {
            NSLog(@"이름이 변경되었습니다. [%@]",change);
        }
        
        
        if ([@"age" isEqualToString:keyPath]) {
            NSLog(@"나이가 변경되었습니다. [%@]",change);
        }
    }
    
    if (kvo2Context == context) {
        NSLog(@"KVO2 의 값임.");
        if ([@"name" isEqualToString:keyPath]) {
            NSLog(@"이름이 변경되었습니다. [%@]",change);
        }
    }
    
}

@end
