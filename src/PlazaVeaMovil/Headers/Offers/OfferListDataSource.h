#import <Foundation/Foundation.h>

#import <Three20/Three20.h>

@protocol OfferListDataSourceDelegate;

@interface OfferListDataSource : TTListDataSource
{
    id<OfferListDataSourceDelegate> _delegate;
}
@property (nonatomic, readonly) id delegate;

- (id)initWithImageDelegate:(id<OfferListDataSourceDelegate>)delegate;
@end

@protocol OfferListDataSourceDelegate <NSObject>

- (void)        dataSource:(OfferListDataSource *)dataSource
    needsOfferImageWithURL:(NSURL *)imageURL;
@end