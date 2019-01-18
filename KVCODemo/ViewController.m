//
//  ViewController.m
//  KVCODemo
//
//  Created by JW_Macbook on 06/01/2019.
//  Copyright © 2019 JW_Macbook. All rights reserved.
//

#import "ViewController.h"
#import "KVCObject.h"

@interface ViewController ()

@property (nonatomic, strong) KVCObject *kvcObject1;
@property (nonatomic, strong) KVCObject *kvcObject2;
@property (nonatomic, strong) KVCObject *kvcObject3;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 1. Property 의 이해 (기본, KVC)
    [self firstProperty];
    
    // 2. KVC KeyPath에 대한 예제
    [self secondKVCKeyPath];
}

/**
 1. 첫번째로 실험하는 기본적인 Property 값과 KVC를 통한 Property 값 실험.
 */
- (void)firstProperty {
    // 1. 기본적으로 사용하고 있는 방식.
    self.kvcObject1 = [[KVCObject alloc] init];
    self.kvcObject1.name = @"KimJw";
    self.kvcObject1.age = 31;
    NSLog(@"%@, %ld",self.kvcObject1.name, self.kvcObject1.age);
    // 예상된 결과값
    // KimJw, 31
    
    // 2. KVC 방식
    [self.kvcObject1 setValue:@"KimJw(KVC)" forKey:@"name"];
    [self.kvcObject1 setValue:[NSNumber numberWithInteger:31] forKey:@"age"];
    
    NSString *kvcObject1Name = [self.kvcObject1 valueForKey:@"name"];
    NSInteger kvcObject1Age = [[self.kvcObject1 valueForKey:@"age"] integerValue];
    NSLog(@"%@, %ld", kvcObject1Name, kvcObject1Age);
    // 예상된 결과값
    // KimJw(KVC), 31
    
    // 2-1. 문제점 발생시키기
    // key 값이 지정된 프로퍼티가 아닌경우에는 name -> namee 키값을 틀려봄.
    /**
    [self.kvcObject1 setValue:@"KimJw(KVC) Error" forKey:@"namee"];
     */
    //    *** Terminating app due to uncaught exception 'NSUnknownKeyException', reason: '[<KVCObject 0x600001758800> setValue:forUndefinedKey:]: this class is not key value coding-compliant for the key namee.'
    // 앱 크러시 발생 (키값을 매우 조심해야함.)
}


/**
 2. KVC 활용중 KeyPath에 대한 예제
 */
- (void)secondKVCKeyPath {

    // 1. 객체 내 객체 접근방식
    self.kvcObject2 = [[KVCObject alloc] init];
    [self.kvcObject2 setValue:@"ParkSJ" forKey:@"name"];
    [self.kvcObject2 setValue:[NSNumber numberWithInteger:28] forKey:@"age"];
    self.kvcObject2.kvcObject = [[KVCObject alloc] init];
    
    [self.kvcObject2 setValue:@"Ari" forKeyPath:@"kvcObject.name"];
    [self.kvcObject2 setValue:[NSNumber numberWithInteger:1] forKeyPath:@"kvcObject.age"];
    
    NSLog(@"%@, %ld", self.kvcObject2.kvcObject.name, self.kvcObject2.kvcObject.age);
    // 예상된 결과값.
    // Ari, 1
    
    // 2. 객체 내 객체 내 객체 접근방식
    self.kvcObject3 = [[KVCObject alloc] init];
    self.kvcObject3.kvcObject = [[KVCObject alloc] init];
    self.kvcObject3.kvcObject.kvcObject = [[KVCObject alloc] init];
    
    [self.kvcObject3 setValue:@"LeeHN" forKeyPath:@"kvcObject.kvcObject.name"];
    [self.kvcObject3 setValue:[NSNumber numberWithInteger:31] forKeyPath:@"kvcObject.kvcObject.age"];
    
    NSLog(@"%@, %ld", self.kvcObject3.kvcObject.kvcObject.name, self.kvcObject3.kvcObject.kvcObject.age);
    // 예상된 결과값.
    // LeeHN, 2
}


@end
