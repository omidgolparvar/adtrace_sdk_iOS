//
//  Adtrace.h
//  Adtrace
//
//  Created by Aref on 9/8/20.
//  Copyright © 2020 Adtrace. All rights reserved.
//

#import "ADTEvent.h"
#import "ADTConfig.h"
#import "ADTAttribution.h"
#import "ADTSubscription.h"

@interface AdtraceTestOptions : NSObject

@property (nonatomic, copy, nullable) NSString *baseUrl;
@property (nonatomic, copy, nullable) NSString *gdprUrl;
@property (nonatomic, copy, nullable) NSString *subscriptionUrl;
@property (nonatomic, copy, nullable) NSString *extraPath;
@property (nonatomic, copy, nullable) NSNumber *timerIntervalInMilliseconds;
@property (nonatomic, copy, nullable) NSNumber *timerStartInMilliseconds;
@property (nonatomic, copy, nullable) NSNumber *sessionIntervalInMilliseconds;
@property (nonatomic, copy, nullable) NSNumber *subsessionIntervalInMilliseconds;
@property (nonatomic, assign) BOOL teardown;
@property (nonatomic, assign) BOOL deleteState;
@property (nonatomic, assign) BOOL noBackoffWait;
@property (nonatomic, assign) BOOL iAdFrameworkEnabled;
@property (nonatomic, assign) BOOL enableSigning;
@property (nonatomic, assign) BOOL disableSigning;

@end

/**
 * Constants for our supported tracking environments
 */
extern NSString * __nonnull const ADTEnvironmentSandbox;
extern NSString * __nonnull const ADTEnvironmentProduction;

/**
 * Constants for supported ad revenue sources.
 */
extern NSString * __nonnull const ADTAdRevenueSourceMopub;
extern NSString * __nonnull const ADTAdRevenueSourceAdmob;
extern NSString * __nonnull const ADTAdRevenueSourceFbNativeAd;
extern NSString * __nonnull const ADTAdRevenueSourceIronsource;
extern NSString * __nonnull const ADTAdRevenueSourceFyber;
extern NSString * __nonnull const ADTAdRevenueSourceAerserv;
extern NSString * __nonnull const ADTAdRevenueSourceAppodeal;
extern NSString * __nonnull const ADTAdRevenueSourceAdincube;
extern NSString * __nonnull const ADTAdRevenueSourceFusePowered;
extern NSString * __nonnull const ADTAdRevenueSourceAddaptr;
extern NSString * __nonnull const ADTAdRevenueSourceMillennialMeditation;
extern NSString * __nonnull const ADTAdRevenueSourceFlurry;
extern NSString * __nonnull const ADTAdRevenueSourceAdmost;
extern NSString * __nonnull const ADTAdRevenueSourceDeltadna;
extern NSString * __nonnull const ADTAdRevenueSourceUpsight;
extern NSString * __nonnull const ADTAdRevenueSourceUnityads;
extern NSString * __nonnull const ADTAdRevenueSourceAdtoapp;
extern NSString * __nonnull const ADTAdRevenueSourceTapdaq;

/**
 * Constants for country apps url strategies.
 */
extern NSString * __nonnull const ADTUrlStrategyIndia;
extern NSString * __nonnull const ADTUrlStrategyChina;

/**
 * @brief The main interface to Adtrace.
 *
 * @note Use the methods of this class to tell Adtrace about the usage of your app.
 *       See the README for details.
 */
@interface Adtrace : NSObject

/**
 * @brief Tell Adtrace that the application did launch.
 *        This is required to initialize Adtrace. Call this in the didFinishLaunching
 *        method of your AppDelegate.
 *
 * @note See ADTConfig.h for more configuration options
 *
 * @param adtraceConfig The configuration object that includes the environment
 *                     and the App Token of your app. This unique identifier can
 *                     be found it in your panel at http://panel.adtrace.io and should always
 *                     be 12 characters long.
 */
+ (void)appDidLaunch:(nullable ADTConfig *)adtraceConfig;

