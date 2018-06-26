//
//  Person.m
//  TestDemo
//
//  Created by Jack on 2018/3/23.
//  Copyright © 2018年 Jack. All rights reserved.
//  消息转发机制

#import "Person.h"
#import <objc/runtime.h>
#import "Bird.h"
#import "Monkey.h"

void speak (id self, SEL _cmd, id value);

id eat (id self, SEL _cmd);

@implementation Person

void speak (id self, SEL _cmd, id value){
    NSLog(@"i can speak");
}

id eat (id self, SEL _cmd){
    NSLog(@"eat apple");
    return @"apple";
}

//动态方法解析---实例方法
+ (BOOL)resolveInstanceMethod:(SEL)sel{
    NSLog(@"%s===%@",__func__,NSStringFromSelector(sel));
    NSString *selector = NSStringFromSelector(sel);
    if ([selector isEqualToString:@"speak"]) {
        class_addMethod([self class], sel, (IMP)speak, "v@:@");
        return YES;
    }
    if([selector isEqualToString:@"eat"]){
        class_addMethod([self class], sel, (IMP)eat, "@@:");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}

//类方法
//+ (BOOL)resolveClassMethod:(SEL)sel{
//    return [super resolveClassMethod:sel];
//}

//备援接收者---再此我们可以模拟出“多重继承”的特性;如果无法处理经由这一步转发的消息，若想在发送给备援接受者之前先修改x消息内容的话，那就得通过完整的消息转发机制来做
- (id)forwardingTargetForSelector:(SEL)aSelector{
    NSLog(@"%s===%@",__func__,NSStringFromSelector(aSelector));
    Bird *bid = [[Bird alloc] init];
    if ([bid respondsToSelector:aSelector]) {
        return bid;
    }
    return [super forwardingTargetForSelector:aSelector];
}

//完整的消息转发机制
/**
    启用完整的消息转发机制首先需要创建一个NSInvocation对象，把尚未处理的消息有关的全部细节全部封装到NSInvocation对象中（包含选择子（SEL）,目标（target）以及参数），在触发NSInvocation对象时，消息派发系统亲自出面将消息指派给目标对象；启动完整的消息转发机制
 */
//此方法只是修改了方法调用的目标对象，使方法在新的目标对象得以调用；最终这种方法和备援接收者方案所实现的方法是等效的；比较有用的实现方式是：在触发消息之前，以某种方式修改方法的内容，比如修改方法的选择子（SEL），追加参数等等；
- (void)forwardInvocation:(NSInvocation *)anInvocation{
    NSLog(@"%s",__func__);
    if (anInvocation.selector == @selector(jump)) {
        Monkey *monkey = [[Monkey alloc] init];
        [anInvocation invokeWithTarget:monkey];
    }
}

//在调用上面方法之前会先调用下面的方法来获取方法的签名
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    NSLog(@"%s===%@",__func__,NSStringFromSelector(aSelector));
    if (aSelector == @selector(jump)) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:@"];
    }
    return [super methodSignatureForSelector:aSelector];
}

- (void)doesNotRecognizeSelector:(SEL)aSelector{
    NSLog(@"没有对应的实现");
}

@end
