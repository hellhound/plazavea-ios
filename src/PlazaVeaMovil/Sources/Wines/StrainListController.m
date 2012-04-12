#import <Foundation/Foundation.h>

#import "Common/Additions/TTStyleSheet+Additions.h"
#import "Wines/Constants.h"
#import "Wines/StrainListDataSource.h"
#import "Wines/StrainListController.h"

static CGFloat margin = 5.;
static CGFloat headerMinHeight = 40.;
static CGFloat titleWidth = 320.;

@implementation StrainListController

#pragma mark -
#pragma mark UIViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    UIView *headerView =
            [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    // Conf the label
    NSString *title = kStrainListTitle;
    
    if (_recipeId != nil) {
        title = @"Vinos Recomendados";
    }
    UILabel *titleLabel = [[[UILabel alloc] initWithFrame:CGRectZero]
                           autorelease];
    
    [titleLabel setNumberOfLines:0];
    [titleLabel setLineBreakMode:UILineBreakModeWordWrap];
    [titleLabel setTextAlignment:UITextAlignmentCenter];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    if ([TTStyleSheet hasStyleSheetForSelector:@selector(tableTextHeaderFont)])
        [titleLabel setFont:(UIFont *)TTSTYLE(tableTextHeaderFont)];
    if ([TTStyleSheet hasStyleSheetForSelector:@selector(headerColorWhite)])
        [titleLabel setTextColor:(UIColor *)TTSTYLE(headerColorWhite)];
    
    UIFont *font = [titleLabel font];
    CGSize constrainedTitleSize = CGSizeMake(titleWidth, MAXFLOAT);
    CGFloat titleHeight = [title sizeWithFont:font
                            constrainedToSize:constrainedTitleSize
                                lineBreakMode:UILineBreakModeWordWrap].height;
    CGRect titleFrame = CGRectMake(.0, .0, titleWidth, titleHeight);
    
    if ((titleHeight + (margin * 2.)) <= headerMinHeight) {
        titleFrame.origin.y = (headerMinHeight - titleHeight) / 2.;
        titleHeight = headerMinHeight - (margin * 2.);
    } else {
        titleFrame.origin.y += margin;
    }
    [titleLabel setText:title];
    [titleLabel setFrame:titleFrame];
    
    CGRect headerFrame = CGRectMake(.0, .0, titleWidth,
            titleHeight + (margin * 2.));
    
    [headerView setFrame:headerFrame];
    [headerView addSubview:titleLabel];
    
    UIImageView *background;
    if (_recipeId == nil) {
        background = [[[UIImageView alloc]
                initWithImage:TTIMAGE(kWineBackgroundImage)] autorelease];
    } else {
        background = [[[UIImageView alloc]
                initWithImage:TTIMAGE(kRecipesBackgroundImage)] autorelease];
    }
    [headerView insertSubview:background atIndex:0];
    [headerView setClipsToBounds:YES];
    [[self tableView] setTableHeaderView:headerView];
}

#pragma mark -
#pragma mark UITableViewController

- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle
{
    if ((self = [super initWithNibName:nibName bundle:bundle]) != nil) {
        [self setTitle:kStrainListTitle];
        [self setVariableHeightRows:YES];
        if ([TTStyleSheet
                hasStyleSheetForSelector:@selector(navigationBarLogo)]) {
            [[self navigationItem] setTitleView:[[[UIImageView alloc]
                    initWithImage:(UIImage *)TTSTYLE(navigationBarLogo)]
                        autorelease]];
        }
    }
    return self;
}

#pragma mark -
#pragma mark TTTableViewController

- (void)createModel
{
    if (_recipeId != nil) {
        [self setDataSource:[[[StrainListDataSource alloc]
                initWithRecipeId:_recipeId] autorelease]];
    } else {
        [self setDataSource:[[[StrainListDataSource alloc] init] autorelease]];
    }
}

#pragma mark -
#pragma mark StrainListController

@synthesize recipeId = _recipeId;

- (id)initWithRecipeId:(NSString *)recipeId
{
    if ((self = [self initWithNibName:nil bundle:nil]) != nil) {
        [self setTitle:kStrainListTitle];
        [self setVariableHeightRows:YES];
        _recipeId = recipeId;
    }
    return self;
}
@end
