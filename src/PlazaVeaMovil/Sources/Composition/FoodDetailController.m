#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Common/Constants.h"
#import "Composition/Constants.h"
#import "Composition/FoodDetailDataSource.h"
#import "Composition/FoodDetailController.h"

@interface FoodDetailController ()

@property (nonatomic, retain) TTImageView *imageView;
@property (nonatomic, retain) UIView *headerView;
@property (nonatomic, retain) UILabel *titleLabel;
@end

@implementation FoodDetailController

#pragma mark -
#pragma mark NSObject

- (void) dealloc
{
    [_food release];
    [_imageView release];
    [_headerView release];
    [_titleLabel release];
    [super dealloc];
}

#pragma mark -
#pragma mark UIView

- (void)loadView
{
    [super loadView];
    
    UITableView *tableView = [self tableView];
    
    // Configuring the header view
    [self setHeaderView:[[[UIView alloc] initWithFrame:CGRectZero]
                         autorelease]];
    // Configuring the image view
    [self setImageView:[[[TTImageView alloc] initWithFrame:
                         CGRectMake(.0, .0, kFoodDetailImageWidth,
                                    kFoodDetailImageHeight)] autorelease]];
    [_imageView setDefaultImage:TTIMAGE(kFoodDetailDefaultImage)];
    [_imageView setAutoresizingMask:UIViewAutoresizingNone];
    [_imageView setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin |
     UIViewAutoresizingFlexibleRightMargin];
    [_imageView setBackgroundColor:[UIColor clearColor]];
    // Configuring the label
    [self setTitleLabel:[[[UILabel alloc] initWithFrame:CGRectZero]
                         autorelease]];
    [_titleLabel setNumberOfLines:0];
    [_titleLabel setLineBreakMode:UILineBreakModeWordWrap];
    [_titleLabel setTextAlignment:UITextAlignmentCenter];
    [_titleLabel setBackgroundColor:[UIColor clearColor]];
    
    NSString *title = [_food name];
    UIFont *font = [_titleLabel font];
    CGFloat titleWidth = CGRectGetWidth([tableView bounds]);
    CGSize constrainedTitleSize = CGSizeMake(titleWidth, MAXFLOAT);
    CGFloat titleHeight = [title sizeWithFont:font
            constrainedToSize:constrainedTitleSize
                lineBreakMode:UILineBreakModeWordWrap].height;
    CGRect titleFrame = CGRectMake(.0, .0, titleWidth, titleHeight);
    
    [_titleLabel setText:title];
    [_titleLabel setFrame:titleFrame];
    // Adding the subviews to the header view
    [_headerView addSubview:_titleLabel];
    [_headerView addSubview:_imageView];
    
    CGFloat boundsWidth = CGRectGetWidth([tableView frame]);
    CGRect headerFrame = CGRectMake(.0, .0, boundsWidth, kFoodDetailImageHeight
            + titleHeight);
    CGRect imageFrame = CGRectMake((boundsWidth - kFoodDetailImageWidth) / 2.,
            .0, kFoodDetailImageWidth, kFoodDetailImageHeight);
    
    [_headerView setFrame:headerFrame];
    [_imageView setFrame:CGRectOffset(imageFrame, .0, titleHeight)];
    /*if (imageURL != nil)
        [_imageView setUrlPath:[imageURL absoluteString]];*/
    [tableView setTableHeaderView:_headerView];
    [self refresh];
}

#pragma mark -
#pragma mark TTTableViewController

- (void)createModel
{
    [self setDataSource:
            [[[FoodDetailDataSource alloc] initWithFood:_food] autorelease]];
}

#pragma mark -
#pragma mark RecipeController (Private)

@synthesize imageView = _imageView, headerView = _headerView,
        titleLabel = _titleLabel;

#pragma mark -
#pragma mark FoodDetailController

- (id) initWithFood:(Food *)food
{
    if ((self = [self initWithNibName:nil bundle:nil]) != nil) {
        [self setTableViewStyle:UITableViewStylePlain];
        [self setVariableHeightRows:YES];
        _food = food;
    }
    return self;
}
@end