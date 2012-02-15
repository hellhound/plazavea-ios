#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Common/Constants.h"
#import "Common/Additions/TTStyleSheet+Additions.h"
#import "Composition/Constants.h"
#import "Composition/FoodDetailDataSource.h"
#import "Composition/FoodDetailController.h"

static CGFloat margin = 5.;
static CGFloat categoryWidth = 150.;
static CGFloat headerMinHeight = 40.;

@interface FoodDetailController ()

- (UIImage *)banner;
@end

@implementation FoodDetailController

#pragma mark -
#pragma mark NSObject

- (void) dealloc
{
    [_food release];
    [super dealloc];
}

#pragma mark -
#pragma mark UIViewController

- (void)loadView
{
    [super loadView];

    UITableView *tableView = [self tableView];
    
    // Configuring the header view
    UIView *headerView = [[[UIView alloc] initWithFrame:CGRectZero]
            autorelease];
    // Configuring the image view
    TTImageView *imageView = [[[TTImageView alloc] initWithFrame:
            CGRectMake(.0, .0, kFoodDetailImageWidth,
                kFoodDetailImageHeight)] autorelease];
    //[_imageView setDefaultImage:TTIMAGE(kFoodDetailDefaultImage)];
    [imageView setAutoresizingMask:UIViewAutoresizingNone];
    [imageView setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin |
            UIViewAutoresizingFlexibleRightMargin];
    [imageView setBackgroundColor:[UIColor clearColor]];
    // Configuring the label
    UILabel *titleLabel = [[[UILabel alloc] initWithFrame:CGRectZero]
            autorelease];
    [titleLabel setNumberOfLines:0];
    [titleLabel setLineBreakMode:UILineBreakModeWordWrap];
    [titleLabel setTextAlignment:UITextAlignmentCenter];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    if ([TTStyleSheet
            hasStyleSheetForSelector:@selector(tableTextHeaderFont)]) {
        [titleLabel setFont:(UIFont *)TTSTYLE(tableTextHeaderFont)];
    }
    if ([TTStyleSheet hasStyleSheetForSelector:@selector(headerColorWhite)]) {
        [titleLabel setTextColor:(UIColor *)TTSTYLE(headerColorWhite)];
    }
    
    NSString *title = [_food name];
    UIFont *font = [titleLabel font];
    CGFloat titleWidth = CGRectGetWidth([tableView bounds]);
    CGSize constrainedTitleSize = CGSizeMake(titleWidth, MAXFLOAT);
    CGFloat titleHeight = [title sizeWithFont:font
            constrainedToSize:constrainedTitleSize
                lineBreakMode:UILineBreakModeWordWrap].height;
    CGRect titleFrame = CGRectMake(.0, .0, titleWidth, titleHeight);
    
    if ((titleHeight + (margin * 2)) <= headerMinHeight) {
        titleFrame.origin.y = (headerMinHeight - titleHeight) / 2;
        titleHeight = headerMinHeight - (margin * 2);
    } else {
        titleFrame.origin.y += margin;
    }
    [titleLabel setText:title];
    [titleLabel setFrame:titleFrame];
    
    CGFloat boundsWidth = CGRectGetWidth([tableView frame]);
    CGRect headerFrame = CGRectMake(.0, .0, boundsWidth, kFoodDetailImageHeight
            + titleHeight + (2 * margin));
    CGRect imageFrame = CGRectMake(.0, .0, kFoodDetailImageWidth,
            kFoodDetailImageHeight);
    
    [headerView setFrame:headerFrame];
    [imageView setFrame:
            CGRectOffset(imageFrame, .0, titleHeight + (2 * margin))];
    
     UILabel *categoryLabel =
            [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
    
    [categoryLabel setNumberOfLines:0];
    [categoryLabel setShadowColor:[UIColor blackColor]];
    [categoryLabel setShadowOffset:CGSizeMake(.0, 1.)];
    [categoryLabel setLineBreakMode:UILineBreakModeWordWrap];
    [categoryLabel setTextAlignment:UITextAlignmentRight];
    [categoryLabel setBackgroundColor:[UIColor clearColor]];
    if ([TTStyleSheet
            hasStyleSheetForSelector:@selector(pictureHeaderFont)]) {
        [categoryLabel setFont:(UIFont *)TTSTYLE(pictureHeaderFont)];
    }

    if ([TTStyleSheet hasStyleSheetForSelector:@selector(headerColorWhite)]) {
        [categoryLabel setTextColor:(UIColor *)TTSTYLE(headerColorWhite)];
    }
    [categoryLabel setShadowColor:[UIColor blackColor]];
    
    NSString *category = [[_food category] name];
    UIFont *categoryFont = [categoryLabel font];
    CGSize constrainedCategorySize = CGSizeMake(categoryWidth, MAXFLOAT);
    CGFloat categoryHeight = [category sizeWithFont:categoryFont
            constrainedToSize:constrainedCategorySize
                lineBreakMode:UILineBreakModeWordWrap].height;
    CGFloat categoryY = headerFrame.size.height - categoryHeight - margin;
    CGRect categoryFrame = CGRectMake((boundsWidth - categoryWidth - margin),
            categoryY, categoryWidth, categoryHeight);
    
    [categoryLabel setText:category];
    [categoryLabel setFrame:categoryFrame];
    [imageView setDefaultImage:[self banner]];
    // Adding the subviews to the header view
    [headerView addSubview:titleLabel];
    [headerView addSubview:imageView];
    //[headerView addSubview:_categoryLabel];
    if ([TTStyleSheet hasStyleSheetForSelector:
         @selector(compositionBackgroundHeader)]) {
        UIImageView *back = [[[UIImageView alloc] initWithImage:
                (UIImage *)TTSTYLE(compositionBackgroundHeader)] autorelease];
        [headerView insertSubview:back atIndex:0];
    }
    if ([TTStyleSheet hasStyleSheetForSelector:
         @selector(compositionPictureBackground)]) {
        UIImageView *pictureBack = [[[UIImageView alloc] initWithImage:
                (UIImage *)TTSTYLE(compositionPictureBackground)] autorelease];
        CGRect backFrame = [pictureBack frame];
        backFrame.origin.y = MAX(titleHeight + (2 * margin), 40.);
        [pictureBack setFrame:backFrame];
        [headerView insertSubview:pictureBack atIndex:1];
    }
    [headerView setClipsToBounds:YES];
    [tableView setTableHeaderView:headerView];
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
#pragma mark FoodDetailController (Private)

- (UIImage *)banner
{
    UIImage *banner;
    NSString *category = [[_food category] name];
    if ([category isEqualToString:kFoodCategoryDrinks]) {
        banner = TTIMAGE(kFoodCategoryDrinksImage);
    } else if ([category isEqualToString:kFoodCategoryMeats]) {
        banner = TTIMAGE(kFoodCategoryMeatsImage);
    } else if ([category isEqualToString:kFoodCategoryCereals]) {
        banner = TTIMAGE(kFoodCategoryCerealsImage);
    } else if ([category isEqualToString:kFoodCategoryFruits]) {
        banner = TTIMAGE(kFoodCategoryFruitsImage);
    } else if ([category isEqualToString:kFoodCategoryOils]) {
        banner = TTIMAGE(kFoodCategoryOilsImage);
    } else if ([category isEqualToString:kFoodCategoryEggs]) {
        banner = TTIMAGE(kFoodCategoryEggsImage);
    } else if ([category isEqualToString:kFoodCategoryMilks]) {
        banner = TTIMAGE(kFoodCategoryMilksImage);
    } else if ([category isEqualToString:kFoodCategoryLegumes]) {
        banner = TTIMAGE(kFoodCategoryLegumesImage);
    } else if ([category isEqualToString:kFoodCategoryFish]) {
        banner = TTIMAGE(kFoodCategoryFishImage);
    } else if ([category isEqualToString:kFoodCategorySugar]) {
        banner = TTIMAGE(kFoodCategorySugarImage);
    } else if ([category isEqualToString:kFoodCategoryTubercles]) {
        banner = TTIMAGE(kFoodCategoryTuberclesImage);
    } else if ([category isEqualToString:kFoodCategoryVegetables]) {
        banner = TTIMAGE(kFoodCategoryVegetablesImage);
    } else {
        banner = TTIMAGE(kFoodCategoryOtherImage);
    }
    return banner;
}

#pragma mark -
#pragma mark FoodDetailController (Public)

@synthesize food = _food;

- (id) initWithFood:(Food *)food
{
    if ((self = [self initWithNibName:nil bundle:nil]) != nil) {
        [self setTableViewStyle:UITableViewStylePlain];
        [self setVariableHeightRows:YES];
        _food = food;
        [self setStatusBarStyle:UIStatusBarStyleBlackOpaque];
        if ([TTStyleSheet hasStyleSheetForSelector:
                @selector(navigationBarLogo)]) {
            [[self navigationItem] setTitleView:[[[UIImageView alloc]
                    initWithImage:(UIImage *)TTSTYLE(navigationBarLogo)]
                        autorelease]];
        }
    }
    return self;
}
@end