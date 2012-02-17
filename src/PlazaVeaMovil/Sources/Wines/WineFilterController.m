#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "Wines/WineFilterController.h"
#import "Wines/Constants.h"

@implementation WineFilterController

#pragma mark -
#pragma mark <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case kWineFilterSection:
            return 4;
            break;
        case kWineGoSection:
            return 1;
            break;
        default:
            return 0;
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = 
            [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleValue1
                    reuseIdentifier:cellId] autorelease];
    }
    NSString *textLabel = kWineUndefinedLabel;
    NSString *detailTextLabel = kWineUndefinedLabel;
    
    switch ([indexPath section]) {
        case kWineFilterSection:
            switch ([indexPath row]) {
                case kWineCountryRow:
                    textLabel = kWineCountryLabel;
                    break;
                case kWineCategoryRow:
                    textLabel = kWineCategoryLabel;
                    break;
                case kWineStrainRow:
                    textLabel = kWineStrainLabel;
                    break;
                case kWinePriceRow:
                    textLabel = kWinePriceLabel;
                    break;
                default:
                    break;
            }
            break;
        case kWineGoSection:
            switch ([indexPath row]) {
                case kWineGoRow:
                    textLabel = kWineGoLabel;
                    break;
                default:
                    break;
            }
            break;
        default:
            break;
    }
    [[cell textLabel] setText:textLabel];
    [[cell textLabel] setAdjustsFontSizeToFitWidth:YES];
    [[cell detailTextLabel] setText:detailTextLabel];
    [[cell detailTextLabel] setAdjustsFontSizeToFitWidth:YES];
    return cell;
}
@end