#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

@interface StyleSheet: TTDefaultStyleSheet

- (UIStatusBarStyle)statusBarStyle;
- (UIColor*)headerColorYellow;
- (UIFont *)tableTextHeaderFont;
- (UIFont *)tableTextFont;

//Launcher
- (UIImageView *)launcherBackgroundImage;

//ShoppingLists
- (UIImageView *)launcherBackgroundImage;
- (UIImage *)shopingListBackgroundHeader;
@end
