//
//  XWInterviewDemosTests.m
//  XWInterviewDemosTests
//
//  Created by 邱学伟 on 2018/7/12.
//  Copyright © 2018年 邱学伟. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <objc/runtime.h>
#import "XWPerson.h"

typedef NS_OPTIONS(NSUInteger, XWDirection) {
    XWDirectionTop          = 0,
    XWDirectionBottom       = 1 << 0,
    XWDirectionLeft         = 1 << 1,
    XWDirectionRight        = 1 << 2,
};

typedef NS_ENUM(NSUInteger, SexType) {
    SexTypeMale,
    SexTypeFemale,
    SexTypeUnknow,
};
@interface XWInterviewDemosTests : XCTestCase 
@property (nonnull, strong) NSMutableArray *arrayM;
@end

@implementation XWInterviewDemosTests
static const NSTimeInterval kAnimationDuration = 0.3;
NSString * const XWTestViewNoticationName = @"XWTestViewNoticationName";

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    self.arrayM = [NSMutableArray array];
    for (NSUInteger i = 0; i < 1000; i++) {
        XWPerson *person = [[XWPerson alloc] init];
        [_arrayM addObject:person];
    }
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testBlockEnum {
    NSArray *array = @[@1,@2,@3];
    NSLog(@"array.count: %zd",array.count);
    CFArrayRef arrayRef = (__bridge CFArrayRef)array;
    NSLog(@"arrayRef: %zd",CFArrayGetCount(arrayRef));
    
    return;
    NSDictionary *dictionary = @{
                                 @"key1":@"value1",
                                 @"key2":@"value2",
                                 @"key3":@"value3"
                                 };
    NSSet *set = [NSSet setWithObjects:@4,@5,@6, nil];
    /// array
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"array - idx:%zd - obj:%@",idx,obj);
    }];
    
    /// dictionary
    [dictionary enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSLog(@"dictionary - key:%@  value:%@",key,obj);
    }];
    
    /// set
    [set enumerateObjectsUsingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSLog(@"set - %@",obj);
    }];
}

- (void)testForIn {
    NSArray *array = @[@1,@2,@3];
    NSDictionary *dictionary = @{
                                 @"key1":@"value1",
                                 @"key2":@"value2",
                                 @"key3":@"value3"
                                 };
    NSSet *set = [NSSet setWithObjects:@4,@5,@6, nil];
    /// array
    for (NSNumber *obj in array) {
        NSLog(@"array - %@",obj);
    }
    
    /// dictionary
    for (NSString *key in dictionary) {
        NSLog(@"dictionary - key:%@  value:%@",key,dictionary[key]);
    }
    
    /// set
    for (NSNumber *setObject in set) {
        NSLog(@"set - %@",setObject);
    }
}

- (void)testEnumerator {
    NSArray *array = @[@1,@2,@3];
    NSDictionary *dictionary = @{
                                 @"key1":@"value1",
                                 @"key2":@"value2",
                                 @"key3":@"value3"
                                 };
    NSSet *set = [NSSet setWithObjects:@4,@5,@6, nil];
    /// array
    NSEnumerator *arrayEnumerator = [array objectEnumerator];
    id object;
    while ((object = arrayEnumerator.nextObject) != nil) {
        NSLog(@"array-%@",object);
    }
    
    /// dictionary
    NSEnumerator *dictionaryEnumerator = [dictionary keyEnumerator];
    id value,key;
    while ((key = dictionaryEnumerator.nextObject) != nil) {
        value = dictionary[key];
        NSLog(@"dictionary - key:%@  value:%@",key,value);
    }
    
    /// set
    NSEnumerator *setEnumerator = [set objectEnumerator];
    id setObject;
    while ((setObject = setEnumerator.nextObject) != nil) {
        NSLog(@"set - %@",setObject);
    }
}


- (void)testClassMethod { //  passed (29.695 seconds).   passed (30.781 seconds).  passed (30.595 seconds). passed (30.538 seconds).
    for (NSUInteger i = 0; i < 99999; i++) {
        [XWPerson log];
    }
}


- (void)testObjectMethod {  //passed (30.392 seconds).    passed (30.906 seconds).  passed (31.359 seconds).  passed (31.864 seconds).  passed (36.324 seconds).
    XWPerson *person = [self.arrayM lastObject];
    for (NSUInteger i = 0; i < 99999; i++) {
        [person log];
    }
}


