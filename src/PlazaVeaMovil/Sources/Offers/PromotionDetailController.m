#import "math.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

#import "Common/Constants.h"
#import "Common/Additions/TTStyleSheet+Additions.h"
#import "Common/Additions/UIDevice+Additions.h"
#import "Application/AppDelegate.h"
#import "Offers/Constants.h"
#import "Offers/Models.h"
#import "Offers/PromotionDetailDataSource.h"
#import "Offers/PromotionDetailController.h"

@interface PromotionDetailController ()

@property (nonatomic, retain) Facebook *facebook;
@property (nonatomic, retain) SA_OAuthTwitterEngine *twitter;
- (void)showTwitterAlert;
- (void)mailPromotion;
- (void)likePromotion;
@end

@implementation PromotionDetailController

#pragma mark -
#pragma mark NSObject

- (void)dealloc
{
    [_promotionId release];
    [_promotion release];
    [super dealloc];
}

#pragma mark -
#pragma mark TTTableViewController

- (void)createModel
{
    [self setDataSource:[[[PromotionDetailDataSource alloc]
            initWithPromotionId:_promotionId delegate:self] autorelease]];
}

#pragma mark -
#pragma PromotionDetailController (Private)

@synthesize facebook = _facebook, twitter = _twitter;

- (void) showTwitterAlert
{
    _twitter = [(AppDelegate *)[[UIApplication sharedApplication] delegate]
            twitter];
    
    if (![_twitter isAuthorized]) {
        SA_OAuthTwitterController *controller = [SA_OAuthTwitterController
                controllerToEnterCredentialsWithTwitterEngine:_twitter
                    delegate:self];
        
        [self presentModalViewController:controller animated:YES];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc]
                initWithTitle:kTwitterAlertTitle message:nil delegate:self
                    cancelButtonTitle:kTwitterAlertCancel
                    otherButtonTitles:kTwitterAlertSend, nil];
    
        [alertView setMessage:[NSString stringWithFormat:kTwitterAlertMessage,
                [_promotion name], [[_promotion twitterURL] absoluteString]]];
        [alertView show];
    }
}

- (void)mailPromotion
{
    NSString *bannerURL = IMAGE_URL([NSURL URLWithString:
            kMailBanner], kMailBannerWidth, kMailBannerHeight);
    NSString *imageHTML = [NSString stringWithFormat:@"<img src=\'%@\' />",
            bannerURL];
    NSString *offerImageHTML = [NSString stringWithFormat:@"<img src=\'%@\' />",
            [[_promotion bannerURL] absoluteString]];
    MFMailComposeViewController *controller = 
            [[[MFMailComposeViewController alloc] init] autorelease];
    
    [controller setMailComposeDelegate:self];
    [controller setSubject:[_promotion name]];
    [controller setMessageBody:[NSString stringWithFormat:
            @"%@<br /><b>%@</b><br />%@<br />%@<br />%@", imageHTML,
                [_promotion name], offerImageHTML, [_promotion longDescription],
                [_promotion legalese]] isHTML:YES];
    [self presentModalViewController:controller animated:YES];
}

- (void)likePromotion
{
    _facebook = [(AppDelegate *)[[UIApplication sharedApplication]
            delegate] facebook];
    
    if (![_facebook isSessionValid])
        [_facebook authorize:nil];
    
    NSMutableDictionary *params = [NSMutableDictionary
            dictionaryWithObjectsAndKeys:
                [[_promotion facebookURL] absoluteString], kFBLink,
                [[_promotion bannerURL] absoluteString], kFBPicture,
                [_promotion name], kFBCaption,
                [_promotion longDescription], kFBDescription,
                nil];
    
    [_facebook dialog:kFBFeedDialog andParams:params andDelegate:nil];
}

#pragma mark -
#pragma mark PromotionDetailController (Public)

@synthesize promotionId = _promotionId, promotion = _promotion;

- (id)initWithPromotionId:(NSString *)promotionId
{
    if ((self = [self initWithNibName:nil bundle:nil]) != nil) {
        [self setTableViewStyle:UITableViewStylePlain];
        [self setTitle:NSLocalizedString(kPromotionDetailTitle, nil)];
        _promotionId = [promotionId copy];
        
        [self setStatusBarStyle:UIStatusBarStyleBlackOpaque];
        if ([TTStyleSheet
                hasStyleSheetForSelector:@selector(navigationBarLogo)]) {
            [[self navigationItem] setTitleView:[[[UIImageView alloc]
                    initWithImage:(UIImage *)TTSTYLE(navigationBarLogo)]
                        autorelease]];
        }
    }
    return self;
}

#pragma mark -
#pragma mark <PromotionDetailDataSourceDelegate>

- (void)dataSource:(PromotionDetailDataSource *)dataSource
    needsPromotion:(Promotion *)promotion
{
    if ([promotion bannerURL] != nil)
        _promotion = [promotion retain];
}

- (void)dataSource:(PromotionDetailDataSource *)dataSource
     viewForHeader:(UIView *)view
{
    [[self tableView] setTableHeaderView:view];
}
#pragma mark -
#pragma mark <MFMailComposerControllerDelegate>

- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError *)error
{
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark <UIAlertView>

- (void)    alertView:(UIAlertView *)alertView
 clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != [alertView cancelButtonIndex]) 
        [_twitter sendUpdate:[alertView message]];
    [alertView release];
}

#pragma mark -
#pragma mark <SA_OAuthTwitterControllerDelegate>

- (void)OAuthTwitterController:(SA_OAuthTwitterController *)controller
     authenticatedWithUsername:(NSString *)username
{
    UIAlertView *alertView = [[UIAlertView alloc]
            initWithTitle:kTwitterAlertTitle message:nil delegate:self
                cancelButtonTitle:kTwitterAlertCancel
                otherButtonTitles:kTwitterAlertSend, nil];
    
    [alertView setMessage:[NSString stringWithFormat:kTwitterAlertMessage,
            [_promotion name], [[_promotion twitterURL] absoluteString]]];
    [alertView show];
}
@end
