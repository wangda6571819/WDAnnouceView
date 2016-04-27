//
//  WDAnnouceView.m
//  WDAnnouceView
//
//  Created by fank on 16/4/27.
//  Copyright © 2016年 fank. All rights reserved.
//

#import "WDAnnouceView.h"

#define kUserInterfaceIdiomIsPhone  (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define kScreenWidth                ([[UIScreen mainScreen] bounds].size.width)
#define kScreenHeight                ([[UIScreen mainScreen] bounds].size.height)
#define IS_IPHONE_6P                (kUserInterfaceIdiomIsPhone && kScreenHeight == 736.0)
#define IsNilOrNull(_ref)           (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]))
#define IsStrEmpty(_ref)            (IsNilOrNull(_ref) || (![(_ref) isKindOfClass:[NSString class]]) || ([(_ref) isEqualToString:@""]))

typedef NS_ENUM(NSInteger, WDNewsType) {
    WDNewsType_PureText, //纯文本公告
    WDNewsType_ImageWithText ,//图片文字公告
};


static CGFloat const kHeadImageMarginL_IPHONE_5_6 = 15;
static CGFloat const kHeadImageMarginL_IPHONE_6P = 22.5;

static CGFloat const kHeadImageW = 63;
static CGFloat const kHeadImageH = 13;

static CGFloat const kLineViewMarginL_IPHONE_5_6 = 15;
static CGFloat const kLineViewMarginL_IPHONE_6P = 22.5;
static CGFloat const kLineViewMarginR_IPHONE_5_6 = 10;
static CGFloat const kLineViewMarginR_IPHONE_6P = 15;

static CGFloat const kIconImageW = 12;
static CGFloat const kIconImageH = 12;
static CGFloat const kIconImageMarginR_IPHONE_5_6 = 7;
static CGFloat const kIconImageMarginR_IPHONE_6P = 10;

static CGFloat const kTextFieldSize_IPHONE_5_6 = 12;
static CGFloat const kTextFieldSize_IPHONE_6P = 14;

static CGFloat const kTextFieldMarginR_IPHONE_5_6 = 15;
static CGFloat const kTextFieldMarginR_IPHONE_6P = 22.5;


@interface WDSingleAnnouncementView ()

@property (strong, nonatomic) UILabel *titleLabel;

@end

@implementation WDSingleAnnouncementView

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        _titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont systemFontOfSize:kTextFieldSize_IPHONE_5_6];
        if (IS_IPHONE_6P) {
            _titleLabel.font = [UIFont systemFontOfSize:kTextFieldSize_IPHONE_6P];
        }
        [_titleLabel setLineBreakMode: NSLineBreakByTruncatingTail];
        _titleLabel.numberOfLines = 1;
    }
    return _titleLabel;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (void)updateWithModel:(id)model
{
    if ([model isKindOfClass:[WDSingleAnnouncementModel class]]) {
        WDSingleAnnouncementModel * singleAnnounceModel = (WDSingleAnnouncementModel *)model;
        if (IsStrEmpty(singleAnnounceModel.title)) {
            return;
        }
        [self.titleLabel setText:singleAnnounceModel.title];
    }
}

@end




@interface WDAnnouceView ()

@property (strong, nonatomic) WDSingleAnnouncementView *singleAnnouncementView;

@property (strong, nonatomic) NSArray *listArr;

@property (assign, nonatomic) NSInteger countInt;

@property (strong, nonatomic) NSTimer *timer;

@property (strong, nonatomic) UIImageView *headImageView;

@property (strong, nonatomic) UIView *lineView;

@property (strong, nonatomic) UIImageView *iconImageView;

@property (assign, nonatomic) WDNewsType newsType;

@property (strong, nonatomic) UIButton *newsButton;

@property (assign, nonatomic) NSInteger timeDuration;

@end

@implementation WDAnnouceView

- (UIButton *)newsButton
{
    if (!_newsButton) {
        _newsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _newsButton.backgroundColor = [UIColor clearColor];
        [_newsButton setFrame:CGRectZero];
    }
    return _newsButton;
}

- (UIImageView *)headImageView
{
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _headImageView;
}


- (UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectZero];
        [_lineView setBackgroundColor:[UIColor blackColor]];
    }
    return _lineView;
}

- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [_iconImageView setImage:[UIImage imageNamed:@"announcement_speaker_icon"]];
    }
    return _iconImageView;
}

- (WDSingleAnnouncementView *)singleAnnouncementView
{
    if (!_singleAnnouncementView) {
        _singleAnnouncementView = [[WDSingleAnnouncementView alloc] initWithFrame:CGRectZero];
    }
    return _singleAnnouncementView;
}

- (void)dealloc
{
    //取消定时器
    if ([self.timer isValid]) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (NSArray *)listArr
{
    if (!_listArr) {
        _listArr = [NSArray array];
    }
    return _listArr;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        [self addSubview:self.singleAnnouncementView];
        [self addSubview:self.headImageView];
        [self addSubview:self.iconImageView];
        [self addSubview:self.lineView];
        [self addSubview:self.newsButton];
        self.countInt = 0;
        self.timeDuration = 3;
        self.newsType = WDNewsType_PureText;
    }
    
    return self;
}

- (void)displayNews
{
    self.countInt++;
    if (self.countInt >= [self.listArr count])
        self.countInt = 0;
    
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 0.3f ;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = YES;
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromTop;
    
    [self.singleAnnouncementView.layer addAnimation:animation forKey:@"animationID"];
    
    if (self.countInt >= 0 && self.countInt < self.listArr.count) {
        [self.singleAnnouncementView updateWithModel:self.listArr[self.countInt]];
    }
}

