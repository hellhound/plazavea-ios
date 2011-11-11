#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Common/Views/TableCaptionItem.h"

@implementation TableCaptionItem

@synthesize caption = _caption;

- (void)dealloc
{
    [_caption release];
    [super dealloc];
}

#pragma mark -
#pragma mark Class public

+ (id)itemWithText:(NSString*)text caption:(NSString*)caption
{
    TTTableCaptionItem* item = [[[self alloc] init] autorelease];
    
    item.text = text;
    item.caption = caption;
    return item;
}

+ (id)itemWithText:(NSString*)text
           caption:(NSString*)caption
               URL:(NSString*)URL
{
    TTTableCaptionItem* item = [[[self alloc] init] autorelease];
    
    item.text = text;
    item.caption = caption;
    item.URL = URL;
    return item;
}

+ (id)itemWithText:(NSString*)text
           caption:(NSString*)caption
               URL:(NSString*)URL
      accessoryURL:(NSString*)accessoryURL
{
    TTTableCaptionItem* item = [[[self alloc] init] autorelease];
    
    item.text = text;
    item.caption = caption;
    item.URL = URL;
    item.accessoryURL = accessoryURL;
    return item;
}

#pragma mark -
#pragma mark NSCoding

- (id)initWithCoder:(NSCoder*)decoder
{
    if (self = [super initWithCoder:decoder]) {
        self.caption = [decoder decodeObjectForKey:@"caption"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder*)encoder
{
    [super encodeWithCoder:encoder];
    if (self.caption) {
        [encoder encodeObject:self.caption forKey:@"caption"];
    }
}
@end