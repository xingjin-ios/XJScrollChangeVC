//
//  ChildViewController.m
//  XJChangeVCVSICViewPager
//
//  Created by 邢进 on 2017/3/31.
//  Copyright © 2017年 邢进. All rights reserved.
//

#import "ChildViewController.h"
#define random(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]
#define randomColor random(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
@interface ChildViewController ()

@end

@implementation ChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = randomColor;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 00, 80, 60)];
    label.center = CGPointMake(self.view.center.x, 100);
    label.font = [UIFont systemFontOfSize:25];
    label.text = _labelTitle;
    [self.view addSubview:label];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"😁😁😁😁😁😁");
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
