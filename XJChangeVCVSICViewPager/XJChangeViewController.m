//
//  XJChangeViewController.m
//  XJChangeVCVSICViewPager
//
//  Created by 邢进 on 2017/3/31.
//  Copyright © 2017年 邢进. All rights reserved.
//

#import "XJChangeViewController.h"
#import "ChildViewController.h"

@interface XJChangeViewController ()

@end

@implementation XJChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"ScrollView实现";
    //[self.navigationController setNavigationBarHidden:YES animated:YES];
    
    self.titleArray = @[@"第一页",@"第二页"];
    ChildViewController *oneVC = [ChildViewController new];
    oneVC.labelTitle = @"第一页";
    ChildViewController *twoVC = [ChildViewController new];
    twoVC.labelTitle = @"第二页";

    self.controllerArray = @[oneVC,twoVC];
    

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
