#import <Foundation/Foundation.h>

#import <Three20/Three20.h>

#import "Common/Additions/TTStyleSheet+Additions.h"
#import "Recipes/Constants.h"
#import "Recipes/RecipesTableViewDelegate.h"
#import "Recipes/AlphabeticalRecipesDataSource.h"
#import "Recipes/RecipeListController.h"

static CGFloat margin = 5.;
static CGFloat headerMinHeight = 40.;

@interface RecipeListController ()

@property (nonatomic, retain) UIView *headerView;
@property (nonatomic, retain) UILabel *titleLabel;
@end

@implementation RecipeListController

#pragma mark -
#pragma mark NSObject

- (void)dealloc
{
    [_titleLabel release];
    [_headerView release];
    [super dealloc];
}

#pragma mark -
#pragma mark UIViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self refresh];
    [self setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    if ([TTStyleSheet hasStyleSheetForSelector:@selector(navigationBarLogo)]) {
        [[self navigationItem] setTitleView:[[[UIImageView alloc]
                initWithImage:(UIImage *)TTSTYLE(navigationBarLogo)]
                    autorelease]];
    }
    UITableView *tableView = [self tableView];
    // Configuring the header view
    [self setHeaderView:[[[UIView alloc] initWithFrame:CGRectZero]
            autorelease]];
    // Configuring the label
    [self setTitleLabel:[[[UILabel alloc] initWithFrame:CGRectZero]
            autorelease]];
    [_titleLabel setNumberOfLines:0];
    [_titleLabel setLineBreakMode:UILineBreakModeWordWrap];
    [_titleLabel setTextAlignment:UITextAlignmentCenter];
    [_titleLabel setBackgroundColor:[UIColor clearColor]];
    if ([TTStyleSheet
            hasStyleSheetForSelector:@selector(tableTextHeaderFont)]) {
        [_titleLabel setFont:(UIFont *)TTSTYLE(tableTextHeaderFont)];
    }
    if ([TTStyleSheet hasStyleSheetForSelector:@selector(headerColorWhite)]) {
        [_titleLabel setTextColor:(UIColor *)TTSTYLE(headerColorWhite)];
    }
    
    NSString *title = [self title];
    UIFont *font = [_titleLabel font];
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
    [_titleLabel setText:title];
    [_titleLabel setFrame:titleFrame];
    CGFloat boundsWidth = CGRectGetWidth([tableView frame]);
    CGRect headerFrame = CGRectMake(.0, .0, boundsWidth,
            titleHeight + (2 * margin));
    // Adding the subviews to the header view
    UIImageView *back;
    if (_isMeat) {
        if ([TTStyleSheet hasStyleSheetForSelector:
                @selector(meatsBackgroundHeader)]) {
            back = [[[UIImageView alloc] initWithImage:
                    (UIImage *)TTSTYLE(meatsBackgroundHeader)] autorelease];
        }
        
    } else {
        if ([TTStyleSheet hasStyleSheetForSelector:
                @selector(recipesBackgroundHeader)]) {
            back = [[[UIImageView alloc] initWithImage:
                     (UIImage *)TTSTYLE(recipesBackgroundHeader)] autorelease];
        }
    }
    [_headerView insertSubview:back atIndex:0];
    [_headerView addSubview:_titleLabel];
    [_headerView setFrame:headerFrame];
    [_headerView setClipsToBounds:YES];
    [tableView setTableHeaderView:_headerView];
}

#pragma mark -
#pragma mark TTTableViewController

- (void)createModel
{
    if ([self isMeat]) {
        [self setDataSource:[[[AlphabeticalRecipesDataSource alloc]
                initWithMeatId:_collectionId] autorelease]];
    } else {
        [self setDataSource:[[[AlphabeticalRecipesDataSource alloc]
                initWithCategoryId:_collectionId] autorelease]];
    }
}

- (id<UITableViewDelegate>)createDelegate {
    return [[[RecipesTableViewDelegate alloc] initWithController:self
            isMeat:_isMeat] autorelease];
}

#pragma mark -
#pragma mark RecipeListController (Public)

@synthesize collectionId = _collectionId, isMeat = _isMeat,
        titleLabel = _titleLabel, headerView = _headerView;

- (id)initWithCategoryId:(NSString *)categoryId
{
    if ((self = [super initWithNibName:nil bundle:nil]) != nil) {
        _collectionId = [categoryId copy];
        _isMeat = NO;
        [self setTitle:NSLocalizedString(kRecipeListTitle, nil)];
        [self setSegmentIndex:kRecipesSegmentedControlIndexFoodButton];
    }
    return self;
}

- (id)initWithMeatId:(NSString *)meatId
{
    if ((self = [super initWithNibName:nil bundle:nil]) != nil) {
        _collectionId = [meatId copy];
        _isMeat = YES;
        [self setTitle:NSLocalizedString(kRecipeListTitle, nil)];
        [self setSegmentIndex:kRecipesSegmentedControlIndexMeatButton];
    }
    return self;
}
@end
