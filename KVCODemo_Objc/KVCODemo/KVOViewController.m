//
//  KVOViewController.m
//  KVCODemo
//
//  Created by JW_Macbook on 18/02/2019.
//  Copyright © 2019 JW_Macbook. All rights reserved.
//

#import "KVOViewController.h"
#import "KVCObject.h"

@interface KVOViewController ()

@property (nonatomic, strong) KVCObject *kvcObject1;
@property (nonatomic, strong) KVCObject *kvcObject2;
@property (nonatomic, strong) KVCObject *kvcObject3;

@end

@implementation KVOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"KVO ViewDidLoad=====================");
    
    // 생성자.
    self.kvcObject1 = [[KVCObject alloc] init];
    
    // 1. KVO 등록하는 방법.
    [self.kvcObject1 addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    [self.kvcObject1 addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    
    // 값 변경해보기.
    [self.kvcObject1 setValue:@"KimJw(KVC)" forKey:@"name"];
    [self.kvcObject1 setValue:[NSNumber numberWithInteger:31] forKey:@"age"];
}

- (void) viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSLog(@"KVO ViewDidDisappear");
    // 2. KVO 해지하는 방법.
    [self.kvcObject1 removeObserver:self forKeyPath:@"name"];
    [self.kvcObject1 removeObserver:self forKeyPath:@"age"];
}


// 등록된 키값이 변경되면 알려주는 함수.
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if ([@"name" isEqualToString:keyPath]) {
        NSLog(@"이름이 변경되었습니다. [%@]",change);
    }
    /**
     이름이 변경되었습니다. [{
        kind = 1;
        new = "KimJw(KVC)";
        old = "";
     }]
     */
    
    if ([@"age" isEqualToString:keyPath]) {
        NSLog(@"나이가 변경되었습니다. [%@]",change);
    }
    /**
     나이가 변경되었습니다. [{
        kind = 1;
        new = 31;
        old = 0;
     }]
     */
    
}

@end
