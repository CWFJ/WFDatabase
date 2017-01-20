//
//  WFDatabase.h
//  WFDatabaseManager
//
//  Created by Jason on 2016/12/21.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WFDatabase : NSObject
/**************************************************
 *
 *  增
 *
 *************************************************/
+ (NSString *)insert:(id)objc;
+ (NSString *)insert:(id)objc identifier:(NSString *)identifier;
+ (NSString *)insert:(id)objc identifier:(NSString *)identifier map:(NSDictionary *)map;
+ (NSString *)insert:(id)objc identifier:(NSString *)identifier map:(NSDictionary *)map list:(NSArray *)attributes;
/**************************************************
 *
 *  删
 *
 *************************************************/

/**************************************************
 *
 *  改
 *
 *************************************************/

/**************************************************
 *
 *  查
 *
 *************************************************/
+ (NSMutableArray *)select:(Class)class identifier:(NSString *)identifier;
+ (NSMutableArray *)select:(Class)class identifier:(NSString *)identifier conditional:(NSString *)conditional;
+ (NSMutableArray *)select:(Class)class identifier:(NSString *)identifier conditional:(NSString *)conditional limit:(NSInteger)limit;
@end
