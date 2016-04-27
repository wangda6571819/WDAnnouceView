//
//  WDAnnouncementModel.h
//  WDAnnouceView
//
//  Created by fank on 16/4/27.
//  Copyright © 2016年 fank. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDAnnouncementModel : NSObject

@property (copy, nonatomic) NSArray *list;

@property (copy, nonatomic) NSString *durationTime;

@property (copy, nonatomic) NSString *open;

@property (copy, nonatomic) NSString *iconUrl;

+ (WDAnnouncementModel *)initWithDict:(NSDictionary *)dict;

@end

@interface WDSingleAnnouncementModel : NSObject

@property (copy, nonatomic) NSString *url;

@property (copy, nonatomic) NSString *title;

+ (WDSingleAnnouncementModel *)initWithDict:(NSDictionary *)dict;

@end