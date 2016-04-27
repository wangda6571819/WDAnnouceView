//
//  WDAnnouncementModel.m
//  WDAnnouceView
//
//  Created by fank on 16/4/27.
//  Copyright © 2016年 fank. All rights reserved.
//

#import "WDAnnouncementModel.h"

@implementation WDAnnouncementModel

+ (WDAnnouncementModel *)initWithDict:(NSDictionary *)dict
{
    WDAnnouncementModel *model = [[WDAnnouncementModel alloc]init];
    model.list = [dict objectForKey:@"list"];
    model.durationTime = [dict objectForKey:@"durationTime"];
    model.open = [dict objectForKey:@"open"];
    return model;
}

@end

@implementation WDSingleAnnouncementModel

+ (WDSingleAnnouncementModel *)initWithDict:(NSDictionary *)dict
{
    WDSingleAnnouncementModel *model = [[WDSingleAnnouncementModel alloc]init];
    model.url = [dict objectForKey:@"url"];
    model.title = [dict objectForKey:@"title"];
    return model;
}

@end
