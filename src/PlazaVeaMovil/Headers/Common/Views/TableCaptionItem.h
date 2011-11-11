#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

@interface TableCaptionItem: TTTableTextItem
{
  NSString* _caption;
}
@property (nonatomic, copy) NSString* caption;

+ (id)itemWithText:(NSString*)text caption:(NSString*)caption;
+ (id)itemWithText:(NSString*)text
           caption:(NSString*)caption
               URL:(NSString*)URL;
+ (id)itemWithText:(NSString*)text
           caption:(NSString*)caption
               URL:(NSString*)URL
      accessoryURL:(NSString*)accessoryURL;
@end
