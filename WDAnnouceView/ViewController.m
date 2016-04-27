//
//  ViewController.m
//  WDAnnouceView
//
//  Created by fank on 16/4/27.
//  Copyright © 2016年 fank. All rights reserved.
//

#import "ViewController.h"
#import "WDAnnouceView.h"
#import "WDAnnouncementModel.h"
#define kScreenWidth                ([[UIScreen mainScreen] bounds].size.width)
#define kScreenHeight                ([[UIScreen mainScreen] bounds].size.height)

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    WDAnnouceView *view1 = [[WDAnnouceView alloc]initWithFrame:CGRectMake(0, 100, kScreenWidth, 35)];
    [self.view addSubview:view1];
    
    WDAnnouncementModel * model1 = [[WDAnnouncementModel alloc]init];
    WDSingleAnnouncementModel *list1 = [[WDSingleAnnouncementModel alloc]init];
    list1.url = @"www.baidu.com";
    list1.title = @"效果1";
    
    WDSingleAnnouncementModel *list2 = [[WDSingleAnnouncementModel alloc]init];
    list2.url = @"http://www.jianshu.com";
    list2.title = @"效果2";
    
    model1.list = @[list1,list2];
    model1.durationTime = @"3.0";
    model1.open = @"Y";
    
    [view1 updateListWithModel:model1];
    
    view1.textAnnouceHandle = ^(NSString * url){
        NSLog(@"%@",url);
    };
    
    WDAnnouceView *view2 = [[WDAnnouceView alloc]initWithFrame:CGRectMake(0, 200, kScreenWidth, 35)];
    [self.view addSubview:view2];
    
    WDAnnouncementModel * model2 = [[WDAnnouncementModel alloc]init];
    WDSingleAnnouncementModel *list11 = [[WDSingleAnnouncementModel alloc]init];
    list11.url = @"www.baidu.com";
    list11.title = @"效果1";
    
    WDSingleAnnouncementModel *list12 = [[WDSingleAnnouncementModel alloc]init];
    list12.url = @"http://www.jianshu.com";
    list12.title = @"效果2";
    
    model2.list = @[list11,list12];
    model2.durationTime = @"3.0";
    model2.open = @"Y";
    model2.iconUrl = @"testIcon";
    
    view2.textAnnouceHandle = ^(NSString * url){
        NSLog(@"%@",url);
    };
    
    [view2 updateListWithModel:model2];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
