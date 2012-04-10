#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Common/Constants.h"
#import "Common/Additions/TTStyleSheet+Additions.h"
#import "Common/Views/TableImageSubtitleItemCell.h"
#import "Common/Views/TableImageSubtitleItem.h"

#import "Stores/Models.h"
#import "Stores/Constants.h"
#import "Stores/StoreDetailDataSource.h"

static CGFloat margin = 5.;
static CGFloat headerMinHeight = 40.;
static CGFloat titleWidth = 320.;

@interface StoreDetailDataSource ()

- (UIView *)viewWithImageURL:(NSString *)imageURL title:(NSString *)title;
@end

@implementation StoreDetailDataSource

#pragma mark -
#pragma mark NSObject

- (void) dealloc
{
    [self setDelegate:nil];
    [super dealloc];
}

#pragma mark -
#pragma mark StoreDetailDataSource (public)

@synthesize delegate = _delegate;

- (id)initWithStoreId:(NSString *)storeId
              delegate:(id<StoreDetailDataSourceDelegate>)delegate
{
    if ((self = [super init]) != nil) {
        [self setModel:[[[Store alloc] initWithStoreId:storeId] autorelease]];
        [self setDelegate:delegate];
    }
    return self;
}

#pragma mark -
#pragma mark StoreDetailDataSource (private)

- (UIView *)viewWithImageURL:(NSString *)imageURL title:(NSString *)title
{
    UIView *headerView =
    [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    // Conf the image
    TTImageView *imageView = nil;
    
    if (imageURL != nil) {
        imageView = [[[TTImageView alloc] initWithFrame:CGRectZero]
                autorelease];
        
        [imageView setDefaultImage:TTIMAGE(kRegionListDefaultImage)];
        //[imageView setUrlPath:imageURL];
        [imageView setAutoresizingMask:UIViewAutoresizingNone];
        [imageView setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin |
                UIViewAutoresizingFlexibleRightMargin];
        [imageView setBackgroundColor:[UIColor clearColor]];
    }
    // Conf the label
    UILabel *titleLabel = [[[UILabel alloc] initWithFrame:CGRectZero]
            autorelease];
    
    [titleLabel setNumberOfLines:0];
    [titleLabel setLineBreakMode:UILineBreakModeWordWrap];
    [titleLabel setTextAlignment:UITextAlignmentCenter];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    if ([TTStyleSheet hasStyleSheetForSelector:@selector(tableTextHeaderFont)])
        [titleLabel setFont:(UIFont *)TTSTYLE(tableTextHeaderFont)];
    if ([TTStyleSheet hasStyleSheetForSelector:@selector(headerColorYellow)])
        [titleLabel setTextColor:(UIColor *)TTSTYLE(headerColorYellow)];
    if ([TTStyleSheet hasStyleSheetForSelector:@selector(headerShadowColor)]) {
        [titleLabel setShadowColor:(UIColor *)TTSTYLE(headerShadowColor)];
        [titleLabel setShadowOffset:CGSizeMake(.0, -1.)];
    }
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
    // Adding the subviews to the header view
    [headerView addSubview:titleLabel];
    [headerView addSubview:imageView];
    
    UIImageView *background = [[[UIImageView alloc] initWithImage:
            (UIImage *)TTSTYLE(storesBackgroundHeader)] autorelease];
    [headerView insertSubview:background atIndex:0];
    [headerView setClipsToBounds:YES];
    return headerView;
}

#pragma mark -
#pragma mark <TTTableViewDataSource>

- (NSString *)titleForLoading:(BOOL)reloading
{
    return NSLocalizedString(kStoreDetailTitleForLoading, nil);
}

- (NSString *)titleForEmpty
{
    return  NSLocalizedString(kStoreDetailTitleForEmpty, nil);
}

- (NSString *)subtitleForEmpty
{
    return NSLocalizedString(kStoreDetailSubtitleForEmpty, nil);
}

- (NSString *)titleForError:(NSError *)error
{
    return NSLocalizedString(kStoreDetailTitleForError, nil);
}

- (NSString *)subtitleForError:(NSError *)error
{
    //return LOCALIZED_HTTP_REQUEST_ERROR(error);
    return NSLocalizedString(kStoreDetailSubtitleForError, nil);
}

- (void)tableViewDidLoadModel:(UITableView *)tableView
{
    if ([[self items] count] > 0) {
        return;
    }
    Store *store = (Store *)[self model];
    NSMutableArray *items = [NSMutableArray array];
    NSMutableArray *sections = [NSMutableArray array];
    NSString *pictureURL = [[store pictureURL] absoluteString];
    
    [sections addObject:kStoreDetailData];
    TableImageSubtitleItem *address = [TableImageSubtitleItem itemWithText:
            [NSString stringWithFormat:kStoreDetailAddress,
                [store storeAddress]]];
    TableImageSubtitleItem *attendance = [TableImageSubtitleItem itemWithText:
            [NSString stringWithFormat:kStoreDetailAttendance,
                [store attendance]]];
    TableImageSubtitleItem *phones = [TableImageSubtitleItem itemWithText:
            [NSString stringWithFormat:kStoreDetailPhones,
                [store phones]]];
    [items addObject:[NSArray arrayWithObjects:address, attendance,
            phones, nil]];
    
    [sections addObject:kStoreDetailServices];
    
    NSMutableArray *services = [NSMutableArray array];
    NSString *serviceString = @"";
    
    for (int i = 0; i < [[store services] count]; i++) {
        Service *service = [[store services] objectAtIndex:i];
        serviceString = [serviceString stringByAppendingString:[service name]];
        
        if (i != ([[store services] count] - 1)) {
            serviceString = [serviceString stringByAppendingString:@", "];
        } else {
            serviceString = [serviceString stringByAppendingString:@"."];
        }
    }
    TableImageSubtitleItem *item =
            [TableImageSubtitleItem itemWithText:serviceString];
    [services addObject:item];
    [_delegate dataSource:self viewForHeader:[self viewWithImageURL:pictureURL
            title:[store name]]];
    [items addObject:services];
    [self setSections:sections];
    [self setItems:items];
}

- (Class)tableView:(UITableView *)tableView cellClassForObject:(id)object
{
    if ([object isKindOfClass:[TableImageSubtitleItem class]])
        return [TableImageSubtitleItemCell class];
    return [super tableView:tableView cellClassForObject:object];
}
@end
