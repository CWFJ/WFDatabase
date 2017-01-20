//
//  WFDatabase.m
//  WFDatabaseManager
//
//  Created by Jason on 2016/12/21.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "WFDatabase.h"
#import "WFTableManager.h"
#import "WFExtension.h"
#import "WFDBManager.h"

@implementation WFDatabase
/**************************************************
 *
 *  增
 *
 *************************************************/
+ (NSString *)insert:(id)objc {
    return [self insert:objc identifier:nil];
}

+ (NSString *)insert:(id)objc identifier:(NSString *)identifier {
    return [self insert:objc identifier:identifier map:nil];
}

+ (NSString *)insert:(id)objc identifier:(NSString *)identifier map:(NSDictionary *)map {
    return [self insert:objc identifier:identifier map:map list:nil];
}

+ (NSString *)insert:(id)objc identifier:(NSString *)identifier map:(NSDictionary *)map list:(NSArray *)list {
    
    Class objcClass = [objc class];
    
    if([objcClass isSubclassOfClass:[NSArray class]]) {
        /** 数组 */
        [((NSArray *)objc) enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self insert:obj identifier:identifier map:map list:list];
        }];
    }
    else if ([objcClass isSubclassOfClass:[NSDictionary class]]) {
        
    }
    else {
        NSString *tableName = [WFTableManager getTableNameWithClass:objcClass map:map list:list];
        NSDictionary *objcDict = [objc keyValuesWithMap:map];
        [WFDBManager insertWithTableName:tableName dataDict:objcDict];
    }
    
    return nil;
}

/**************************************************
 *
 *  查
 *
 *************************************************/
+ (NSMutableArray *)select:(Class)class identifier:(NSString *)identifier {
    
    return [self select:class identifier:identifier conditional:nil];
}

+ (NSMutableArray *)select:(Class)class identifier:(NSString *)identifier conditional:(NSString *)conditional {
    
    return [self select:class identifier:identifier conditional:conditional limit:NSIntegerMax];
}

+ (NSMutableArray *)select:(Class)class identifier:(NSString *)identifier conditional:(NSString *)conditional limit:(NSInteger)limit {
    
    NSMutableArray *dictArray = [WFDBManager selectWithTableName:identifier conditional:conditional limit:limit];
    
    return (NSMutableArray *)[class objcsWithDictArray:dictArray];
}
@end