- (void)testAssociate {
    // Setter 方法
//    objc_setAssociatedObject(id  _Nonnull object, const void * _Nonnull key, id  _Nullable value, objc_AssociationPolicy policy)
//
//    // Getter 方法
//    objc_getAssociatedObject(id  _Nonnull object, const void * _Nonnull key)
//
//    // 移除指定对象的所有关联对象值
//    objc_removeAssociatedObjects(id  _Nonnull object)
}




- (void)testStraight {
    NSDictionary *info1 = [NSDictionary dictionaryWithObjectsAndKeys:@"极客学伟",@"name",[NSNumber numberWithInteger:18],@"age", nil];
    NSString *name1 = [info1 objectForKey:@"name"];
    NSDictionary *info2 = @{@"name":@"极客学伟",
                            @"age":@18,};
    NSString *name2 = info2[@"name"];

    NSMutableArray *arrayM = @[@1,@"123",@"567"].mutableCopy;
    NSMutableDictionary *dictM;
//    [arrayM replaceObjectAtIndex:0 withObject:@"new Object"];
    [dictM setObject:@19 forKey:@"age"];
    
//    arrayM[0] = @"new Object";
    dictM[@"age"] = @19;
    
    [info1 isMemberOfClass:[NSDictionary class]];
}

- (void)testObjectiveC {
    NSString *theString = @"Hello World";
    NSString *theString2 = @"Hello World";
    NSLog(@"theString:%p --- theString:2%p",theString,theString2);
    
    theString2 = @"Hello World !!!!";
    NSLog(@"theString:%p --- theString:2%p",theString,theString2);
}



- (void)testDeadlock {
    NSLog(@"test begin ... %@",[NSThread currentThread]);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{    
        [self deadlockDemo];
    });
    NSLog(@"test end ... %@",[NSThread currentThread]);
}


- (void)deadlockDemo {
    NSLog(@"start   %@",[NSThread currentThread]);
    
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"哈哈哈... %@",[NSThread currentThread]);
    });
    NSLog(@"end     %@",[NSThread currentThread]);
}

