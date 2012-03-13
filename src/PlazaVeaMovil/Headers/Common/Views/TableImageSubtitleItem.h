#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

@interface TableImageSubtitleItem: TTTableSubtitleItem
{
    TTStyle *imageStyle;
    id extra;
}
@property (nonatomic, assign) id extra;
@property (nonatomic, retain) TTStyle *imageStyle;

+ (id)itemWithText:(NSString*)text 
          subtitle:(NSString*)subtitle 
          imageURL:(NSString*)imageURL;
+ (id)itemWithText:(NSString*)text 
          subtitle:(NSString*)subtitle 
          imageURL:(NSString*)imageURL 
               URL:(NSString*)URL;
+ (id)itemWithText:(NSString*)text 
          subtitle:(NSString*)subtitle 
          imageURL:(NSString*)imageURL
      defaultImage:(UIImage*)defaultImage 
               URL:(NSString*)URL;
+ (id)itemWithText:(NSString*)text 
          subtitle:(NSString*)subtitle 
          imageURL:(NSString*)imageURL
      defaultImage:(UIImage*)defaultImage 
        imageStyle:(TTStyle*)imageStyle 
               URL:(NSString*)URL;
@end
