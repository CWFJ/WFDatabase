//
//  ViewController.m
//  WFDatabase
//
//  Created by Jason on 2017/1/20.
//  Copyright © 2017年 Jason. All rights reserved.
//

#import "ViewController.h"
#import "WFTestInfo.h"
#import "WFDatabase.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    WFTestInfo *info = [[WFTestInfo alloc] init];
    info.name = @"小明";
    info.array = @[@"小红", @"小刚", @"小黑"];
    info.dictionary = @{@"好朋友":@"小红", @"死党":@"小刚"};
    info.number = @(3);
    info.nsintm = 12;
    info.bol = YES;
    info.doub = 3.1415926;
    info.cgFloat = 3.1415;
    info.intm = 65535;
    info.charm = 'A';
    info.shortm = 1250;
    
//    [WFDatabase insert:info];
    
    NSArray *result = [WFDatabase select:[WFTestInfo class] identifier:@"WFTestInfo" conditional:@"intm > 10"];
    NSLog(@"%@", result);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
