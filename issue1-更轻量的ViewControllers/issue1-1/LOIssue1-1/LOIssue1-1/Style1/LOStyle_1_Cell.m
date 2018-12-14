//
//  LOStyle_1_Cell.m
//  LOIssue1-1
//
//  Created by 月之暗面 on 2018/12/14.
//  Copyright © 2018 月之暗面. All rights reserved.
//

#import "LOStyle_1_Cell.h"
#import "LOStyle_1_CellModel.h"

@interface LOStyle_1_Cell()

@end

@implementation LOStyle_1_Cell

#pragma mark Getter

#pragma mark Setter

- (void)setCellInfo:(LOStyle_1_CellModel *)cellInfo
{
    _cellInfo = cellInfo;
    
    self.backgroundColor = _cellInfo.testColor;
    self.textLabel.text = _cellInfo.testString;
}

#pragma mark Life Cycle

- (instancetype)init
{
    if (self = [super init]) {
        [self loadLOStyle_1_CellViews_];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self loadLOStyle_1_CellViews_];
    }
    return self;
}

#pragma mark View

- (void)loadLOStyle_1_CellViews_
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self loadLOStyle_1_CellConstraints_];
}

- (void)loadLOStyle_1_CellConstraints_
{
    
}

@end

