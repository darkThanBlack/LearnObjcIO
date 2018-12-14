//
//  LOStyle_1_DataSource.m
//  LOIssue1-1
//
//  Created by 月之暗面 on 2018/12/14.
//  Copyright © 2018 月之暗面. All rights reserved.
//

#import "LOStyle_1_DataSource.h"
#import "LOStyle_1_Cell.h"
#import "LOStyle_1_DataHelper.h"

@interface LOStyle_1_DataSource ()

@property (nonatomic, weak) LOStyle_1_DataHelper *dataHelper;

@end

@implementation LOStyle_1_DataSource

- (instancetype)initWithDataHelper:(LOStyle_1_DataHelper *)dataHelper
{
    if (self = [super init]) {
        self.dataHelper = dataHelper;
    }
    return self;
}

#pragma mark TableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataHelper.cellDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LOStyle_1_Cell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LOStyle_1_Cell class])];
    
    cell.cellInfo = self.dataHelper.cellDataArray[indexPath.row];
    
    return cell;
}

@end