/**
 * @brief Tell Adtrace that a particular event has happened.
 *
 * @note See ADTEvent.h for more event options.
 *
 * @param event The Event object for this kind of event. It needs a event token
 *              that is created in the panel at http://panel.adtrace.io and should be six
 *              characters long.
 */
+ (void)trackEvent:(nullable ADTEvent *)event;

/**
 * @brief Tell adtrace that the application resumed.
 *
 * @note Only necessary if the native notifications can't be used
 *       or if they will happen before call to appDidLaunch: is made.
 */
+ (void)trackSubsessionStart;

/**
 * @brief Tell adtrace that the application paused.
 *
 * @note Only necessary if the native notifications can't be used.
 */
+ (void)trackSubsessionEnd;

/**
 * @brief Enable or disable the adtrace SDK. This setting is saved for future sessions.
 *
 * @param enabled The flag to enable or disable the adtrace SDK.
 */
+ (void)setEnabled:(BOOL)enabled;

/**
 * @brief Check if the SDK is enabled or disabled.
 *
 * return Boolean indicating whether SDK is enabled or not.
 */
+ (BOOL)isEnabled;

/**
 * @brief Read the URL that opened the application to search for an adtrace deep link.
 *
 * @param url URL object which contains info about adtrace deep link.
 */
+ (void)appWillOpenUrl:(nonnull NSURL *)url;

/**
 * @brief Set the device token used by push notifications.
 *
 * @param deviceToken Apple push notification token for iOS device as NSData.
 */
+ (void)setDeviceToken:(nonnull NSData *)deviceToken;

/**
 * @brief Set the device token used by push notifications.
 *        This method is only used by Adtrace non native SDKs. Don't use it anywhere else.
 *
 * @param pushToken Apple push notification token for iOS device as NSString.
 */
+ (void)setPushToken:(nonnull NSString *)pushToken;

/**
 * @brief Enable or disable offline mode. Activities won't be sent but they are saved when
 *        offline mode is disabled. This feature is not saved for future sessions.
 *
 * @param enabled The flag to enable or disable offline mode.
 */
+ (void)setOfflineMode:(BOOL)enabled;

/**
 * @brief Retrieve iOS device IDFA value.
 *
 * @return Device IDFA value.
 */
+ (nullable NSString *)idfa;

/**
 * @brief Get current adtrace identifier for the user.
 *
 * @note Adtrace identifier is available only after installation has been successfully tracked.
 *
 * @return Current adtrace identifier value for the user.
 */
+ (nullable NSString *)adid;

/**
 * @brief Get current attribution for the user.
 *
 * @note Attribution information is available only after installation has been successfully tracked
 *       and attribution information arrived after that from the backend.
 *
 * @return Current attribution value for the user.
 */
+ (nullable ADTAttribution *)attributionAdtrace;

/**
 * @brief Get current Adtrace SDK version string.
 *
 * @return Adtrace SDK version string (iosX.Y.Z).
 */
+ (nullable NSString *)sdkVersion;

/**
 * @brief Convert a universal link style URL to a deeplink style URL with the corresponding scheme.
 *
 * @param url URL object which contains info about adtrace deep link.
 * @param scheme Desired scheme to which you want your resulting URL object to be prefixed with.
 *
 * @return URL object in custom URL scheme style prefixed with given scheme name.
 */
+ (nullable NSURL *)convertUniversalLink:(nonnull NSURL *)url scheme:(nonnull NSString *)scheme;

/**
 * @brief Tell the adtrace SDK to stop waiting for delayed initialisation timer to complete but rather to start
 *        upon this call. This should be called if you have obtained needed callback/partner parameters which you
 *        wanted to put as default ones before the delayedStart value you have set on ADTConfig has expired.
 */
+ (void)sendFirstPackages;

/**
 * @brief Tell adtrace to send the request to Google and check if the installation
 *        belongs to Google AdWords campaign.
 *
 * @note Deprecated method, should not be used.
 */
