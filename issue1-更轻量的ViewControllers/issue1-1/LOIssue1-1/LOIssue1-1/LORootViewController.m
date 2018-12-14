//
//  LORootViewController.m
//  LOIssue1-1
//
//  Created by 月之暗面 on 2018/12/14.
//  Copyright © 2018 月之暗面. All rights reserved.
//

#import "LORootViewController.h"
#import "LOStyle_1_ViewController.h"

@interface LORootViewController ()

@end

@implementation LORootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //本来是想把演进的过程全部写出来，发现一下写不过来，只放了最后示例的代码
    UIButton *style_1_button = [[UIButton alloc]initWithFrame:CGRectMake(50, 200, 100, 40)];
    style_1_button.backgroundColor = [UIColor redColor];
    [style_1_button setTitle:@"style1" forState:UIControlStateNormal];
    [style_1_button addTarget:self action:@selector(style_1_button_event) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:style_1_button];
}

- (void)style_1_button_event
{
    LOStyle_1_ViewController *style_1_VC = [[LOStyle_1_ViewController alloc]init];
    [self.navigationController pushViewController:style_1_VC animated:YES];
}

@end
