#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Recipes/Constants.h"
#import "Recipes/Models.h"
#import "Recipes/MeatListDataSource.h"

@implementation MeatListDataSource

#pragma mark -
#pragma mark NSObject

- (id)init
{
    if ((self = [super init]) != nil)
        [self setModel:[[[MeatCollection alloc] init] autorelease]];
    return self;
}

#pragma mark -
#pragma mark TTableViewDataSource

- (void)tableViewDidLoadModel:(UITableView *)tableView
{
    NSArray *meats = [(MeatCollection *)[self model] meats];
    NSMutableArray *items = [NSMutableArray arrayWithCapacity:[meats count]];
    for (Meat *meat in meats) {
        TTTableImageItem *item = [TTTableImageItem itemWithText:[meat name]
                imageURL:[meat pictureURL]
                    defaultImage:TTIMAGE(kRecipeDetailDefaultImage)
                    imageStyle:nil URL:nil];
        [items addObject:item];
    }
    [self setItems:items];
}

@end