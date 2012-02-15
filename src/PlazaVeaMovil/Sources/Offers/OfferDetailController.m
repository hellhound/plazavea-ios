#import "math.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

#import <Three20/Three20.h>
#import "FBConnect.h"
#import "FBDialog.h"
#import "SA_OAuthTwitterController.h"

#import "Common/Additions/TTStyleSheet+Additions.h"
#import "Application/Constants.h"
#import "Application/AppDelegate.h"
#import "Offers/Constants.h"
#import "Offers/Models.h"
#import "Offers/OfferDetailDataSource.h"
#import "Offers/OfferDetailController.h"

@interface OfferDetailController ()

@property (nonatomic, retain) UIView *headerView;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) TTImageView *imageView;
@property (nonatomic, retain) Facebook *facebook;
@property (nonatomic, retain) SA_OAuthTwitterEngine *twitter;
- (void)showTwitterAlert;
- (void)mailOffer;
- (void)likeOffer;
- (void)tweetOffer:(NSString *)tweet;
@end

@implementation OfferDetailController

#pragma mark -
#pragma mark NSObject

- (void) dealloc
{
    [_offerId release];
    [_headerView release];
    [_titleLabel release];
    [_imageView release];
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

@synthesize headerView = _headerView, titleLabel = _titleLabel,
        imageView = _imageView, facebook = _facebook, twitter = _twitter;

- (void) showTwitterAlert
{
    UIAlertView *alertView = [[UIAlertView alloc]
            initWithTitle:kTwitterAlertTitle
                message:nil delegate:self cancelButtonTitle:kTwitterAlertCancel
                otherButtonTitles:kTwitterAlertSend, nil];
    
    [alertView setMessage:[NSString stringWithFormat:kTwitterAlertMessage,
            [_offer name], [[_offer twitterURL] absoluteString]]];
    [alertView show];
}

- (void)mailOffer
{
    MFMailComposeViewController *controller = 
            [[[MFMailComposeViewController alloc] init] autorelease];
    
    [controller setMailComposeDelegate:self];
    [controller setSubject:[_offer name]];
    [controller setMessageBody:[_offer longDescription] isHTML:NO];
    [self presentModalViewController:controller animated:YES];
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

- (void)tweetOffer:(NSString *)tweet
{
    _twitter = [(AppDelegate *)[[UIApplication sharedApplication] delegate]
            twitter];
    
    if (![_twitter isAuthorized]) {
        SA_OAuthTwitterController *controller = [SA_OAuthTwitterController
                controllerToEnterCredentialsWithTwitterEngine:_twitter
                    delegate:self];
    
        [self presentModalViewController:controller animated:YES];
    }
    [_twitter sendUpdate:tweet];
}

#pragma mark -
#pragma mark OfferDetailController (Public)

@synthesize offer = _offer;

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
#pragma <FBSessionDelegate>

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
        [self tweetOffer:[alertView message]];
    [alertView release];
}
@end