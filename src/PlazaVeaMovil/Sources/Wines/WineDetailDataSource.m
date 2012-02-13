#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Common/Constants.h"
#import "Common/Additions/TTStyleSheet+Additions.h"
#import "Common/Views/TableImageSubtitleItemCell.h"
#import "Common/Views/TableImageSubtitleItem.h"
#import "Common/Views/TableCaptionItem.h"
#import "Common/Views/TableCaptionItemCell.h"

#import "Wines/Models.h"
#import "Wines/Constants.h"
#import "Wines/WineDetailDataSource.h"

static CGFloat margin = 5.;
static CGFloat headerMinHeight = 40.;
static CGFloat titleWidth = 320.;

@implementation WineDetailDataSource

#pragma mark -
#pragma mark NSObject

- (void) dealloc
{
    [self setDelegate:nil];
    [super dealloc];
}

#pragma mark -
#pragma mark StoreDetailDataSource (public)

@synthesize  delegate = _delegate;


- (id)initWithWineId:(NSString *)wineId
{
    if ((self = [super init]) != nil) {
        [self setModel:[[[Wine alloc] initWithWineId:wineId] autorelease]];
    }
    return self;
}
- (id)initWithWineId:(NSString *)wineId
            delegate:(id<WineDetailDataSourceDelegate>)delegate
{
    if ((self = [super init]) != nil) {
        [self setModel:[[[Wine alloc] initWithWineId:wineId] autorelease]];
        [self setDelegate:delegate];
    }
    return self;
}

- (UIView *)viewWithImageURL:(NSString *)imageURL title:(NSString *)title
{
    UIView *headerView =
            [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    // Conf the image
    UIImageView *imageView = [[[UIImageView alloc]
            initWithImage:TTIMAGE(kWineBannerImage)] autorelease];
    
    [imageView setAutoresizingMask:UIViewAutoresizingNone];
    [imageView setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin |
            UIViewAutoresizingFlexibleRightMargin];
    [imageView setBackgroundColor:[UIColor clearColor]];
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
    
    CGRect headerFrame = CGRectMake(.0, .0, titleWidth, kWineDetailImageHeight +
            titleHeight + (margin * 2.));
    
    [headerView setFrame:headerFrame];
    [imageView setFrame:CGRectOffset([imageView frame], .0,
            titleHeight + (margin * 2.))];
    [headerView addSubview:titleLabel];
    [headerView addSubview:imageView];
    
    UIImageView *background = [[[UIImageView alloc]
            initWithImage:TTIMAGE(kWineBackgroundImage)] autorelease];
    [headerView insertSubview:background atIndex:0];
    [headerView setClipsToBounds:YES];
    return headerView;
}

#pragma mark -
#pragma mark <TTTableViewDataSource>

- (NSString *)titleForLoading:(BOOL)reloading
{
    return NSLocalizedString(kWineDetailTitleForLoading, nil);
}

- (NSString *)titleForEmpty
{
    return  NSLocalizedString(kWineDetailTitleForEmpty, nil);
}

- (NSString *)subtitleForEmpty
{
    return NSLocalizedString(kWineDetailSubtitleForEmpty, nil);
}

- (NSString *)titleForError:(NSError *)error
{
    return NSLocalizedString(kWineDetailTitleForError, nil);
}

- (NSString *)subtitleForError:(NSError *)error
{
    return LOCALIZED_HTTP_REQUEST_ERROR(error);
}

- (void)tableViewDidLoadModel:(UITableView *)tableView
{
    Wine *wine = (Wine *)[self model];
    NSMutableArray *items = [NSMutableArray array];

    [_delegate dataSource:self viewForHeader: [self viewWithImageURL:
            [[wine pictureURL] absoluteString] title:[wine name]]];
    
    TTTableTextItem *info =
            [TTTableTextItem itemWithText:@"Información" URL:nil];
    
    [items addObject:info];
    
    TTTableTextItem *taste =
            [TTTableTextItem itemWithText:@"Nota de cata" URL:nil];
    
    [items addObject:taste];
    
    TTTableTextItem *marriage =
            [TTTableTextItem itemWithText:@"Maridaje" URL:nil];
    
    [items addObject:marriage];
    
    /*// Info section
    [sections addObject:kWineInfoLabel];
    NSString *priceLabel = [NSString stringWithFormat:kWinePriceUnits,
            [[wine price] stringValue]];
    TableCaptionItem *country = [TableCaptionItem
            itemWithText:[[wine country] name] caption:kWineCountryLabel];
    TableCaptionItem *region = [TableCaptionItem
            itemWithText:[[wine region] name] caption:kWineRegionLabel];
    TableCaptionItem *brand = [TableCaptionItem
            itemWithText:[[wine brand] name] caption:kWineBrandLabel];
    TableCaptionItem *kind = [TableCaptionItem
            itemWithText:[[wine kind] name] caption:kWineKindLabel];
    TableCaptionItem *winery = [TableCaptionItem
            itemWithText:[[wine winery] name] caption:kWineWineryLabel];
    TableCaptionItem *harvest = [TableCaptionItem
            itemWithText:[[wine harvestYear] stringValue]
                caption:kWineHarvestYearLabel];
    TableCaptionItem *barrel = [TableCaptionItem
            itemWithText:[wine barrel] caption:kWineBarrelLabel];
    TableCaptionItem *price = [TableCaptionItem
            itemWithText:priceLabel caption:kWinePriceLabel];
    
    [items addObject:[NSArray arrayWithObjects:country, region, brand, kind,
            winery, harvest, barrel, price, nil]];
    // Taste section
    [sections addObject:kWineTastingLabel];
    TableCaptionItem *look = [TableCaptionItem
            itemWithText:[wine look] caption:kWineLookLabel];
    TableCaptionItem *taste = [TableCaptionItem
            itemWithText:[wine taste] caption:kWineTasteLabel];
    TableCaptionItem *smell = [TableCaptionItem
            itemWithText:[wine smell] caption:kWineSmellLabel];
    
    [items addObject:[NSArray arrayWithObjects:look, taste, smell, nil]];
    // Tips section
    [sections addObject:kWineTipsLabel];
    NSString *tempLabel = [NSString stringWithFormat:kWineTemperatureUnits,
            [[wine temperature] stringValue]];
    NSString *cellLabel = [NSString stringWithFormat:kWineCellaringUnits,
            [[wine cellaring] stringValue]];
    NSString *oxyLabel = [NSString stringWithFormat:kWineOxygenationUnits,
            [[wine oxygenation] stringValue]];
    TableCaptionItem *temp = [TableCaptionItem itemWithText:tempLabel
            caption:kWineTemperatureLabel];
    TableCaptionItem *cellaring = [TableCaptionItem itemWithText:cellLabel
            caption:kWineCellaringLabel];
    TableCaptionItem *oxygenation = [TableCaptionItem itemWithText:oxyLabel
            caption:kWineOxygenationLabel];
    
    [items addObject:
            [NSArray arrayWithObjects:temp, cellaring, oxygenation, nil]];
    [self setSections:sections];*/
    [self setItems:items];
}

- (Class)tableView:(UITableView *)tableView cellClassForObject:(id)object
{
    if ([object isKindOfClass:[TableImageSubtitleItem class]])
        return [TableImageSubtitleItemCell class];
    if ([object isKindOfClass:[TableCaptionItem class]])
        return [TableCaptionItemCell class];
    return [super tableView:tableView cellClassForObject:object];
}

@end