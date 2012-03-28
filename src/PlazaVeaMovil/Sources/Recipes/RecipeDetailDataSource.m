#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Common/Constants.h"
#import "Common/Additions/TTStyleSheet+Additions.h"
#import "Common/Views/TableImageSubtitleItem.h"
#import "Common/Views/TableImageSubtitleItemCell.h"
#import "Common/Views/TableCaptionItem.h"
#import "Common/Views/TableCaptionItemCell.h"
#import "Wines/Models.h"
#import "Wines/Constants.h"
#import "Recipes/Constants.h"
#import "Recipes/Models.h"
#import "Recipes/RecipeDetailDataSource.h"

static CGFloat margin = 5.;
static CGFloat headerMinHeight = 40.;
static CGFloat categoryWidth = 150.;
static CGFloat titleWidth = 320.;

@interface RecipeDetailDataSource (private)

- (void)setDelegate:(id<RecipeDetailDataSourceDelegate>)delegate;
@end

@implementation RecipeDetailDataSource

#pragma mark -
#pragma mark NSObject

- (void) dealloc
{
    [self setDelegate:nil];
    [super dealloc];
}

#pragma mark -
#pragma mark RecipeDetailDataSource (private)

- (void)setDelegate:(id<RecipeDetailDataSourceDelegate>)delegate
{
    _delegate = delegate;
}

#pragma mark -
#pragma mark RecipeDetailDataSource (public)

@synthesize delegate = _delegate, section = _section, from = _from;

- (id)initWithRecipeId:(NSString *)recipeId
              delegate:(id<RecipeDetailDataSourceDelegate>)delegate
{
    if ((self = [super init]) != nil) {
        [self setModel:[[[Recipe alloc]
                initWithRecipeId:recipeId] autorelease]];
        [self setDelegate:delegate];
    }
    return self;
}

- (id)initWithRecipeId:(NSString *)recipeId
              delegate:(id<RecipeDetailDataSourceDelegate>)delegate
               hasMeat:(BOOL)hasMeat
{
    if ((self = [self initWithRecipeId:recipeId delegate:delegate]) != nil)
        _hasMeat = hasMeat;
    return self;
}

- (id)initWithRecipeId:(NSString *)recipeId
              delegate:(id<RecipeDetailDataSourceDelegate>)delegate
               section:(RecipeDetailViewType)section
                  from:(kRecipeFromType)from
{
    if ((self = [self initWithRecipeId:recipeId delegate:delegate]) != nil) {
        _section = section;
        _from = from;
    }
    return self;
}

