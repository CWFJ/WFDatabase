//
//  WFTableManager.m
//  WFDatabaseManager
//
//  Created by Jason on 2017/1/13.
//  Copyright © 2017年 Jason. All rights reserved.
//

#import "WFTableManager.h"
#import "NSObject+WFExtension.h"
#import "WFTableInfo.h"
#import "WFDBManager.h"
#import "WFDBUtil.h"

static NSMutableDictionary *_tables;

@implementation WFTableManager

/**
 创建一个新的表格

 @param info 新表信息
 @return 创建的新的表名
 */
+ (NSString *)createTable:(WFTableInfo *)info{
    NSString *tableName = [WFDBManager createTable:info];
    
    [_tables setValue:info.members forKey:tableName];
    
    return tableName;
}

+ (BOOL)dictionary:(NSDictionary *)small isSubDictionaryFor:(NSDictionary *)big {
    __block BOOL result = TRUE;
    
    if(!small || !big) return FALSE;
    
    [small enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        id value = big[key];
        if(!(value && [value isEqualToString:obj])) {
            result = FALSE;
            *stop = YES;
        }
    }];
    return result;
}

/**
 获取实际表名

 @param info 表信息
 @return 表名
 */
+ (NSString *)getTableName:(WFTableInfo *)info {
    
    NSString *tableName = nil;
    NSDictionary *srcMembers = _tables[info.name];
    
    if([self dictionary:info.members isSubDictionaryFor:srcMembers]) {
        /** 有表格可以存储 */
        tableName = info.name;
    }
    else {
        /** 无合适的表格存储 */
        tableName = [self createTable:info];
    }
    return tableName;
}

/**
 获取表名

 @param objClass 类
 @param map 属性名称映射
 @param list 存储属性列表
 @return 表名
 */
+ (NSString *)getTableNameWithClass:(Class)objClass map:(NSDictionary *)map list:(NSArray *)list {
    
    NSString *className = NSStringFromClass(objClass);
    NSMutableDictionary *members = [NSMutableDictionary dictionary];
    WFTableInfo *tableInfo = [WFTableInfo new];
    tableInfo.name= className;
    
    [objClass enumerateMembersUsingBlock:^(WFMember *member, BOOL *stop) {
        [members setValue:[WFDBUtil switchToSqlType:member.type] forKey:member.name];
    }];
    
    [map enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        id value = members[key];
        if(!value) return;
        
        [members removeObjectForKey:key];
        [members setValue:value forKey:obj];
    }];
    
    NSMutableDictionary *dstMembers = nil;
    
    if(list) {
        dstMembers = [NSMutableDictionary dictionaryWithCapacity:list.count];
        [list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [dstMembers setValue:members[obj] forKey:obj];
        }];
    }
    else {
        dstMembers = members;
    }
    
    tableInfo.members = dstMembers;
    
    return [self getTableName:tableInfo];
}

+ (void)initialize {
    _tables = [NSMutableDictionary dictionary];
}
@end
