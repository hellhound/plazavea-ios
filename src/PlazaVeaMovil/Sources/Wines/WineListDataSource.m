#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Common/Constants.h"
#import "Common/Additions/TTStyleSheet+Additions.h"
#import "Common/Views/TableImageSubtitleItem.h"
#import "Common/Views/TableImageSubtitleItemCell.h"
#import "Wines/Constants.h"
#import "Wines/Models.h"
#import "Wines/WineListDataSource.h"

static CGFloat margin = 5.;
static CGFloat headerMinHeight = 40.;
static CGFloat titleWidth = 320.;

@implementation WineListDataSource

#pragma mark -
#pragma NSObject

- (void)dealloc
{
    [self setDelegate:nil];
    [super dealloc];
}

#pragma mark -
#pragma mark WineListDataSource (public)

@synthesize  delegate = _delegate;


- (id)initWithCategoryId:(NSString *)categoryId
{
    if ((self = [super init]) != nil) {
        [self setModel:[[[WineCollection alloc] initWithCategoryId:categoryId]
                autorelease]];
    }
    return self;
}

- (id)initWithCategoryId:(NSString *)categoryId
                delegate:(id<WineListDataSourceDelegate>)delegate
{
    if ((self = [self initWithCategoryId:categoryId]) != nil) {
        [self setDelegate:delegate];
    }
    return self;
}

- (UIView *)viewWithImageURL:(NSString *)imageURL title:(NSString *)title
{
    UIView *headerView =
            [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    // Conf the image
    UIImageView *imageView;
    
    if (imageURL != nil) {
        imageView = [[[UIImageView alloc]
                initWithImage:TTIMAGE(kWineBannerImage)] autorelease];
        
        [imageView setAutoresizingMask:UIViewAutoresizingNone];
        [imageView setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin |
                UIViewAutoresizingFlexibleRightMargin];
        [imageView setBackgroundColor:[UIColor clearColor]];
    } else {
        imageView = nil;
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
    [headerView addSubview:titleLabel];
    [headerView addSubview:imageView];
    
    UIImageView *background = [[[UIImageView alloc]
            initWithImage:TTIMAGE(kWineBackgroundImage)] autorelease];
    [headerView insertSubview:background atIndex:0];
    [headerView setClipsToBounds:YES];
    return headerView;
}


#pragma mark -
#pragma mark <UITableViewDataSource>

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return [(WineCollection *)[self model] sectionIndexTitles];
}

#pragma mark -
#pragma mark <TTTableViewDataSource>

- (NSString *)titleForLoading:(BOOL)reloading
{
    return NSLocalizedString(kWineListTitleForLoading, nil);
}

- (NSString *)titleForEmpty
{
    return NSLocalizedString(kWineListTitleForEmpty, nil);
}

- (NSString *)subtitleForEmpty
{
    return NSLocalizedString(kWineListSubtitleForEmpty, nil);
}

- (NSString *)titleForError:(NSError *)error
{
    return NSLocalizedString(kWineListTitleForError, nil);
}

- (NSString *)subtitleForError:(NSError *)error
{
    //return LOCALIZED_HTTP_REQUEST_ERROR(error);
    return NSLocalizedString(kWineListSubtitleForError, nil);
}

- (void)tableViewDidLoadModel:(UITableView *)tableView
{
    if ([[self items] count] > 0) {
        return;
    }
    WineCollection *collection = (WineCollection *)[self model];
    NSArray *sections = [collection sections];
    
    [_delegate dataSource:self viewForHeader:[self viewWithImageURL:nil
            title:kWineListTitle]]; 
    
    if ([sections count] > 0) {
        NSMutableArray *items =
                [NSMutableArray arrayWithCapacity:[sections count]];
        
        for (NSArray *section in sections) {
            NSMutableArray *sectionItems =
            [NSMutableArray arrayWithCapacity:[sections count]];
            
            for (Wine *wine in section) {
                TableImageSubtitleItem *item = [TableImageSubtitleItem
                        itemWithText:[wine name] subtitle:nil
                            URL:URL(kURLWineDetailCall, [wine wineId])];
                
                [sectionItems addObject:item];
            }
            [items addObject:sectionItems];
        }
        [self setSections:[[collection sectionTitles] mutableCopy]];
        [self setItems:items];
    }
}

- (Class)tableView:(UITableView *)tableView cellClassForObject:(id)object
{
    if ([object isKindOfClass:[TableImageSubtitleItem class]])
        return [TableImageSubtitleItemCell class];
    return [super tableView:tableView cellClassForObject:object];
}
@end