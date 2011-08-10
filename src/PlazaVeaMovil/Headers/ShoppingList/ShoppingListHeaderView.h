#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "ShoppingList/ShoppingList.h"

@interface ShoppingListHeaderView: UIView
{
    ShoppingList *_shoppingList; 
    UILabel *_titleLabel;
    UILabel *_dateLabel;
}

- (id)initWithShoppingList:(ShoppingList *)shoppingList;
@end