- (void)testGCDApply {
    //passed (2.745 seconds). /// 同步串行
//    dispatch_queue_t queue = dispatch_queue_create("com.beijing", 0);
//    dispatch_apply(10000, queue, ^(size_t index) {
//        NSLog(@"Thread : %@   ----  %zu",[NSThread currentThread],index);
//    });
    
    /// 异步串行 (内部会顺序执行)  1.426 s
//    dispatch_queue_t queueConcurrent = dispatch_queue_create("com.beijing", DISPATCH_QUEUE_CONCURRENT);
//    dispatch_apply(10000, queueConcurrent, ^(size_t index) {
//        NSLog(@"Thread : %@   ----  %zu",[NSThread currentThread],index);
//    });
    
    //passed (2.534 seconds). (串行)
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_apply(10000, queue, ^(size_t index) {
//        NSLog(@"Thread : %@   ----  %zu",[NSThread currentThread],index);
//    });
//
    //passed (3.018 seconds). passed (2.765 seconds).
//    for (int i = 0; i < 10000; i++) {
//         NSLog(@"Thread : %@   ----  %d",[NSThread currentThread],i);
//    }
    
    // passed (2.968 seconds). passed (3.178 seconds).
//    for (NSInteger i = 0; i < 10000; i++) {
//        NSLog(@"Thread : %@   ----  %ld",[NSThread currentThread],(long)i);
//    }
    
    
}

- (void)testArrayDeal {
    NSMutableArray *array = @[@1,@2,@3].mutableCopy;
    
    [self arrayDeal:array];
    
    NSLog(@"array  : %@",array);
}

- (void)arrayDeal:(NSMutableArray *)arrayM {
    [arrayM insertObject:@"10086" atIndex:0];
}


// 冒泡3-优化
- (void)testSort3Array {
    NSUInteger count = 0;
    BOOL isNonSorted = YES;
    //@[@16,@1,@2,@9,@7,@12,@5,@3,@8,@13,@10]
    NSMutableArray *array = @[@16,@122,@9,@7,@6,@5,@4,@3,@2,@1].mutableCopy;
    for (int i = 0; i < array.count && isNonSorted; i++) {
        isNonSorted = NO;
        for (int j = (int)array.count - 2; j >= i; j--) {
            count++;
            NSNumber *objPre = array[j];
            NSNumber *objNext = array[j+1];
            if (objPre.integerValue < objNext.integerValue) {
                [array exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                isNonSorted = YES;
            }
        }
        [self logArr:array];
    }
    NSLog(@"%lu 次比较!!",(unsigned long)count); //17
}

// 冒泡2
- (void)testSort2Array {
    NSUInteger count = 0;
    NSMutableArray *array = @[@16,@122,@9,@7,@6,@5,@4,@3,@2,@1].mutableCopy;
    for (int i = 0; i < array.count; i++) {
        for (int j = (int)array.count - 2; j >= i; j--) {
            count++;
            NSNumber *objPre = array[j];
            NSNumber *objNext = array[j+1];
            if (objPre.integerValue < objNext.integerValue) {
                [array exchangeObjectAtIndex:j withObjectAtIndex:j+1];
            }
        }
        [self logArr:array];
    }
    NSLog(@"%lu 次比较!!",(unsigned long)count); //45
}

// 冒泡1
- (void)testSort1Array {
    NSUInteger count = 0;
    NSMutableArray *array = @[@16,@122,@9,@7,@6,@5,@4,@3,@2,@1].mutableCopy;
    for (int i = 0; i < array.count; i++) {
        for (int j = i+1; j < array.count; j++) {
            count++;
            NSNumber *objPre = array[i];
            NSNumber *objNext = array[j];
            if (objPre.integerValue < objNext.integerValue) {
                [array exchangeObjectAtIndex:i withObjectAtIndex:j];
            }
        }
        [self logArr:array];
    }
    [self logArr:array];
    NSLog(@"%lu 次比较!!",(unsigned long)count); //45 次比较
}
- (void)logArr:(NSMutableArray * )array {
    NSString * str = @"";
    for (NSNumber * value in array) {
        str = [str stringByAppendingString:[NSString stringWithFormat:@"%zd ",[value integerValue]]];
    }
    NSLog(@"%@",str);
}


- (void)testExample {
    NSString *ip = @"1.1.1.1";
    XCTAssertTrue([self ipIsValidity2:ip]);
}

//正则:
//String ipRegEx = "^([1-9]|([1-9][0-9])|(1[0-9][0-9])|(2[0-4][0-9])|(25[0-5]))(\\.([0-9]|([1-9][0-9])|(1[0-9][0-9])|(2[0-4][0-9])|(25[0-5]))){3}$";
//String ipRegEx = "^([1-9]|([1-9]\\d)|(1\\d{2})|(2[0-4]\\d)|(25[0-5]))(\\.(\\d|([1-9]\\d)|(1\\d{2})|(2[0-4]\\d)|(25[0-5]))){3}$";
//String ipRegEx = "^(([1-9]\\d?)|(1\\d{2})|(2[0-4]\\d)|(25[0-5]))(\\.(0|([1-9]\\d?)|(1\\d{2})|(2[0-4]\\d)|(25[0-5]))){3}$";
- (BOOL)ipIsValidity2:(NSString *)ip {
    NSString  *isIP = @"^([1-9]|([1-9][0-9])|(1[0-9][0-9])|(2[0-4][0-9])|(25[0-5]))(\\.([0-9]|([1-9][0-9])|(1[0-9][0-9])|(2[0-4][0-9])|(25[0-5]))){3}$";
    NSRegularExpression *regular = [[NSRegularExpression alloc] initWithPattern:isIP options:0 error:nil];
    NSArray *results = [regular matchesInString:ip options:0 range:NSMakeRange(0, ip.length)];
    return results.count > 0;
}

- (BOOL)ipIsValidity1:(NSString *)ip {
//    (1~255).(0~255).(0~255).(0~255)
    if (!ip || ip.length < 7 || ip.length > 15) {
        return NO;
    }
    
    //首末字符判断，如果是"."则是非法IP
    if ([[ip substringToIndex:1] isEqualToString:@"."]) {
        return NO;
    }
    if ([[ip substringFromIndex:ip.length - 1] isEqualToString:@"."]) {
        return NO;
    }
    
    NSArray <NSString *> *subIPArray = [ip componentsSeparatedByString:@"."];
    if (subIPArray.count != 4) {
        return NO;
    }
    
    for (NSInteger i = 0; i < 4; i++) {
        NSString *subIP = subIPArray[i];
        
        if (subIP.length > 1 && [[subIP substringToIndex:1] isEqualToString:@"0"]) {
            //避免出现 01.  011.
            return NO;
        }
        for (NSInteger j = 0; j < subIP.length; j ++) {
            char temp = [subIP characterAtIndex:j];
            if (temp < '0' || temp > '9') {
                //避免出现 11a.19b.s.s
                return NO;
            }
        }
        
        NSInteger subIPInteger = subIP.integerValue;
        if (i == 0) {
            if (subIPInteger < 1 || subIPInteger > 255) {
                return NO;
            }
        }else{
            if (subIPInteger < 0 || subIPInteger > 255) {
                return NO;
            }
        }
    }
    return YES;
}

@end
