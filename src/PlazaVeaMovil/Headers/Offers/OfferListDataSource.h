#import <Foundation/Foundation.h>

#import <Three20/Three20.h>

@protocol OfferListDataSourceDelegate;

@interface OfferListDataSource: TTListDataSource
{
    id<OfferListDataSourceDelegate> _delegate;
}
@property (nonatomic, assign) id delegate;

- (id)initWithListDelegate:(id<OfferListDataSourceDelegate>)delegate;
@end

@protocol OfferListDataSourceDelegate <NSObject>
- (void)dataSource:(OfferListDataSource *)dataSource
     needsBannerId:(NSNumber *)bannerId;
@end