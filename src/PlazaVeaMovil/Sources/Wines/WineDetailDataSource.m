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

@synthesize  delegate = _delegate, from = _from, imageView = _imageView;


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

- (id)initWithWineId:(NSString *)wineId
            delegate:(id<WineDetailDataSourceDelegate>)delegate
                from:(WineDetailFromType)from
{
    if ((self = [self initWithWineId:wineId delegate:delegate]) != nil) {
        _from = from;
    }
    return self;
}

- (UIView *)viewWithImageURL:(NSString *)imageURL title:(NSString *)title
{
    UIView *headerView =
            [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    // Conf the image
    TTImageView *image = [[[TTImageView alloc] initWithFrame:CGRectZero]
            autorelease];
    [image setDefaultImage:TTIMAGE(kWineDetailDefaultImage)];
    [image setUrlPath:imageURL];
    [image setAutoresizingMask:UIViewAutoresizingNone];
    [image setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin |
            UIViewAutoresizingFlexibleRightMargin];
    [image setBackgroundColor:[UIColor clearColor]];
    //[image setDelegate:self];
    
    _imageView = [[[UIButton alloc]
            initWithFrame:CGRectMake(.0, .0, 320., 140.)] autorelease];
    [_imageView setImage:nil forState:UIControlStateNormal];
    [_imageView addTarget:_delegate action:@selector(showBigPicture)
            forControlEvents:UIControlEventTouchUpInside];
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
    [_imageView setFrame:CGRectOffset([_imageView frame], .0,
            titleHeight + (margin * 2.))];
    [image setFrame:[_imageView frame]];
    [headerView addSubview:titleLabel];
    [headerView addSubview:image];
    [headerView addSubview:_imageView];
    
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
    //return LOCALIZED_HTTP_REQUEST_ERROR(error);
    return NSLocalizedString(kWineDetailSubtitleForError, nil);
}

- (void)tableViewDidLoadModel:(UITableView *)tableView
{
    if ([[self items] count] > 0) {
        return;
    }
    Wine *wine = (Wine *)[self model];
    NSMutableArray *items = [NSMutableArray array];

    [_delegate dataSource:self viewForHeader:[self viewWithImageURL:
            [IMAGE_URL([wine pictureURL], 320., 140.)  absoluteString]
                title:[wine name]]];
    [_delegate dataSource:self wineName:[wine name]];
    
    NSString *bottleImage = [[wine bottleImageURL]
            stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
    
    if ([wine bottleImageURL] != nil)
        [_delegate dataSource:self wineImageURL:bottleImage];
    
    TTTableTextItem *info = [TTTableTextItem itemWithText:kWineInfoLabel
            URL:URL(kURLWineInfoCall, [wine wineId])];
    
    [items addObject:info];
    
    TTTableTextItem *taste = [TTTableTextItem itemWithText:kWineTastingLabel
            URL:URL(kURLWineTasteCall, [wine wineId])];
    
    [items addObject:taste];
    
    /*TTTableTextItem *tips = [TTTableTextItem itemWithText:kWineTipsLabel
            URL:URL(kURLWineTipsCall, [wine wineId])];
    
    [items addObject:tips];*/
    
    NSString *title = [kWineRecommendedLabel
            stringByReplacingOccurrencesOfString:@" " withString:@"_"];
    
    if (_from == kWineFromSommelier) {
        TTTableTextItem *marriage = [TTTableTextItem
                itemWithText:kWineMarriageLabel
                    URL:URL(kURLWineRecipeCall, [wine wineId], title)];
    
        [items addObject:marriage];
    }
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