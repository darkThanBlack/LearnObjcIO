//
//  LOStyle_1_View.m
//  LOIssue1-1
//
//  Created by 月之暗面 on 2018/12/14.
//  Copyright © 2018 月之暗面. All rights reserved.
//

#import "LOStyle_1_View.h"
#import "LOStyle_1_DataHelper.h"
#import "LOStyle_1_DataSource.h"
#import "LOStyle_1_Cell.h"
#import "LOStyle_1_CellModel.h"

@interface LOStyle_1_View()<UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) LOStyle_1_DataSource *style_1_dataSource;
@property (nonatomic, strong) LOStyle_1_DataHelper *cellDataHelper;
@property (nonatomic, strong) UIButton *dataButton;
@property (nonatomic, strong) UIButton *moreDataButton;

@end

@implementation LOStyle_1_View

#pragma mark Getter

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self.style_1_dataSource;
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [_tableView registerClass:[LOStyle_1_Cell class] forCellReuseIdentifier:NSStringFromClass([LOStyle_1_Cell class])];
    }
    return _tableView;
}

- (LOStyle_1_DataSource *)style_1_dataSource
{
    if (!_style_1_dataSource) {
        _style_1_dataSource = [[LOStyle_1_DataSource alloc]initWithDataHelper:self.cellDataHelper];
    }
    return _style_1_dataSource;
}

- (LOStyle_1_DataHelper *)cellDataHelper
{
    if (!_cellDataHelper) {
        _cellDataHelper = [[LOStyle_1_DataHelper alloc]init];
    }
    return _cellDataHelper;
}

- (UIButton *)dataButton
{
    if (!_dataButton) {
        _dataButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _dataButton.backgroundColor = [UIColor redColor];
        [_dataButton setTitle:@"get net data" forState:UIControlStateNormal];
        [_dataButton addTarget:self action:@selector(dataButtonEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dataButton;
}

- (UIButton *)moreDataButton
{
    if (!_moreDataButton) {
        _moreDataButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _moreDataButton.backgroundColor = [UIColor blueColor];
        [_moreDataButton setTitle:@"get more data" forState:UIControlStateNormal];
        [_moreDataButton addTarget:self action:@selector(moreDataButtonEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreDataButton;
}

#pragma mark Setter

#pragma mark Life Cycle

- (instancetype)init
{
    if (self = [super init]) {
        [self loadLOStyle_1_Views_];
    }
    return self;
}

#pragma mark View

- (void)loadLOStyle_1_Views_
{
    [self addSubview:self.tableView];
    [self addSubview:self.dataButton];
    [self addSubview:self.moreDataButton];
    [self loadLOStyle_1_ViewConstraints_];
}

- (void)loadLOStyle_1_ViewConstraints_
{
    self.tableView.frame = [UIScreen mainScreen].bounds;
    self.dataButton.frame = CGRectMake(50, 400, 150, 50);
    self.moreDataButton.frame = CGRectMake(200, 400, 150, 50);
    [self layoutIfNeeded];
}

#pragma mark Event

- (void)dataButtonEvent
{
    NSMutableArray *tempArray = [[NSMutableArray alloc]init];
    for (NSInteger i = 0; i < 4; i++) {
        LOStyle_1_CellModel *cellInfo = [[LOStyle_1_CellModel alloc]init];
        switch (i) {
            case 0:
            {
                cellInfo.testColor = [UIColor redColor];
                cellInfo.testString = @"test0";
            }
                break;
            case 1:
            {
                cellInfo.testColor = [UIColor yellowColor];
                cellInfo.testString = @"test1";
            }
                break;
            case 2:
            {
                cellInfo.testColor = [UIColor greenColor];
                cellInfo.testString = @"test2";
            }
                break;
            case 3:
            {
                cellInfo.testColor = [UIColor blueColor];
                cellInfo.testString = @"test3";
            }
                break;
        }
        [tempArray addObject:cellInfo];
    }
    self.cellDataHelper.cellDataArray = [tempArray copy];
    [self.tableView reloadData];
}

- (void)moreDataButtonEvent
{
    NSMutableArray *tempArray = [[NSMutableArray alloc]init];
    for (NSInteger i = 0; i < 2; i++) {
        LOStyle_1_CellModel *cellInfo = [[LOStyle_1_CellModel alloc]init];
        switch (i) {
            case 0:
            {
                cellInfo.testColor = [UIColor redColor];
                cellInfo.testString = @"test55";
            }
                break;
            case 1:
            {
                cellInfo.testColor = [UIColor yellowColor];
                cellInfo.testString = @"test66";
            }
                break;
        }
        [tempArray addObject:cellInfo];
    }
    self.cellDataHelper.cellDataArray = [tempArray copy];
    [self.tableView reloadData];
}

@end