+ (void)sendAdWordsRequest;

/**
 * @brief Add default callback parameter key-value pair which is going to be sent with each tracked session and event.
 *
 * @param key Default callback parameter key.
 * @param value Default callback parameter value.
 */
+ (void)addSessionCallbackParameter:(nonnull NSString *)key value:(nonnull NSString *)value;

/**
 * @brief Add default partner parameter key-value pair which is going to be sent with each tracked session.
 *
 * @param key Default partner parameter key.
 * @param value Default partner parameter value.
 */
+ (void)addSessionPartnerParameter:(nonnull NSString *)key value:(nonnull NSString *)value;

/**
 * @brief Remove default callback parameter from the session packages.
 *
 * @param key Default callback parameter key.
 */
+ (void)removeSessionCallbackParameter:(nonnull NSString *)key;

/**
 * @brief Remove default partner parameter from the session packages.
 *
 * @param key Default partner parameter key.
 */
+ (void)removeSessionPartnerParameter:(nonnull NSString *)key;

/**
 * @brief Remove all default callback parameters from the session packages.
 */
+ (void)resetSessionCallbackParameters;

/**
 * @brief Remove all default partner parameters from the session packages.
 */
+ (void)resetSessionPartnerParameters;

/**
 * @brief Give right user to be forgotten in accordance with GDPR law.
 */
+ (void)gdprForgetMe;

/**
 * @brief Track ad revenue for given source.
 *
 * @param source Ad revenue source.
 * @param payload Ad revenue payload.
 */
+ (void)trackAdRevenue:(nonnull NSString *)source payload:(nonnull NSData *)payload;

/**
 * @brief Give right user to disable sharing data to any third-party.
 */
+ (void)disableThirdPartySharing;

/**
 * @brief Track subscription.
 *
 * @param subscription Subscription object.
 */
+ (void)trackSubscription:(nonnull ADTSubscription *)subscription;

+ (void)requestTrackingAuthorizationWithCompletionHandler:(void (^_Nullable)(NSUInteger status))completion;

/**
 * Obtain singleton Adtrace object.
 */
+ (nullable id)getInstance;

+ (void)setTestOptions:(nullable AdtraceTestOptions *)testOptions;

- (void)appDidLaunch:(nullable ADTConfig *)adtraceConfig;

- (void)trackEvent:(nullable ADTEvent *)event;

- (void)setEnabled:(BOOL)enabled;

- (void)teardown;

- (void)appWillOpenUrl:(nonnull NSURL *)url;

- (void)setOfflineMode:(BOOL)enabled;

- (void)setDeviceToken:(nonnull NSData *)deviceToken;

- (void)setPushToken:(nonnull NSString *)pushToken;

- (void)sendFirstPackages;

- (void)trackSubsessionEnd;

- (void)trackSubsessionStart;

- (void)resetSessionPartnerParameters;

- (void)resetSessionCallbackParameters;

- (void)removeSessionPartnerParameter:(nonnull NSString *)key;

- (void)removeSessionCallbackParameter:(nonnull NSString *)key;

- (void)addSessionPartnerParameter:(nonnull NSString *)key value:(nonnull NSString *)value;

- (void)addSessionCallbackParameter:(nonnull NSString *)key value:(nonnull NSString *)value;

- (void)gdprForgetMe;

- (void)trackAdRevenue:(nonnull NSString *)source payload:(nonnull NSData *)payload;

- (void)trackSubscription:(nonnull ADTSubscription *)subscription;

- (BOOL)isEnabled;

- (nullable NSString *)adid;

- (nullable NSString *)idfa;

- (nullable NSString *)sdkVersion;

- (nullable ADTAttribution *)attributionInstance;

- (nullable NSURL *)convertUniversalLink:(nonnull NSURL *)url scheme:(nonnull NSString *)scheme;

- (void)requestTrackingAuthorizationWithCompletionHandler:(void (^_Nullable)(NSUInteger status))completion;

@end
