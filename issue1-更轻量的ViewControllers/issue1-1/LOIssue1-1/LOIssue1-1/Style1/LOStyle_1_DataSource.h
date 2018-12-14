//
//  LOStyle_1_DataSource.h
//  LOIssue1-1
//
//  Created by 月之暗面 on 2018/12/14.
//  Copyright © 2018 月之暗面. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class LOStyle_1_DataHelper;

NS_ASSUME_NONNULL_BEGIN

@interface LOStyle_1_DataSource : NSObject<UITableViewDataSource>

- (instancetype)initWithDataHelper:(LOStyle_1_DataHelper *)dataHelper;

@end

NS_ASSUME_NONNULL_END
