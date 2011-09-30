#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

@interface RecipeHeaderView: UIView
{
    NSURL *_imageURL;
    NSURL *_defaultImageURL;
    TTImageStyle *_imageStyle;
    NSString *_text;
}
@property (nonatomic, retain) NSURL *imageURL;
@property (nonatomic, retain) NSURL *defaultImageURL;
@property (nonatomic, retain) TTImageStyle *imageStyle;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, retain) TTTextStyle *textStyle;

+ (id)recipeHeaderViewWithImageURL:(NSURL *)imageURL
                   defaultImageURL:(NSURL *)defaultImageURL
                        imageStyle:(TTImageStyle *)imageStyle
                              text:(NSString *)text
                         textStyle:(TTTextStyle *)textStyle;

- (id)initWithImageURL:(NSURL *)imageURL
       defaultImageURL:(NSURL *)defaultImageURL
            imageStyle:(TTImageStyle *)imageStyle
                  text:(NSString *)text
             textStyle:(TTTextStyle *)textStyle;
@end
