#import <Foundation/Foundation.h>
#import <UIKIt/UIKit.h>

#import <Three20/Three20.h>

#import "Offers/Constants.h"
#import "Offers/BaseOfferController.h"

@implementation BaseOfferController

#pragma mark -
#pragma mark UIViewController

- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle
{
    if ((self = [super initWithNibName:nibName bundle:bundle]) != nil)
        [self setSegmentedIndex:kOfferSegmentedControlIndexOfferButton];
    return self;
}
@end