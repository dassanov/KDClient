//
//  DetailViewController+CellSupport.m
//  KDClient
//
//  Created by Tair Sabirgaliev on 18.04.11.
//  Copyright 2011 BEE Software. All rights reserved.
//

#import "DetailViewController+CellSupport.h"
#import "EditingCell.h"
#import "SelectOneCell.h"
#import "CrownCell.h"
#import "CrownController.h"

@implementation DetailViewController (CellSupport)

#pragma mark - Cell type support

- (UITableViewCell *)tableView:(UITableView *)tableView plainCellWithInfo:(NSDictionary *)cellInfo indexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat: @"PlainCell-%i-%i", indexPath.section, indexPath.row];
    NSString *label = [cellInfo objectForKey:@"label"];
    NSString *sample = [cellInfo objectForKey:@"sample"];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];    
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
	cell.textLabel.text = label;
	cell.detailTextLabel.text = sample;
	return cell;
}


- (UITableViewCell *)tableView:(UITableView *)tableView editingCellWithInfo:(NSDictionary *)cellInfo indexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat: @"EditingCell-%i-%i", indexPath.section, indexPath.row];
    
	EditingCell *cell = (EditingCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[EditingCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];    
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.detailViewController = self;
    }
    
    NSString *label = [cellInfo objectForKey:@"label"];
    NSString *field = [cellInfo objectForKey:@"field"];
    [cell useField:field ofManagedObject:self.detailItem];
	cell.textLabel.text = label;
	return cell;
}


- (UITableViewCell *)tableView:(UITableView *)tableView selectOneCellWithInfo:(NSDictionary *)cellInfo indexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat: @"SelectOneCell-%i-%i", indexPath.section, indexPath.row];
    
    NSString *label = [cellInfo objectForKey:@"label"];
    NSString *sample = [cellInfo objectForKey:@"sample"];
    
	SelectOneCell *cell = (SelectOneCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[SelectOneCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
	cell.textLabel.text = label;
	cell.detailTextLabel.text = sample;
    cell.detailViewController = self;
	return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView crownCellWithInfo:(NSDictionary *)cellInfo indexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"CrownCellAdd";
    NSArray *crowns = self.crownController.fetchedObjects;
    if (indexPath.row < [crowns count]) {
        CellIdentifier = [NSString stringWithFormat:@"CrownCell-%i", indexPath.row];
    }
    
    CrownCell *cell = (CrownCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[CrownCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.detailViewController = self;
    }
    [cell useCrownAtIndex:indexPath.row ofReport:self.detailItem];
    
    return cell;
}

@end
