#import "math.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

#import <Three20/Three20.h>
#import "FBConnect.h"
#import "FBDialog.h"
#import "SA_OAuthTwitterController.h"

#import "Common/Constants.h"
#import "Common/Additions/TTStyleSheet+Additions.h"
#import "Application/Constants.h"
#import "Application/AppDelegate.h"
#import "Offers/Constants.h"
#import "Offers/Models.h"
#import "Offers/OfferDetailDataSource.h"
#import "Offers/OfferDetailController.h"

@interface OfferDetailController ()

@property (nonatomic, retain) Facebook *facebook;
@property (nonatomic, retain) SA_OAuthTwitterEngine *twitter;
- (NSString *)composeMail;
- (void)showTwitterAlert;
- (void)mailOffer;
- (void)likeOffer;
@end

@implementation OfferDetailController

#pragma mark -
#pragma mark NSObject

- (void) dealloc
{
    [_offerId release];
    [_offer release];
    [super dealloc];
}

#pragma mark -
#pragma mark TTTableViewController

- (void)createModel
{
    [self setDataSource:[[[OfferDetailDataSource alloc]
            initWithOfferId:_offerId delegate:self] autorelease]];
}

#pragma mark -
#pragma mark OfferDetailController (Private)

@synthesize facebook = _facebook, twitter = _twitter;

- (NSString *)composeMail
{
    NSString *html = [[[NSString alloc] initWithFormat:kDivTag,
            kMailBannerWidth] autorelease];
    html = [html stringByAppendingFormat:kImageTag, kMailBanner,
            kMailBannerWidth, kMailBannerHeight, kMailBannerWidth,
            kMailBannerHeight];
    html = [html stringByAppendingFormat:kTitleTag, [NSString
            stringWithFormat:@"%@ a %@", [_offer name],
                [NSString stringWithFormat:kOfferDetailPricePrefix,
                [[_offer price] floatValue]]]];
    html = [html stringByAppendingFormat:kImageTag, [_offer pictureURL],
            kMailBannerWidth, kMailImageHeight, kMailBannerWidth,
            kMailImageHeight];
    html = [html stringByAppendingFormat:kOldPriceTag,
            [NSString stringWithFormat:@"%@: %@", kOfferDetailOldPriceCaption,
                [NSString stringWithFormat:kOfferDetailPricePrefix,
                [[_offer oldPrice] floatValue]]]];
    NSDateFormatter *dateFormatter =
            [[[NSDateFormatter alloc] init] autorelease];
    
    //[dateFormatter setLocale:[NSLocale autoupdatingCurrentLocale]];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    
    NSString *validString = [NSString stringWithFormat:
            kOfferDetailValidPrefix,
                [dateFormatter stringFromDate:[_offer validFrom]],
                [dateFormatter stringFromDate:[_offer validTo]]];
    html = [html stringByAppendingFormat:kValidTag,
            [NSString stringWithFormat:@"%@: %@", kOfferDetailValidCaption,
                validString]];
    html = [html stringByAppendingFormat:kDescriptionTag,
            [[_offer longDescription] stringByReplacingOccurrencesOfString:@"\n"
                withString:@"<br />"]];
    html = [html stringByAppendingFormat:kLegaleseTag,
            [[_offer legalese] stringByReplacingOccurrencesOfString:@"\n"
                withString:@"<br />"]];
    html = [html stringByAppendingString:kMailFooterTag];
    html = [html stringByAppendingString:@"</div>"];
    
    return html;
}

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
                [_offer name], [[_offer twitterURL] absoluteString]]];
        [alertView show];
    }
}

- (void)mailOffer
{
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *controller = 
                [[[MFMailComposeViewController alloc] init] autorelease];
    
        [controller setMailComposeDelegate:self];
        [controller setSubject:[NSString stringWithFormat:
                kOfferMailSubject, [_offer name]]];
        [controller setMessageBody:[self composeMail] isHTML:YES];
        [self presentModalViewController:controller animated:YES];
    }
}

- (void)likeOffer
{
    _facebook = [(AppDelegate *)[[UIApplication sharedApplication]
            delegate] facebook];
    
    if (![_facebook isSessionValid])
        [_facebook authorize:nil];
    
    NSMutableDictionary *params = [NSMutableDictionary
            dictionaryWithObjectsAndKeys:
                [[_offer facebookURL] absoluteString], kFBLink,
                [[_offer pictureURL] absoluteString], kFBPicture,
                [_offer name], kFBCaption,
                [_offer longDescription], kFBDescription,
                nil];
    
    [_facebook dialog:kFBFeedDialog andParams:params andDelegate:nil];
}

#pragma mark -
#pragma mark OfferDetailController (Public)

@synthesize offerId = _offerId, offer = _offer;

- (id)initWithOfferId:(NSString *)offerId
{
    if ((self = [self initWithNibName:nil bundle:nil]) != nil) {
        [self setTableViewStyle:UITableViewStylePlain];
        [self setTitle:NSLocalizedString(kOfferDetailTitle, nil)];
        _offerId = [offerId copy];
        
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
#pragma mark <OfferDetailDataSourceDelegate>

- (void)dataSource:(OfferDetailDataSource *)dataSource needsOffer:(Offer *)offer
{
    if ([offer pictureURL] != nil) {
        _offer = [offer retain];
    }
}

- (void)dataSource:(OfferDetailDataSource *)dataSource
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
#pragma mark <FBSessionDelegate>

- (void)fbDidLogin
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:[_facebook accessToken] forKey:kAccessTokenKey];
    [defaults setObject:[_facebook expirationDate] forKey:kExpirationDateKey];
    [defaults synchronize];
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
            [_offer name], [[_offer twitterURL] absoluteString]]];
    [alertView show];
}
@end