//
//  WFDBManager.h
//  WFDatabaseManager
//
//  Created by Jason on 2017/1/13.
//  Copyright © 2017年 Jason. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WFTableInfo.h"

@interface WFDBManager : NSObject
+ (NSString *)createTable:(WFTableInfo *)info;
+ (BOOL)insertWithTableName:(NSString *)name dataDict:(NSDictionary *)data;
+ (NSMutableArray *)selectWithTableName:(NSString *)name conditional:(NSString *)conditional limit:(NSInteger)limit;
@end
