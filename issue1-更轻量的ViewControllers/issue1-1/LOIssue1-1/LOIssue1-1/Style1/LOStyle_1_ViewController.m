//
//  LOStyle_1_ViewController.m
//  LOIssue1-1
//
//  Created by 月之暗面 on 2018/12/14.
//  Copyright © 2018 月之暗面. All rights reserved.
//

#import "LOStyle_1_ViewController.h"
#import "LOStyle_1_View.h"

@interface LOStyle_1_ViewController ()

@property (nonatomic, strong) LOStyle_1_View *basicView;

@end

@implementation LOStyle_1_ViewController

#pragma mark Getter

- (LOStyle_1_View *)basicView
{
    if (!_basicView) {
        _basicView = [[LOStyle_1_View alloc]init];
        _basicView.backgroundColor = [UIColor whiteColor];
    }
    return _basicView;
}

#pragma mark Setter

#pragma mark Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadLOStyle_1_ViewControllerViews_];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
}

#pragma mark View

- (void)loadLOStyle_1_ViewControllerViews_
{
    [self.view addSubview:self.basicView];
    [self loadLOStyle_1_ViewControllerViewConstraints_];
}

- (void)loadLOStyle_1_ViewControllerViewConstraints_
{
    self.basicView.frame = [UIScreen mainScreen].bounds;
    [self.view layoutIfNeeded];
}

@end

