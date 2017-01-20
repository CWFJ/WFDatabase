//
//  WFDBManager.m
//  WFDatabaseManager
//
//  Created by Jason on 2017/1/13.
//  Copyright © 2017年 Jason. All rights reserved.
//

#import "WFDBManager.h"
#import "FMDB.h"

static FMDatabaseQueue *_dbQueue;

@implementation WFDBManager

+ (NSString *)createTable:(WFTableInfo *)info {
    
    __block NSString *tableName = nil;
    NSMutableString *memberList = [NSMutableString string];
    
    [info.members enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [memberList appendString:[NSString stringWithFormat:@", %@ %@", key, obj]];
    }];
    
    /** 构造sql语句 */
    NSMutableString *sql = [NSMutableString stringWithFormat:@"create table if not exists %@ (id integer primary key AUTOINCREMENT%@);", info.name, memberList];

    // 创表
    [_dbQueue inDatabase:^(FMDatabase *db) {
        BOOL result = [db executeUpdate:sql];
        if (result) {
            tableName = info.name;
            NSLog(@"创表成功");
        } else {
            NSLog(@"创表失败");
        }
    }];
    return info.name;
}

+ (BOOL)insertWithTableName:(NSString *)name dataDict:(NSDictionary *)data {
    __block BOOL result = FALSE;
    
    [_dbQueue inDatabase:^(FMDatabase *db) {
        NSMutableString *keys = [NSMutableString string];
        
        [data.allKeys enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL * _Nonnull stop) {
            [keys appendString:[NSString stringWithFormat:@",:%@", key]];
        }];
        NSMutableString *colonKeys = [NSMutableString stringWithString:keys];
        [keys replaceOccurrencesOfString:@":" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, keys.length)];
        NSString *sql = [NSString stringWithFormat:@"insert into %@(%@) values(%@)",  name, [keys substringFromIndex:1], [colonKeys substringFromIndex:1]];
        result = [db executeUpdate:sql withParameterDictionary:data];
    }];
    
    return result;
}

+ (NSMutableArray *)selectWithTableName:(NSString *)name conditional:(NSString *)conditional limit:(NSInteger)limit {
    
    __block NSMutableArray *results = [NSMutableArray array];
    
    [_dbQueue inDatabase:^(FMDatabase *db) {
        NSString *conditionSql = @"";
        if (conditional.length > 0) {
            conditionSql = [NSString stringWithFormat:@"WHERE %@", conditional];
        }
        
        NSMutableString *sql = [NSMutableString stringWithFormat:@"select * from %@ %@;", name, conditionSql];
        FMResultSet *rs = [db executeQuery:sql];
        
        while (rs.next) {
            NSMutableDictionary *objc = [NSMutableDictionary dictionaryWithCapacity:rs.columnCount];
            
            [[rs columnNameToIndexMap].allKeys enumerateObjectsUsingBlock:^(NSString *name, NSUInteger idx, BOOL * _Nonnull stop) {
                [objc setValue:[rs objectForColumnName:name] forKey:name];
            }];
            [results addObject:objc];
        }
    }];
    return results;
}

+ (void)initialize {
    NSString *fileName = @"WFDB.db";
    NSString *dir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [dir stringByAppendingPathComponent:fileName.lastPathComponent];
    
    _dbQueue = [FMDatabaseQueue databaseQueueWithPath:filePath];
    
}
@end
