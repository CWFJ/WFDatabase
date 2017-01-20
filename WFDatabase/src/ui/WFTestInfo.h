//
//  WFTestInfo.h
//  WFDatabaseManager
//
//  Created by Jason on 2017/1/12.
//  Copyright © 2017年 Jason. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WFTestInfo : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) NSDictionary *dictionary;
@property (nonatomic, strong) NSNumber *number;
@property (nonatomic, assign) NSInteger nsintm;

//@property (nonatomic, assign) CGPoint point;
//@property (nonatomic, assign) NSRange range;
//@property (nonatomic, assign) CGRect rect;
//@property (nonatomic, assign) CGSize size;
//@property (nonatomic, assign) UIEdgeInsets insets;
//@property (nonatomic, assign) CGAffineTransform transform;

@property (nonatomic, assign) BOOL bol;
@property (nonatomic, assign) double doub;
@property (nonatomic, assign) CGFloat cgFloat;
@property (nonatomic, assign) int intm;
@property (nonatomic, assign) char charm;
@property (nonatomic, assign) short shortm;
@end

