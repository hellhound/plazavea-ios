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

- (UINavigationItem *)navigationItem
{
    if (_from == kRecipeFromWine)
        [[self navigationController] setToolbarHidden:YES];
    return [super navigationItem];
}

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
    switch (_from) {
        case kRecipeFromCategory:
            if ([TTStyleSheet hasStyleSheetForSelector:
                    @selector(recipesBackgroundHeader)]) {
                back = [[[UIImageView alloc] initWithImage:
                        (UIImage *)TTSTYLE(recipesBackgroundHeader)]
                            autorelease];
            }
            break;
        case kRecipeFromMeat:
            if ([TTStyleSheet hasStyleSheetForSelector:
                    @selector(meatsBackgroundHeader)]) {
                back = [[[UIImageView alloc] initWithImage:
                        (UIImage *)TTSTYLE(meatsBackgroundHeader)] autorelease];
            }
            break;
        case kRecipeFromWine:
            if ([TTStyleSheet hasStyleSheetForSelector:
                    @selector(wineBackgroundHeader)]) {
                back = [[[UIImageView alloc] initWithImage:
                         (UIImage *)TTSTYLE(wineBackgroundHeader)]
                            autorelease];
            }
            break;
        default:
            break;
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
    switch (_from) {
        case kRecipeFromCategory:
            [self setDataSource:[[[AlphabeticalRecipesDataSource alloc]
                    initWithCategoryId:_collectionId] autorelease]];
            break;
        case kRecipeFromMeat:
            [self setDataSource:[[[AlphabeticalRecipesDataSource alloc]
                    initWithMeatId:_collectionId] autorelease]];
            break;
        case kRecipeFromWine:
            [self setDataSource:[[[AlphabeticalRecipesDataSource alloc]
                    initWithWineId:_collectionId] autorelease]];
            break;
        default:
            break;
    }
}

- (id<UITableViewDelegate>)createDelegate {
    return [[[RecipesTableViewDelegate alloc] initWithController:self
            from:_from] autorelease];
}

#pragma mark -
#pragma mark RecipeListController (Public)

@synthesize collectionId = _collectionId, titleLabel = _titleLabel,
        headerView = _headerView, from = _from;

- (id)initWithCategoryId:(NSString *)categoryId name:(NSString *)name
{
    if ((self = [super initWithNibName:nil bundle:nil]) != nil) {
        _collectionId = [categoryId copy];
        _from = kRecipeFromCategory;
        
        [self setTitle:[name stringByReplacingOccurrencesOfString:@"_"
                withString:@" "]];
        [self setSegmentIndex:kRecipesSegmentedControlIndexFoodButton];
    }
    return self;
}

- (id)initWithMeatId:(NSString *)meatId name:(NSString *)name
{
    if ((self = [super initWithNibName:nil bundle:nil]) != nil) {
        _collectionId = [meatId copy];
        _from = kRecipeFromMeat;
        
        [self setTitle:[name stringByReplacingOccurrencesOfString:@"_"
                withString:@" "]];
        [self setSegmentIndex:kRecipesSegmentedControlIndexMeatButton];
    }
    return self;
}

- (id)initWithWineId:(NSString *)wineId name:(NSString *)name
{
    if ((self = [super initWithNibName:nil bundle:nil]) != nil) {
        _collectionId = [wineId copy];
        _from = kRecipeFromWine;
        
        [self setTitle:[name stringByReplacingOccurrencesOfString:@"_"
                    withString:@" "]];
        [self setSegmentIndex:kRecipesSegmentedControlIndexMeatButton];
    }
    return self;
}
@end
