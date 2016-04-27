# WDAnnouceView
##类似淘宝头条的滚动效果
![](https://github.com/wangda6571819/WDAnnouceView/blob/master/1.png)
## 现有两种类型,纯文本的文字公告滚动,带一张样图的图片公告
![](https://github.com/wangda6571819/WDAnnouceView/blob/master/2.PNG)
### WDAnnouncementModel * model1 = [[WDAnnouncementModel alloc]init];
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
    
    //点击事件
    view1.textAnnouceHandle = ^(NSString * url){
        NSLog(@"%@",url);
    };

