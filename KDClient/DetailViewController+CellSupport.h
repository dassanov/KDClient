//
//  DetailViewController+CellSupport.h
//  KDClient
//
//  Created by Tair Sabirgaliev on 18.04.11.
//  Copyright 2011 BEE Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DetailViewController.h"

@interface DetailViewController (CellSupport)

- (UITableViewCell *)tableView:(UITableView *)tableView plainCellWithInfo:(NSDictionary *)cellInfo indexPath:(NSIndexPath *)indexPath;
- (UITableViewCell *)tableView:(UITableView *)tableView editingCellWithInfo:(NSDictionary *)cellInfo indexPath:(NSIndexPath *)indexPath;
- (UITableViewCell *)tableView:(UITableView *)tableView selectOneCellWithInfo:(NSDictionary *)cellInfo indexPath:(NSIndexPath *)indexPath;
- (UITableViewCell *)tableView:(UITableView *)tableView crownCellWithInfo:(NSDictionary *)cellInfo indexPath:(NSIndexPath *)indexPath;

@end
