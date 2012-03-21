#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Wines/Models.h"
#import "Wines/Constants.h"
#import "Wines/WinePictureController.h"

@implementation WinePictureController

#pragma mark -
#pragma mark WinePictureController

- (id)initWithURL:(NSString *)pictureURL
{
    NSString *url = [pictureURL stringByReplacingOccurrencesOfString:@"-"
            withString:@"/"];
    WineLargeImage *photo = [[[WineLargeImage alloc] initWithPictureURL:url]
            autorelease];
    
    NSLog(@"%@", [photo URLForVersion:TTPhotoVersionLarge]);
    if ((self = [super initWithPhoto:photo]) != nil) {
        
    }
    return self;
}

@end
