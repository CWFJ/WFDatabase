//
//  WFDBUtil.m
//  WFDatabaseManager
//
//  Created by Jason on 2017/1/17.
//  Copyright © 2017年 Jason. All rights reserved.
//

#import "WFDBUtil.h"

@implementation WFDBUtil


+ (NSString *)baseTypeSwitch:(NSString *)type {
    static NSDictionary *switchTable;
    if(!switchTable) {
        /*
         *          c    ---    char
         *          i    ---    int
         *          f    ---    float
         *          d    ---    double
         *          q    ---    long
         *          q    ---    long long
         *          q    ---    NSInteger
         *          Q    ---    NSUInteger
         *          d    ---    CGFloat
         */
        switchTable = @{
                        @"B":@"interger",
                        @"c":@"char",
                        @"i":@"interger",
                        @"f":@"float",
                        @"d":@"double",
                        @"q":@"interger",
                        @"Q":@"interger",
                        @"s":@"interger",
                        };
    }
    return switchTable[type];
}

+ (NSString *)kitTypeSwitch:(NSString *)type {

    static NSDictionary *switchTable;
    
    if(!switchTable) {
        switchTable = @{
                        @"NSPoint":@"text",
                        @"_NSRange":@"text",
                        @"NSRect":@"text",
                        @"NSSize":@"text",
                        @"UIEdgeInsets":@"text",
                        @"CGAffineTransform":@"text",
                        };
    }
    
    /** 揪出类型 */
    NSString *realType = type;
    NSInteger location = [type rangeOfString:@"="].location;
    if (location > 1) {
        realType = [type substringWithRange:NSMakeRange(1, location - 1)];
    }
    
    return switchTable[realType];
}

+ (NSString *)switchToSqlType:(NSString *)type {

    static NSDictionary *srcClass;
    NSString *rtnType = nil;
    
    
    if(!srcClass) {
        srcClass = @{
                     @"B":@"interger",
                     @"c":@"char",
                     @"i":@"interger",
                     @"f":@"float",
                     @"d":@"double",
                     @"q":@"interger",
                     @"Q":@"interger",
                     @"s":@"interger",
                     
                     @"NSString":@"text",
                     @"__NSCFConstantString":@"text",
                     @"NSURL":@"text",
                     
                     @"NSArray":@"blob",
                     @"NSDictionary":@"blob",
                     
                     @"NSNumber":@"text",
                     @"NSValue":@"text",
                     
                     @"CGPoint":@"text",
                     @"_NSRange":@"text",
                     @"CGRect":@"text",
                     @"CGSize":@"text",
                     @"UIEdgeInsets":@"text",
                     @"CGAffineTransform":@"text",
                     };
    }
    
    NSString *realType = type;
    NSInteger location = [type rangeOfString:@"="].location;
    
    if (location != NSNotFound) {
        realType = [type substringWithRange:NSMakeRange(1, location - 1)];
    }
    
//    NSString *foundationType = @"BcifqdQs";
//    
//    if([foundationType rangeOfString:type].length == 1){
//        rtnType = [self baseTypeSwitch:type];
//    }
//    else if([type rangeOfString:@"CG"].location != NSNotFound) {
//        rtnType = [self kitTypeSwitch:type];
//    }
//    else {
        rtnType = srcClass[realType];
//    }
    
    if(!rtnType) return @"blob";  // 不支持的类型
    
    return rtnType;
}
@end
