//
//  WFTableManager.h
//  WFDatabaseManager
//
//  Created by Jason on 2017/1/13.
//  Copyright © 2017年 Jason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WFTableManager : NSObject
+ (NSString *)getTableNameWithClass:(Class)objClass map:(NSDictionary *)map list:(NSArray *)list;
@end
