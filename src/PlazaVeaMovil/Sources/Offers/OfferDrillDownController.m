#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Offers/Constants.h"
#import "Offers/OfferDrillDownController.h"

@interface OfferDrillDownController ()

@property (nonatomic, readonly) UISegmentedControl *segControl;

- (void)switchControllers:(UISegmentedControl *)segControl;
@end

@implementation OfferDrillDownController

#pragma mark -
#pragma mark NSObject

- (void) dealloc
{
    [_segControl release];
    [super dealloc];
}

#pragma mark -
#pragma mark UIViewController

- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle
{
    if ((self = [super initWithNibName:nibName bundle:bundle]) != nil)
        [self setTableViewStyle:UITableViewStylePlain];
    return self;
}

- (UINavigationItem *)navigationItem
{
    UINavigationItem *navItem = [super navigationItem];
    
    if ([self toolbarItems] == nil) {
        UIBarButtonItem *segItem = [[[UIBarButtonItem alloc]
                initWithCustomView:[self segControl]] autorelease];
        UIBarButtonItem *spacerItem = [[[UIBarButtonItem alloc]
                initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                    target:nil action:NULL] autorelease];
        
        [self setToolbarItems:[NSArray arrayWithObjects:
                spacerItem, segItem, spacerItem, nil]];
        [[self navigationController] setToolbarHidden:NO];
    }
    return navItem;
}

#pragma mark -
#pragma mark OfferDrillDownController (Private)

@synthesize segControl = _segControl;

- (UISegmentedControl *)segControl
{
    if (_segControl != nil)
        return _segControl;
    [_segControl autorelease];
    _segControl = [[UISegmentedControl alloc] initWithItems:
            [NSArray arrayWithObjects:kOfferPromoButton,
                kOfferOfferButton, nil]];
    [_segControl setSegmentedControlStyle:UISegmentedControlStyleBar];
    [_segControl setSelectedSegmentIndex:kOfferSegmentedControlIndexDefault];
    [_segControl addTarget:self action:@selector(switchControllers:)
          forControlEvents:UIControlEventValueChanged];
    return _segControl;
}

- (void)switchControllers:(UISegmentedControl *)segControl
{
    switch ([segControl selectedSegmentIndex]) {
        case kOfferSegmentedControlIndexPromoButton:
            break;
        case kOfferSegmentedControlIndexOfferButton:
            break;
    }
}

#pragma mark -
#pragma mark OfferDrillDownController (Public)

@synthesize segmentedIndex = _segmentIndex;

- (void)setSegmentedIndex:(NSInteger)segmentedIndex
{
    UISegmentedControl *segControl = [self segControl];
    
    [segControl removeTarget:self action:@selector(switchControllers:)
            forControlEvents:UIControlEventValueChanged];
    [segControl setSelectedSegmentIndex:segmentedIndex];
    [segControl addTarget:self action:@selector(switchControllers:)
            forControlEvents:UIControlEventValueChanged];
}
@end