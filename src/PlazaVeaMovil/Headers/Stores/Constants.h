// Store module's constants
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// Region model's constants

// JSON keys
extern NSString *const kRegionIdKey;
extern NSString *const kRegionNameKey;
extern NSString *const kRegionCountKey;
extern NSString *const kRegionSuggestedKey;

// RegionCollection model's constants

// JSON keys
extern NSString *const kRegionCollectionRegionsKey;

// SubregionCollection model's constants

// JSON keys
extern NSString *const kSubregionCollectionRegionsKey;

// Service model's constants's

// JSON keys
extern NSString *const kServiceIdKey;
extern NSString *const kServiceNameKey;
extern NSString *const kServiceURLKey;

// Store model's constants

// JSON keys
extern NSString *const kStoreIdKey;
extern NSString *const kStoreNameKey;
extern NSString *const kStoreAdressKey;
extern NSString *const kStorePictureURLKey;
extern NSString *const kStoreLatitudeKey;
extern NSString *const kStoreLongitudeKey;
extern NSString *const kStoreCodeKey;
extern NSString *const kStoreAttendanceKey;
extern NSString *const kStoreLocationKey;
extern NSString *const kStoreRegionKey;
extern NSString *const kStoreSubregionKey;
extern NSString *const kStoreDisctrictKey;
extern NSString *const kStoreUbigeoKey;
extern NSString *const kStorePhonesKey;
extern NSString *const kStoreServicesKey;

// StoreCollection's constants
extern NSString *const kStoreCollectionDistrictsKey;
extern NSString *const kStoreCollectionNameKey;
extern NSString *const kStoreCollectionIdKey;
extern NSString *const kStoreCollectionStoresKey;

// RegionListDataSource's constants

// Messages
extern NSString *const kRegionListTitleForLoading;
extern NSString *const kRegionListTitleForReloading;
extern NSString *const kRegionListTitleForEmpty;
extern NSString *const kRegionListSubtitleForEmpty;
extern NSString *const kRegionListTitleForError;
extern NSString *const kRegionListSubtitleForError;

// StoreListDataSource's constants

// Messages
extern NSString *const kStoreListTitleForLoading;
extern NSString *const kStoreListTitleForReloading;
extern NSString *const kStoreListTitleForEmpty;
extern NSString *const kStoreListSubtitleForEmpty;
extern NSString *const kStoreListTitleForError;
extern NSString *const kStoreListSubtitleForError;

// StoreDetailDataSource's constants

// Messages
extern NSString *const kStoreDetailTitleForLoading;
extern NSString *const kStoreDetailTitleForReloading;
extern NSString *const kStoreDetailTitleForEmpty;
extern NSString *const kStoreDetailSubtitleForEmpty;
extern NSString *const kStoreDetailTitleForError;
extern NSString *const kStoreDetailSubtitleForError;
extern NSString *const kStoreDetailData;
extern NSString *const kStoreDetailDistrict;
extern NSString *const kStoreDetailServices;
extern NSString *const kStoreDetailAddress;
extern NSString *const kStoreDetailAttendance;
extern NSString *const kStoreDetailPhones;

// StoreDetailController

// Generic sizes and images
extern const CGFloat kStoreDetailImageWidth;
extern const CGFloat kStoreDetailImageHeight;
extern const CGFloat kStoreDetailLabelWidth;
extern NSString *const kStoreDetailDefaultImage;

// RegionListController's constants

// Messages
extern NSString *const kRegionListTitle;
extern NSString *const kSubregionListTitle;
extern NSString *const kRegionLauncherTitle;

// StoreListController's constants

// Messages
extern NSString *const kStoreListTitle;

// StoreMapTogglingController's constants

typedef enum {
    kStoreSegmentedControlIndexListButton,
    kStoreSegmentedControlIndexMapButon,
    kStoreSegmentedControlIndexDefault = kStoreSegmentedControlIndexListButton
}StoreSegmentedControlIndexTypes;

extern NSString *const kStoreListButtonLabel;
extern NSString *const kStoreMapButtonLabel;

// StoreMapController's constants

extern NSString *const kStoreMapTitle;
extern NSString *const kStoreMapGPSButton;
extern NSString *const kStoreMapCurrentLocation;

// Controllers' URLs
extern NSString *const kURLRegionList;
extern NSString *const kURLSubregionList;
extern NSString *const kURLStoreList;
extern NSString *const kURLStoreDetail;
extern NSString *const kURLStoreMap;
extern NSString *const kURLStoreDetailMap;

// Controllers' URL calls
extern NSString *const kURLRegionListCall;
extern NSString *const kURLSubregionListCall;
extern NSString *const kURLStoreListCall;
extern NSString *const kURLStoreDetailCall;
extern NSString *const kURLStoreMapCall;
extern NSString *const kURLStoreDetailMapCall;

// Endpoint URLs
extern NSString *const kRegionListEndPoint;
extern NSString *const kSubregionListEndPoint;
extern NSString *const kStoreListEndPoint;
extern NSString *const kStoreDetailEndPoint;
