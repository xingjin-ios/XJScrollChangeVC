//
//  ICViewPagerText.m
//  XJChangeVCVSICViewPager
//
//  Created by 邢进 on 2017/3/31.
//  Copyright © 2017年 邢进. All rights reserved.
//

#import "ICViewPagerText.h"
#import "ChildViewController.h"

@interface ICViewPagerText ()<ViewPagerDelegate, ViewPagerDataSource>
@property(nonatomic, strong)NSArray *dataArray;
@end

@implementation ICViewPagerText
- (void)viewDidLoad {
    // Keeps tab bar below navigation bar on iOS 7.0+
     if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
         self.edgesForExtendedLayout = UIRectEdgeNone;
     }
    self.title = @"ICViewPager";
    _dataArray = @[@"第一页", @"第二页", @"第三页", @"第四页",@"第五页",@"第六页"];
    self.delegate = self;
    self.dataSource = self;
//    [self reloadData];
}

#pragma mark - ViewPagerDataSource
//返回标签的数量
- (NSUInteger)numberOfTabsForViewPager:(ViewPagerController *)viewPager {
    return _dataArray ? _dataArray.count : 0;
}
//返回UIView视图将显示为tab
- (UIView *)viewPager:(ViewPagerController *)viewPager viewForTabAtIndex:(NSUInteger)index {
    UILabel *label = [[[NSBundle mainBundle] loadNibNamed:@"titleView" owner:nil options:nil] firstObject];
    label.text = _dataArray[index];
    [label sizeToFit];
    return label;
}
//返回视图控制器将显示为内容
- (UIViewController *)viewPager:(ViewPagerController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index {
    ChildViewController *vc = [[ChildViewController alloc] init];
    [vc setValue:_dataArray[index] forKey:@"labelTitle"];
    return vc;
}
//也可以返回view,二者必须实现一个
//- (UIView *)viewPager:(ViewPagerController *)viewPager contentViewForTabAtIndex:(NSUInteger)index;

#pragma mark - ViewPagerDelegate

- (void)viewPager:(ViewPagerController *)viewPager didChangeTabToIndex:(NSUInteger)index {
    // Do something useful
}
//设置,默认全是0
- (CGFloat)viewPager:(ViewPagerController *)viewPager valueForOption:(ViewPagerOption)option withDefault:(CGFloat)value {
    //1.0 是 YES , 0.0是 NO
    switch (option) {
        case ViewPagerOptionStartFromSecondTab://默认选中第二个tab
            return 0.0;
            break;
        case ViewPagerOptionCenterCurrentTab://多tab的情况,选中一个是否滚动到屏幕中间位置(如果可以的话)
            return 1.0;
            break;
        case ViewPagerOptionTabLocation://1tab在上面 0在下面
            return 1.0;
        case ViewPagerOptionTabWidth://每个Tab宽度
            return 100;
        default:
            break;
    }
    return value;
}
//颜色设置
- (UIColor *)viewPager:(ViewPagerController *)viewPager colorForComponent:(ViewPagerComponent)component withDefault:(UIColor *)color {
    switch (component) {
        case ViewPagerIndicator://滚动条颜色
            return [UIColor orangeColor];
            break;
        case ViewPagerTabsView://tab颜色
            return [UIColor whiteColor];
            break;
        case ViewPagerContent://内容滚动视图BGColor,            return [UIColor whiteColor];
            break;
        default:
            break;
    }
    return color;
}


@end
