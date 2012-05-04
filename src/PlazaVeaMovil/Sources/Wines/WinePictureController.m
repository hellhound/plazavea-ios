#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Wines/Models.h"
#import "Wines/Constants.h"
#import "Wines/WinePhotoSource.h"
#import "Wines/WinePictureController.h"

@implementation WinePictureController

#pragma mark -
#pragma mark UIViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_scrollView setScrollEnabled:NO];
    [_toolbar setHidden:YES];
    [self scrollView:_scrollView tapped:nil];
}
#pragma mark -
#pragma mark WinePictureController

- (id)initWithURL:(NSString *)pictureURL title:(NSString *)title
{
    NSString *caption = [title stringByReplacingOccurrencesOfString:@"-"
            withString:@" "];
    NSString *url = [pictureURL stringByReplacingOccurrencesOfString:@"-"
            withString:@"/"];
    url = [url stringByAppendingFormat:@"?width=320&height=480"];
    WineLargeImage *photo = [[WineLargeImage alloc] initWithPictureURL:url];
    WinePhotoSource *photoSource = [[WinePhotoSource alloc]
            initWithTitle:caption photos:[NSArray arrayWithObjects:photo, nil]];
    
    if ((self = [super initWithPhotoSource:photoSource]) != nil) {
    }
    return self;
}

- (id)initWithURL:(NSString *)pictureURL
{
    if ((self = [self initWithURL:pictureURL title:nil]) != nil) {
    }
    return self;
}
@end
