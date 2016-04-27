//
//  WDAnnouceView.h
//  WDAnnouceView
//
//  Created by fank on 16/4/27.
//  Copyright © 2016年 fank. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WDAnnouncementModel.h"

typedef void(^TextAnnouceHandele)(NSString *url);

@interface WDAnnouceView : UIView

- (void)stopBannerTimer;
- (void)startBannerTimer;

- (void)updateListWithModel:(WDAnnouncementModel *)model;
- (void)updateListWithViewModel:(NSArray *)list annoucementUrl:(NSString *)annoucementUrl animateDuration:(NSString *)durationTime;
- (void)updateListWithViewModel:(NSArray *)list animateDuration:(NSString *)durationTime;
-(void)updateListWithViewModel:(NSArray *)list;
@property (copy, nonatomic) TextAnnouceHandele textAnnouceHandle;

@end

@interface WDSingleAnnouncementView : UIView

- (void)updateWithModel:(id)model;

@end
