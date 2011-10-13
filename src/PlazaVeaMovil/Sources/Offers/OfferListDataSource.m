#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Offers/Models.h"
#import "Offers/OfferListDataSource.h"

@implementation OfferListDataSource
    
#pragma mark -
#pragma mark NSObject

- (id)init
{
    if ((self = [super init]) != nil)
        [self setModel:[[[OfferCollection alloc] init] autorelease]];
    return self;
}

#pragma mark -
#pragma mark TTTableViewDataSource

- (void)tableViewDidLoadModel:(UITableView *)tableView
{
    NSArray *offers = [(OfferCollection *)[self model] offers];
    NSMutableArray *items = [NSMutableArray arrayWithCapacity:[offers count]];
    for (Offer *offer in offers) {
        TTTableImageItem *item = [TTTableImageItem itemWithText:[offer name]
                imageURL:[offer pictureURL]];
        [items addObject:item];
    }
    [self setItems:items];
}
@end