#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Common/Constants.h"
#import "Common/Views/TableImageSubtitleItemCell.h"
#import "Common/Views/TableImageSubtitleItem.h"

#import "Wines/Models.h"
#import "Wines/Constants.h"
#import "Wines/WineDetailDataSource.h"

@implementation WineDetailDataSource

#pragma mark -
#pragma mark StoreDetailDataSource (public)


- (id)initWithWineId:(NSString *)wineId
{
    if ((self = [super init]) != nil) {
        [self setModel:[[[Wine alloc] initWithWineId:wineId] autorelease]];
    }
    return self;
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
    NSMutableArray *sections = [NSMutableArray array];
    
    // Info section
    [sections addObject:kWineInfoLabel];
    TTTableCaptionItem *country = [TTTableCaptionItem
            itemWithText:[[wine country] name] caption:kWineCountryLabel];
    TTTableCaptionItem *region = [TTTableCaptionItem
            itemWithText:[[wine region] name] caption:kWineRegionLabel];
    TTTableCaptionItem *brand = [TTTableCaptionItem
            itemWithText:[[wine brand] name] caption:kWineBrandLabel];
    TTTableCaptionItem *kind = [TTTableCaptionItem
            itemWithText:[[wine kind] name] caption:kWineKindLabel];
    TTTableCaptionItem *winery = [TTTableCaptionItem
            itemWithText:[[wine winery] name] caption:kWineWineryLabel];
    TTTableCaptionItem *harvest = [TTTableCaptionItem
            itemWithText:[[wine harvestYear] stringValue]
                caption:kWineHarvestYearLabel];
    TTTableCaptionItem *barrel = [TTTableCaptionItem
            itemWithText:[wine barrel] caption:kWineBarrelLabel];
    TTTableCaptionItem *price = [TTTableCaptionItem
            itemWithText:[[wine price] stringValue] caption:kWinePriceLabel];
    [items addObject:[NSArray arrayWithObjects:country, region, brand, kind,
            winery, harvest, barrel, price, nil]];
    // Taste section
    [sections addObject:kWineTastingLabel];
    TTTableCaptionItem *look = [TTTableCaptionItem
            itemWithText:[wine look] caption:kWineLookLabel];
    TTTableCaptionItem *taste = [TTTableCaptionItem
            itemWithText:[wine taste] caption:kWineTasteLabel];
    TTTableCaptionItem *smell = [TTTableCaptionItem
            itemWithText:[wine smell] caption:kWineSmellLabel];
    [items addObject:[NSArray arrayWithObjects:look, taste, smell, nil]];
    // Tips section
    [sections addObject:kWineTastingLabel];
    TTTableCaptionItem *temp = [TTTableCaptionItem itemWithText:
            [[wine temperature] stringValue] caption:kWineTemperatureLabel];
    TTTableCaptionItem *cellaring = [TTTableCaptionItem itemWithText:
            [[wine cellaring] stringValue] caption:kWineCellaringLabel];
    TTTableCaptionItem *oxygenation = [TTTableCaptionItem itemWithText:
            [[wine oxygenation] stringValue] caption:kWineOxygenationLabel];
    [items addObject:
            [NSArray arrayWithObjects:temp, cellaring, oxygenation, nil]];
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