- (void)announceViewClicked:(id)sender
{
    if (self.textAnnouceHandle) {
        if (self.countInt >= 0 && self.countInt < self.listArr.count) {
            WDSingleAnnouncementModel *singleModel = (WDSingleAnnouncementModel *)self.listArr[self.countInt];
            self.textAnnouceHandle(singleModel.url);
        }
    }
}

- (void)updateListWithModel:(WDAnnouncementModel *)model
{
    if ([model.open isEqualToString:@"Y"]) {
        [self updateListWithViewModel:model.list annoucementUrl:model.iconUrl animateDuration:model.durationTime];
    }else{
        [self setFrame:CGRectMake(0, 0, 0, 0)];
    }
}

- (void)updateListWithViewModel:(NSArray *)list annoucementUrl:(NSString *)annoucementUrl animateDuration:(NSString *)durationTime
{
    if (IsStrEmpty(annoucementUrl)) {
        self.newsType = WDNewsType_PureText;
    } else {
        self.newsType = WDNewsType_ImageWithText;
    }
    
    //持续时间 durationTime
    if ([durationTime intValue]>0) {
        self.timeDuration = [durationTime intValue];
    }
    
    [self updateListWithViewModel:list];
    
    //不可动图 annoucementUrl
    if (!IsStrEmpty(annoucementUrl)) {
        [self.headImageView setImage:[UIImage imageNamed:annoucementUrl]];
    }
}

- (void)updateListWithViewModel:(NSArray *)list animateDuration:(NSString *)durationTime
{
    [self updateListWithViewModel:list annoucementUrl:nil animateDuration:durationTime];
}

- (void)updateListWithViewModel:(NSArray *)list
{
    if (list.count == 0) {
        return;
    }
    self.listArr = list;
    [self reloadAnnounceView];
}

- (void)reloadAnnounceView
{
    [self.newsButton addTarget:self action:@selector(announceViewClicked:) forControlEvents:UIControlEventTouchDown];
    if (self.countInt >= 0 && self.countInt < self.listArr.count) {
        [self.singleAnnouncementView updateWithModel:self.listArr[self.countInt]];
        [self startBannerTimer];
    }
    //适配  5  6  6p 做相应调整
    CGFloat headImageMarginL = 0.0f;
    CGFloat lineViewMarginL = 0.0f;
    CGFloat textFieldMarginR = 0.0f;
    CGFloat iconImageMarginR = 0.0f;
    CGFloat lineViewMarginR = 0.0f;
    if (IS_IPHONE_6P) {
        headImageMarginL = kHeadImageMarginL_IPHONE_6P;
        lineViewMarginL = kLineViewMarginL_IPHONE_6P;
        textFieldMarginR = kTextFieldMarginR_IPHONE_6P;
        iconImageMarginR = kIconImageMarginR_IPHONE_6P;
        lineViewMarginR = kLineViewMarginR_IPHONE_6P;
    }else{
        headImageMarginL = kHeadImageMarginL_IPHONE_5_6;
        lineViewMarginL = kLineViewMarginL_IPHONE_5_6;
        textFieldMarginR = kTextFieldMarginR_IPHONE_5_6;
        iconImageMarginR = kIconImageMarginR_IPHONE_5_6;
        lineViewMarginR = kLineViewMarginR_IPHONE_5_6;
    }
    
    if (self.newsType == WDNewsType_PureText) {
        [self.iconImageView setFrame:CGRectMake(CGRectGetMaxX(self.lineView.frame)+iconImageMarginR, (CGRectGetHeight(self.frame)-kIconImageH)/2 , kIconImageW, kIconImageH)];
        [self.singleAnnouncementView setFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame)+iconImageMarginR, 0, CGRectGetWidth(self.frame)-CGRectGetMaxX(self.iconImageView.frame)-iconImageMarginR-textFieldMarginR, CGRectGetHeight(self.frame))];
        
    } else {
        [self.headImageView setFrame:CGRectMake(headImageMarginL, (CGRectGetHeight(self.frame)-kHeadImageH)/2, kHeadImageW, kHeadImageH)];
        [self.lineView setFrame:CGRectMake(CGRectGetMaxX(self.headImageView.frame)+lineViewMarginL, (CGRectGetHeight(self.frame)-20)/2, 1, 20)];
        [self.iconImageView setFrame:CGRectMake(CGRectGetMaxX(self.lineView.frame)+lineViewMarginR, (CGRectGetHeight(self.frame)-kIconImageH)/2 , kIconImageW, kIconImageH)];
        [self.singleAnnouncementView setFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame)+iconImageMarginR, 0, CGRectGetWidth(self.frame)-CGRectGetMaxX(_iconImageView.frame)-iconImageMarginR-textFieldMarginR, CGRectGetHeight(self.frame))];
    }
    
    [self.newsButton setFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
}

- (void)stopBannerTimer
{
    if ([self.timer isValid]) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)startBannerTimer
{
    if ([self.timer isValid]) {
        [self.timer invalidate];
        self.timer = nil;
    }
    if (self.countInt < 0 || self.countInt >= self.listArr.count) {
        return;
    }
    //设置定时器
    [self.singleAnnouncementView updateWithModel:self.listArr[self.countInt]];
    if (self.listArr.count == 1) {
        return;
    }
    
    if (self.timer == nil) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:self.timeDuration target:self selector:@selector(displayNews) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
}

@end
