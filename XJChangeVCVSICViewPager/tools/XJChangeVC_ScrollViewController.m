//
//  XJChangeVC_ScrollViewController.m
//  XJChangeVCVSICViewPager
//
//  Created by 邢进 on 2017/3/31.
//  Copyright © 2017年 邢进. All rights reserved.
//

#import "XJChangeVC_ScrollViewController.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define titleWidth SCREEN_WIDTH/_titleArray.count//宽平分
#define titleHeight 40//title栏高
#define backColor [UIColor colorWithWhite:0.300 alpha:1.000]//title未选中颜色
#define choosedColor [UIColor orangeColor]//选中title的颜色
#define sliderColor [UIColor redColor]//滑条颜色
#define titleBGColor [UIColor colorWithWhite:0.900 alpha:1.000]//title栏bgColor

@interface XJChangeVC_ScrollViewController () {
    UIButton *selectButton;//当前button
    UIView *sliderView;//滚动条
}
@property (nonatomic, strong)UIScrollView *scrollView;
@property (nonatomic, strong)NSMutableArray *buttonArray;

@end

@implementation XJChangeVC_ScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (NSMutableArray *)buttonArray {
    if (!_buttonArray) {
        _buttonArray = [@[] mutableCopy];
    }
    return _buttonArray;
}

- (void)setTitleArray:(NSArray *)titleArray {
    _titleArray = titleArray;
    [self initWithTitleButton];
}

- (void)setControllerArray:(NSArray *)controllerArray {
    _controllerArray = controllerArray;
    [self initWithController];
}

//创建titleView,包括:titleBGview,buttons,滑块
- (void)initWithTitleButton
{
    //创建bgView
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, titleHeight)];
    titleView.backgroundColor = titleBGColor;
    [self.view addSubview:titleView];
    //判断导航栏情况
    if (self.navigationController.navigationBar && !self.navigationController.navigationBarHidden) {
        titleView.frame = CGRectMake(0, 64, SCREEN_WIDTH, titleHeight);
    } else {
        titleView.frame = CGRectMake(0, 0, SCREEN_WIDTH, titleHeight);
    }
    //创建button
    for (int i = 0; i < _titleArray.count; i++) {
        UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        titleButton.frame = CGRectMake(titleWidth*i, 0, titleWidth, titleHeight);
        [titleButton setTitle:_titleArray[i] forState:UIControlStateNormal];
        [titleButton setTitleColor:backColor forState:UIControlStateNormal];
        titleButton.tag = 100+i;
        [titleButton addTarget:self action:@selector(scrollViewSelectToIndex:) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:titleButton];
        if (i == 0) {
            selectButton = titleButton;
            [selectButton setTitleColor:choosedColor forState:UIControlStateNormal];
        }
        [self.buttonArray addObject:titleButton];
    }
    //创建滑块
    sliderView = [[UIView alloc]initWithFrame:CGRectMake(0, titleHeight-1, titleWidth, 1)];
    sliderView.backgroundColor = sliderColor;
    [titleView addSubview:sliderView];
}

//titleButton点击事件
- (void)scrollViewSelectToIndex:(UIButton *)button
{
    [self selectButton:button.tag-100];
    [UIView animateWithDuration:0 animations:^{
        _scrollView.contentOffset = CGPointMake(SCREEN_WIDTH*(button.tag-100), 0);
    }];
}

//选择标题
- (void)selectButton:(NSInteger)index
{
    [selectButton setTitleColor:backColor forState:UIControlStateNormal];
    selectButton = self.buttonArray[index];
    [selectButton setTitleColor:choosedColor forState:UIControlStateNormal];
    //移动滑块
    [UIView animateWithDuration:0.3 animations:^{
        sliderView.frame = CGRectMake(titleWidth*index, titleHeight-1, titleWidth, 1);
    }];
}

//监听scrollView滚动
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //四舍五入,偏移量过半就滑动
    NSInteger roundIndex = roundf(scrollView.contentOffset.x / SCREEN_WIDTH);
    [self selectButton:roundIndex];
}

- (void)initWithController
{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    if (self.navigationController.navigationBar && !self.navigationController.navigationBarHidden) {
        _scrollView.frame = CGRectMake(0, titleHeight+64, SCREEN_WIDTH, SCREEN_HEIGHT-titleHeight-64);
    } else {
        _scrollView.frame = CGRectMake(0, titleHeight, SCREEN_WIDTH, SCREEN_HEIGHT-titleHeight);
    }
    _scrollView.delegate = self;
    _scrollView.backgroundColor = [UIColor colorWithWhite:0.900 alpha:1.000];
    _scrollView.pagingEnabled = YES;
    _scrollView.scrollEnabled = YES;
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH*_controllerArray.count, 0);
    [self.view addSubview:_scrollView];
    for (int i = 0; i < _controllerArray.count; i++) {
        UIView *viewcon = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*i, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        UIViewController *viewcontroller = _controllerArray[i];
        viewcon = viewcontroller.view;
        viewcon.frame = CGRectMake(SCREEN_WIDTH*i, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [_scrollView addSubview:viewcon];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
