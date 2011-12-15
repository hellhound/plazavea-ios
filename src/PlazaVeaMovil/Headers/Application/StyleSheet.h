#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

@interface StyleSheet: TTDefaultStyleSheet

- (UIColor *)navigationBackgroundColor;
- (UIColor*)navigationTextColor;

- (UIColor*)headerColorYellow;

- (UIFont *)tableTextHeaderFont;
- (UIFont *)tableTextFont;

- (UIImageView *)launcherBackgroundImage;

- (UIImageView *)shopingListBackgroundHeader;
@end