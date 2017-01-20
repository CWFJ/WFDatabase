//
//  WFTableInfo.h
//  WFDatabaseManager
//
//  Created by Jason on 2017/1/13.
//  Copyright © 2017年 Jason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WFTableInfo : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSDictionary *members;
@end
