//
//  NewsDynamicViewController.m
//  testCellsAutoresizing
//
//  Created by Agustin De Leon on 10/12/16.
//  Copyright © 2016 Agustin De Leon. All rights reserved.
//

#import "NewsDynamicViewController.h"
#import "NewsViews.h"
#import "NewsTableViewCell.h"

@interface NewsDynamicViewController () <UITableViewDelegate, UITableViewDataSource>

@end

static NSString *kNewsTableCellIdentifier = @"newsTableCellIdentifier";

@implementation NewsDynamicViewController

#pragma mark - Lifecycle methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Dynamic News Example";

    self.objectsArray = [NSArray arrayWithArray:[[ManagerDataController shareInstance] loadNewsDynamic]];

    UINib *nib = [UINib nibWithNibName:@"NewsTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:kNewsTableCellIdentifier];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource Methods

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kNewsTableCellIdentifier];
    
    if (!cell) {
        cell = [tableView dequeueReusableCellWithIdentifier:kNewsTableCellIdentifier
                                               forIndexPath:indexPath];
    }
    
    /*
        Creation of News content
     */
    if (!cell.newsView) {
        cell.newsView = [NewsViews new];
    }

    [cell.newsView loadCellWithNews:self.objectsArray[indexPath.row]];
    
    [cell.contentCellView addSubview:cell.newsView];
    
    [cell.newsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(cell.newsView.superview).with.insets(UIEdgeInsetsZero);
    }];
    
    [cell updateConstraintsIfNeeded];
    
    return cell;
}

@end