- (UIView *)viewWithImageURL:(NSString *)imageURL
                       title:(NSString *)title
                      detail:(NSString *)detail
{
    UIView *headerView =
            [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    // Conf the image
    TTImageView *imageView = nil;
    
    if (imageURL != nil) {
        imageView = [[[TTImageView alloc] initWithFrame:CGRectZero]
                autorelease];
        
        [imageView setDefaultImage:TTIMAGE(kRecipeDetailDefaultImage)];
        [imageView setUrlPath:imageURL];
        [imageView setAutoresizingMask:UIViewAutoresizingNone];
        [imageView setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin |
                UIViewAutoresizingFlexibleRightMargin];
        [imageView setBackgroundColor:[UIColor clearColor]];
    }
    // Conf the Cordon Bleu logo
    TTImageView *logoView = [[[TTImageView alloc] initWithFrame:CGRectZero]
                             autorelease];
    
    [logoView setDefaultImage:(UIImage*)TTSTYLE(cordonBleuLogo)];
    [logoView setBackgroundColor:[UIColor clearColor]];
    // Conf the label
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
            [imageView frame].size.height + titleHeight + (margin * 2.));
    
    [headerView setFrame:headerFrame];
    [imageView setFrame:CGRectOffset([imageView frame], .0,
            titleHeight + (margin * 2.))];
    [logoView setFrame:CGRectOffset([logoView frame],
            titleWidth - [logoView frame].size.width - margin,
                titleHeight + (margin * 2.))];
    // Conf category label
    UILabel *detailLabel =
            [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
    
    [detailLabel setNumberOfLines:0];
    [detailLabel setShadowColor:[UIColor blackColor]];
    [detailLabel setShadowOffset:CGSizeMake(.0, 1.)];
    [detailLabel setLineBreakMode:UILineBreakModeWordWrap];
    [detailLabel setTextAlignment:UITextAlignmentRight];
    [detailLabel setBackgroundColor:[UIColor clearColor]];
    if ([TTStyleSheet
            hasStyleSheetForSelector:@selector(pictureHeaderFont)]) {
        [detailLabel setFont:(UIFont *)TTSTYLE(pictureHeaderFont)];
    }
    
    if ([TTStyleSheet hasStyleSheetForSelector:@selector(headerColorWhite)]) {
        [detailLabel setTextColor:(UIColor *)TTSTYLE(headerColorWhite)];
    }
    [detailLabel setShadowColor:[UIColor blackColor]];
    
    UIFont *categoryFont = [detailLabel font];
    CGSize constrainedCategorySize = CGSizeMake(categoryWidth, MAXFLOAT);
    CGFloat categoryHeight = [detail sizeWithFont:categoryFont
            constrainedToSize:constrainedCategorySize
                lineBreakMode:UILineBreakModeWordWrap].height;
    CGFloat categoryY = headerFrame.size.height - categoryHeight - margin;
    CGRect categoryFrame = CGRectMake((titleWidth - categoryWidth - margin),
            categoryY, categoryWidth, categoryHeight);
    
    [detailLabel setText:detail];
    [detailLabel setFrame:categoryFrame];
    // Adding the subviews to the header view
    [headerView addSubview:titleLabel];
    [headerView addSubview:imageView];
    //[headerView addSubview:logoView];
    [headerView addSubview:detailLabel];
    
    UIImageView *background = [[[UIImageView alloc] initWithImage:
            (UIImage *)TTSTYLE(recipesBackgroundHeader)] autorelease];
    [headerView insertSubview:background atIndex:0];
    [headerView setClipsToBounds:YES];
    return headerView;

}

#pragma mark -
#pragma mark <TTTableViewDataSource>

- (NSString *)titleForLoading:(BOOL)reloading
{
    return NSLocalizedString(kRecipeDetailTitleForLoading, nil);
}

- (NSString *)titleForEmpty
{
    return NSLocalizedString(kRecipeDetailTitleForEmpty, nil);
}

- (NSString *)subtitleForEmpty
{
    return NSLocalizedString(kRecipeDetailSubtitleForEmpty, nil);
}

- (NSString *)titleForError:(NSError *)error
{
    return NSLocalizedString(kRecipeDetailTitleForError, nil);
}

- (NSString *)subtitleForError:(NSError *)error
{
    //return LOCALIZED_HTTP_REQUEST_ERROR(error);
    return NSLocalizedString(kRecipeDetailSubtitleForError, nil);
}

- (void)tableViewDidLoadModel:(UITableView *)tableView
{
    Recipe *recipe = (Recipe *)[self model];
    NSMutableArray *items = [NSMutableArray array];
    NSString *recipeName = [recipe name];
    NSString *rations = [NSString stringWithFormat:kRecipeRations,
            [[recipe rations] stringValue]];
    NSURL *pictureURL = [recipe pictureURL];

    if (pictureURL != nil) {
        pictureURL = IMAGE_URL(pictureURL, kRecipeDetailImageWidth,
                kRecipeDetailImageHeigth);
    }
    [_delegate dataSource:self viewForHeader:[self viewWithImageURL:
            [pictureURL absoluteString] title:recipeName detail:rations]];
    //if the features list have items doesnt show the ingredients n'
    //procedures
    if ([[recipe features] count] > 0) {
        for (NSString *feature in [recipe features]) {
            TTTableTextItem *item = [TTTableTextItem itemWithText:feature];

            [items addObject:item];
        }
    } else {
        NSString *fromString = [NSString stringWithFormat:@"%i", _from];
        switch (_section) {
            case kRecipeDetailMainView:
                if ([[recipe ingredients] count] > 0) {
                    TTTableTextItem *ingredients = [TTTableTextItem
                            itemWithText:kRecipeDetailSectionIngredients
                                URL:URL(kURLIngredientRecipeDetailCall,
                                [recipe recipeId], fromString)];
                    
                    [items addObject:ingredients];
                }
                if ([[recipe procedures] count] > 0) {
                    TTTableTextItem *procedures = [TTTableTextItem
                            itemWithText:kRecipeDetailSectionProcedures
                                URL:URL(kURLProceduresRecipeDetailCall,
                                        [recipe recipeId], fromString)];
                    
                    [items addObject:procedures];
                }
                if ([[recipe tips] count] > 0) {
                    TTTableTextItem *tips = [TTTableTextItem
                            itemWithText:kRecipeDetailSectionTips
                                URL:URL(kURLTipsRecipeDetailCall,
                                [recipe recipeId], fromString)];
                    
                    [items addObject:tips];
                }
                if (_from != kRecipeFromWine) {
                    TTTableTextItem *strains = [TTTableTextItem
                            itemWithText:kRecipeDetailSectionStrains
                                URL:URL(kURLRecipeStrainListCall,
                                [recipe recipeId])];
                    
                    [items addObject:strains];
                }
                TTTableTextItem *contribution = [TTTableTextItem
                        itemWithText:kRecipeDetailSectionContribution
                            URL:URL(kURLContributionRecipeDetailCall,
                            [recipe recipeId])];
                
                [items addObject:contribution];
                break;
            case kRecipeDetailIngredientsView:
                if ([[recipe ingredients] count] > 0) {
                    for (Ingredient *ingredient in [recipe ingredients]) {
                        TTTableTextItem *item = [TTTableTextItem itemWithText:
                                [ingredient formattedIngredientString]];
                        
                        [items addObject:item];
                    }
                }
                break;
            case kRecipeDetailProceduresView:
                if ([[recipe procedures] count] > 0) {
                    for (NSString *procedure in [recipe procedures]) {
                        TTTableTextItem *item =
                            [TTTableTextItem itemWithText:procedure];
                        
                        [items addObject:item];
                    }
                }
                break;
            case kRecipeDetailTipsView:
                if ([[recipe tips] count] > 0) {
                    for (NSString *tip in [recipe tips]) {
                        TTTableTextItem *item = [TTTableTextItem
                                itemWithText:tip];
                        
                        [items addObject:item];
                    }
                }
                break;
            case kRecipeDetailContributionView:
            {
                 NSString *valueString;
                if ([[recipe contribution] calories]) {
                    valueString = [NSString stringWithFormat:
                            kRecipeDetailKCalSufix, [[[recipe contribution]
                                calories] floatValue]];
                    TableCaptionItem *calories = [TableCaptionItem
                            itemWithText:valueString
                                caption:kRecipeDetailCalories];
                    
                    [items addObject:calories];
                }
                if ([[recipe contribution] carbohydrates]) {
                    valueString = [NSString stringWithFormat:
                            kRecipeDetailGramsSufix, [[[recipe contribution]
                                carbohydrates] floatValue]];
                    TableCaptionItem *carbohydrates = [TableCaptionItem
                            itemWithText:valueString
                                caption:kRecipeDetailCarbohydrates];
                    
                    [items addObject:carbohydrates];
                }
                if ([[recipe contribution] fats]) {
                    valueString = [NSString stringWithFormat:
                            kRecipeDetailGramsSufix, [[[recipe contribution]
                                fats] floatValue]];
                    TableCaptionItem *fats = [TableCaptionItem
                            itemWithText:valueString caption:kRecipeDetailFats];
                    
                    [items addObject:fats];
                }
                if ([[recipe contribution] fiber]) {
                    valueString = [NSString stringWithFormat:
                            kRecipeDetailGramsSufix, [[[recipe contribution]
                                fiber] floatValue]];
                    TableCaptionItem *fiber = [TableCaptionItem
                            itemWithText:valueString
                                caption:kRecipeDetailFiber];
                    
                    [items addObject:fiber];
                }
                if ([[recipe contribution] proteins]) {
                    valueString = [NSString stringWithFormat:
                            kRecipeDetailGramsSufix, [[[recipe contribution]
                                proteins] floatValue]];
                    TableCaptionItem *proteins = [TableCaptionItem
                            itemWithText:valueString
                                caption:kRecipeDetailProteins];
                    
                    [items addObject:proteins];
                }
                break;
            }
        }
    }
    [self setItems:items];
}

- (Class)tableView:(UITableView *)tableView cellClassForObject:(id)object
{
    if ([object isKindOfClass:[TableImageSubtitleItem class]]) {
        return [TableImageSubtitleItemCell class];
    } else if ([object isKindOfClass:[TableCaptionItem class]]) {
        return [TableCaptionItemCell class];
    }
    return [super tableView:tableView cellClassForObject:object];
}
@end
