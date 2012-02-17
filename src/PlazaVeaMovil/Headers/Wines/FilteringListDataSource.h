#import <Foundation/Foundation.h>

#import <Three20/Three20.h>

#import "Wines/Constants.h"

@interface FilteringListDataSource: TTListDataSource
{
    WineFilteringListType _list;
    id _controller;
}
@property (nonatomic, assign) WineFilteringListType list;
@property (nonatomic, assign) id controller;

- (id)initWithList:(WineFilteringListType)list controller:(id)controller;
@end