#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

@interface WinePhotoSource: TTURLRequestModel <TTPhotoSource>
{
    NSString *_title;
    NSArray *_photos;
}
@property (nonatomic, copy) NSString *title;
@property (nonatomic, retain) NSArray *photos;

- (id)initWithTitle:(NSString *)title photos:(NSArray *)photos;
@end