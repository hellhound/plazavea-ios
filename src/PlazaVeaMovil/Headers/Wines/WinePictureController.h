#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

@interface WinePictureController: TTPhotoViewController
{
    
}
- (id)initWithURL:(NSString *)pictureURL;
- (id)initWithURL:(NSString *)pictureURL title:(NSString *)title;
@end
