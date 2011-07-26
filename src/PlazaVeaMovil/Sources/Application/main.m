#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "AppDelegate.h"

int main(int argc, char **argv)
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    int retVal = UIApplicationMain(argc, argv, nil,
            NSStringFromClass([AppDelegate class]));

    [pool drain];
    return retVal;
}
