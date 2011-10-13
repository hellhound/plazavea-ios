#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Common/Views/TableImageSubtitleItem.h"

@implementation TableImageSubtitleItem

#pragma mark -
#pragma mark TableImageSubtitleItem

@synthesize imageStyle;

+ (id)itemWithText:(NSString*)text 
          subtitle:(NSString*)subtitle 
          imageURL:(NSString*)imageURL
{
  TableImageSubtitleItem *item = [[[self alloc] init] autorelease];
  [item setText:text];
  [item setSubtitle:subtitle];
  [item setImageURL:imageURL];
  return item;
}

+ (id)itemWithText:(NSString*)text 
          subtitle:(NSString*)subtitle 
          imageURL:(NSString*)imageURL 
               URL:(NSString*)URL
{
  TableImageSubtitleItem* item = [[[self alloc] init] autorelease];
  [item setText:text];
  [item setSubtitle:subtitle];
  [item setImageURL:imageURL];
  [item setURL:URL];
  return item;
}

+ (id)itemWithText:(NSString*)text 
          subtitle:(NSString*)subtitle 
          imageURL:(NSString*)imageURL
      defaultImage:(UIImage*)defaultImage 
               URL:(NSString*)URL
{
  TableImageSubtitleItem* item = [[[self alloc] init] autorelease];
  [item setText:text];
  [item setSubtitle:subtitle];
  [item setImageURL:imageURL];
  [item setDefaultImage:defaultImage];
  [item setURL:URL];
  return item;
}

+ (id)itemWithText:(NSString*)text 
          subtitle:(NSString*)subtitle 
          imageURL:(NSString*)imageURL
      defaultImage:(UIImage*)defaultImage 
        imageStyle:(TTStyle*)imageStyle 
               URL:(NSString*)URL
{
  TableImageSubtitleItem* item = [[[self alloc] init] autorelease];
  [item setText:text];
  [item setSubtitle:subtitle];
  [item setImageURL:imageURL];
  [item setDefaultImage:defaultImage];
  [item setImageStyle:imageStyle];
  [item setURL:URL];
  return item;
}

- (void)dealloc
{
    [imageStyle release];
    [super dealloc];
}

#pragma mark -
#pragma mark NSCoding

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super initWithCoder:decoder])
        [self setImageStyle:[decoder decodeObjectForKey:@"imageStyle"]];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [super encodeWithCoder:encoder];
    if ([self imageStyle] != nil)
        [encoder encodeObject:[self imageStyle] forKey:@"imageStyle"];
}
@end
