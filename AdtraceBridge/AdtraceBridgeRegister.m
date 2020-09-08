//
//  AdtraceBridgeRegister.m
//  Adtrace SDK
//
//  Created by Pedro Filipe (@nonelse) on 10th June 2016.
//  Copyright © 2016-2018 Adtrace GmbH. All rights reserved.
//

#import "AdtraceBridgeRegister.h"

static NSString * const kHandlerPrefix = @"adtrace_";
static NSString * fbAppIdStatic = nil;

@interface AdtraceBridgeRegister()

@property (nonatomic, strong) WKWebViewJavascriptBridge *wkwvjb;

@end

@implementation AdtraceBridgeRegister

- (id)initWithWKWebView:(WKWebView*)webView {
    self = [super init];
    if (self == nil) {
        return nil;
    }

    self.wkwvjb = [WKWebViewJavascriptBridge bridgeForWebView:webView];
    return self;
}

- (void)setWKWebViewDelegate:(id<WKNavigationDelegate>)webViewDelegate {
    [self.wkwvjb setWebViewDelegate:webViewDelegate];
}

- (void)callHandler:(NSString *)handlerName data:(id)data {
    [self.wkwvjb callHandler:handlerName data:data];
}

- (void)registerHandler:(NSString *)handlerName handler:(WVJBHandler)handler {
    [self.wkwvjb registerHandler:handlerName handler:handler];
}

- (void)augmentHybridWebView:(NSString *)fbAppId {
    fbAppIdStatic = fbAppId;
}

+ (NSString *)AdtraceBridge_js {
    if (fbAppIdStatic != nil) {
        return [NSString stringWithFormat:@"%@%@",
                [AdtraceBridgeRegister adtrace_js],
                [AdtraceBridgeRegister augmented_js]];
    } else {
        return [AdtraceBridgeRegister adtrace_js];
    }
}

#define __adj_js_func__(x) #x
// BEGIN preprocessorJSCode

+ (NSString *)augmented_js {
    return [NSString stringWithFormat:
        @__adj_js_func__(;(function() {
            window['fbmq_%@'] = {
                'getProtocol' : function() {
                    return 'fbmq-0.1';
                },
                'sendEvent': function(pixelID, evtName, customData) {
                    Adtrace.fbPixelEvent(pixelID, evtName, customData);
                }
            };
        })();) // END preprocessorJSCode
     , fbAppIdStatic];
}

+ (NSString *)adtrace_js {
    static NSString *preprocessorJSCode = @__adj_js_func__(;(function() {
        if (window.Adtrace) {
            return;
        }

        // Copied from adtrace.js
        window.Adtrace = {
            appDidLaunch: function(adtraceConfig) {
                if (WebViewJavascriptBridge) {
                    if (adtraceConfig) {
                        if (!adtraceConfig.getSdkPrefix()) {
                            adtraceConfig.setSdkPrefix(this.getSdkPrefix());
                        }
                        this.sdkPrefix = adtraceConfig.getSdkPrefix();
                        adtraceConfig.registerCallbackHandlers();
                        WebViewJavascriptBridge.callHandler('adtrace_appDidLaunch', adtraceConfig, null);
                    }
                }
            },
            trackEvent: function(adtraceEvent) {
                if (WebViewJavascriptBridge) {
                    WebViewJavascriptBridge.callHandler('adtrace_trackEvent', adtraceEvent, null);
                }
            },
            trackAdRevenue: function(source, payload) {
                if (WebViewJavascriptBridge != null) {
                    WebViewJavascriptBridge.callHandler('adtrace_trackAdRevenue', {source: source, payload: payload}, null);
                }
            },
            trackSubsessionStart: function() {
                if (WebViewJavascriptBridge) {
                    WebViewJavascriptBridge.callHandler('adtrace_trackSubsessionStart', null, null);
                }
            },
            trackSubsessionEnd: function() {
                if (WebViewJavascriptBridge) {
                    WebViewJavascriptBridge.callHandler('adtrace_trackSubsessionEnd', null, null);
                }
            },
            setEnabled: function(enabled) {
                if (WebViewJavascriptBridge) {
                    WebViewJavascriptBridge.callHandler('adtrace_setEnabled', enabled, null);
                }
            },
            isEnabled: function(callback) {
                if (WebViewJavascriptBridge) {
                    WebViewJavascriptBridge.callHandler('adtrace_isEnabled', null,
                                                        function(response) {
                                                            callback(new Boolean(response));
                                                        });
                }
            },
            appWillOpenUrl: function(url) {
                if (WebViewJavascriptBridge) {
                    WebViewJavascriptBridge.callHandler('adtrace_appWillOpenUrl', url, null);
                }
            },
            setDeviceToken: function(deviceToken) {
                if (WebViewJavascriptBridge) {
                    WebViewJavascriptBridge.callHandler('adtrace_setDeviceToken', deviceToken, null);
                }
            },
            setOfflineMode: function(isOffline) {
                if (WebViewJavascriptBridge) {
                    WebViewJavascriptBridge.callHandler('adtrace_setOfflineMode', isOffline, null);
                }
            },
            getIdfa: function(callback) {
                if (WebViewJavascriptBridge) {
                    WebViewJavascriptBridge.callHandler('adtrace_idfa', null, callback);
                }
            },
            getAdid: function(callback) {
                if (WebViewJavascriptBridge) {
                    WebViewJavascriptBridge.callHandler('adtrace_adid', null, callback);
                }
            },
            getAttribution: function(callback) {
                if (WebViewJavascriptBridge) {
                    WebViewJavascriptBridge.callHandler('adtrace_attribution', null, callback);
                }
            },
            sendFirstPackages: function() {
                if (WebViewJavascriptBridge) {
                    WebViewJavascriptBridge.callHandler('adtrace_sendFirstPackages', null, null);
                }
            },
            addSessionCallbackParameter: function(key, value) {
                if (WebViewJavascriptBridge != null) {
                    WebViewJavascriptBridge.callHandler('adtrace_addSessionCallbackParameter', {key: key, value: value}, null);
                }
            },
            addSessionPartnerParameter: function(key, value) {
                if (WebViewJavascriptBridge != null) {
                    WebViewJavascriptBridge.callHandler('adtrace_addSessionPartnerParameter', {key: key, value: value}, null);
                }
            },
            removeSessionCallbackParameter: function(key) {
                if (WebViewJavascriptBridge != null) {
                    WebViewJavascriptBridge.callHandler('adtrace_removeSessionCallbackParameter', key, null);
                }
            },
            removeSessionPartnerParameter: function(key) {
                if (WebViewJavascriptBridge != null) {
                    WebViewJavascriptBridge.callHandler('adtrace_removeSessionPartnerParameter', key, null);
                }
            },
            resetSessionCallbackParameters: function() {
                if (WebViewJavascriptBridge != null) {
                    WebViewJavascriptBridge.callHandler('adtrace_resetSessionCallbackParameters', null, null);
                }
            },
            resetSessionPartnerParameters: function() {
                if (WebViewJavascriptBridge != null) {
                    WebViewJavascriptBridge.callHandler('adtrace_resetSessionPartnerParameters', null, null);
                }
            },
            gdprForgetMe: function() {
                if (WebViewJavascriptBridge != null) {
                    WebViewJavascriptBridge.callHandler('adtrace_gdprForgetMe', null, null);
                }
            },
            disableThirdPartySharing: function() {
                if (WebViewJavascriptBridge != null) {
                    WebViewJavascriptBridge.callHandler('adtrace_disableThirdPartySharing', null, null);
                }
            },
            fbPixelEvent: function(pixelID, evtName, customData) {
                if (WebViewJavascriptBridge != null) {
                    WebViewJavascriptBridge.callHandler('adtrace_fbPixelEvent',
                                                        {
                                                            pixelID: pixelID,
                                                            evtName:evtName,
                                                            customData: customData
                                                        },
                                                        null);
                }
            },
            getSdkVersion: function(callback) {
                if (WebViewJavascriptBridge != null) {
                    WebViewJavascriptBridge.callHandler('adtrace_sdkVersion', this.getSdkPrefix(), callback);
                }
            },
            getSdkPrefix: function() {
                if (this.sdkPrefix) {
                    return this.sdkPrefix;
                } else {
                    return 'web-bridge1.1.0';
                }
            },
            setTestOptions: function(testOptions) {
                if (WebViewJavascriptBridge != null) {
                    WebViewJavascriptBridge.callHandler('adtrace_setTestOptions', testOptions, null);
                }
            }
        };

        // Copied from adtrace_event.js
        window.AdtraceEvent = function(eventToken) {
            this.eventToken = eventToken;
            this.revenue = null;
            this.currency = null;
            this.transactionId = null;
            this.callbackId = null;
            this.callbackParameters = [];
            this.partnerParameters = [];
        };

        AdtraceEvent.prototype.addCallbackParameter = function(key, value) {
            this.callbackParameters.push(key);
            this.callbackParameters.push(value);
        };
        AdtraceEvent.prototype.addPartnerParameter = function(key, value) {
            this.partnerParameters.push(key);
            this.partnerParameters.push(value);
        };
        AdtraceEvent.prototype.setRevenue = function(revenue, currency) {
            this.revenue = revenue;
            this.currency = currency;
        };
        AdtraceEvent.prototype.setTransactionId = function(transactionId) {
            this.transactionId = transactionId;
        };
        AdtraceEvent.prototype.setCallbackId = function(callbackId) {
            this.callbackId = callbackId;
        };

        // Copied from adtrace_config.js
        window.AdtraceConfig = function(appToken, environment, legacy) {
            if (arguments.length === 2) {
                // New format does not require bridge as first parameter.
                this.appToken = appToken;
                this.environment = environment;
            } else if (arguments.length === 3) {
                // New format with allowSuppressLogLevel.
                if (typeof(legacy) == typeof(true)) {
                    this.appToken = appToken;
                    this.environment = environment;
                    this.allowSuppressLogLevel = legacy;
                } else {
                    // Old format with first argument being the bridge instance.
                    this.bridge = appToken;
                    this.appToken = environment;
                    this.environment = legacy;
                }
            }

            this.sdkPrefix = null;
            this.defaultTracker = null;
            this.externalDeviceId = null;
            this.logLevel = null;
            this.eventBufferingEnabled = null;
            this.sendInBackground = null;
            this.delayStart = null;
            this.userAgent = null;
            this.isDeviceKnown = null;
            this.allowiAdInfoReading = null;
            this.allowIdfaReading = null;
            this.secretId = null;
            this.info1 = null;
            this.info2 = null;
            this.info3 = null;
            this.info4 = null;
            this.openDeferredDeeplink = null;
            this.fbPixelDefaultEventToken = null;
            this.fbPixelMapping = [];
            this.attributionCallback = null;
            this.eventSuccessCallback = null;
            this.eventFailureCallback = null;
            this.sessionSuccessCallback = null;
            this.sessionFailureCallback = null;
            this.deferredDeeplinkCallback = null;
            this.urlStrategy = null;
        };

        AdtraceConfig.EnvironmentSandbox = 'sandbox';
        AdtraceConfig.EnvironmentProduction = 'production';

        AdtraceConfig.LogLevelVerbose = 'VERBOSE';
        AdtraceConfig.LogLevelDebug = 'DEBUG';
        AdtraceConfig.LogLevelInfo = 'INFO';
        AdtraceConfig.LogLevelWarn = 'WARN';
        AdtraceConfig.LogLevelError = 'ERROR';
        AdtraceConfig.LogLevelAssert = 'ASSERT';
        AdtraceConfig.LogLevelSuppress = 'SUPPRESS';

        AdtraceConfig.UrlStrategyIndia = 'UrlStrategyIndia';
        AdtraceConfig.UrlStrategyChina = 'UrlStrategyChina';

        AdtraceConfig.prototype.registerCallbackHandlers = function() {
            var registerCallbackHandler = function(callbackName) {
                var callback = this[callbackName];
                if (!callback) {
                    return;
                }
                var regiteredCallbackName = 'adtraceJS_' + callbackName;
                WebViewJavascriptBridge.registerHandler(regiteredCallbackName, callback);
                this[callbackName] = regiteredCallbackName;
            };
            registerCallbackHandler.call(this, 'attributionCallback');
            registerCallbackHandler.call(this, 'eventSuccessCallback');
            registerCallbackHandler.call(this, 'eventFailureCallback');
            registerCallbackHandler.call(this, 'sessionSuccessCallback');
            registerCallbackHandler.call(this, 'sessionFailureCallback');
            registerCallbackHandler.call(this, 'deferredDeeplinkCallback');
        };
        AdtraceConfig.prototype.getSdkPrefix = function() {
            return this.sdkPrefix;
        };
        AdtraceConfig.prototype.setSdkPrefix = function(sdkPrefix) {
            this.sdkPrefix = sdkPrefix;
        };
        AdtraceConfig.prototype.setDefaultTracker = function(defaultTracker) {
            this.defaultTracker = defaultTracker;
        };
        AdtraceConfig.prototype.setExternalDeviceId = function(externalDeviceId) {
            this.externalDeviceId = externalDeviceId;
        };
        AdtraceConfig.prototype.setLogLevel = function(logLevel) {
            this.logLevel = logLevel;
        };
        AdtraceConfig.prototype.setEventBufferingEnabled = function(isEnabled) {
            this.eventBufferingEnabled = isEnabled;
        };
        AdtraceConfig.prototype.setSendInBackground = function(isEnabled) {
            this.sendInBackground = isEnabled;
        };
        AdtraceConfig.prototype.setDelayStart = function(delayStartInSeconds) {
            this.delayStart = delayStartInSeconds;
        };
        AdtraceConfig.prototype.setUserAgent = function(userAgent) {
            this.userAgent = userAgent;
        };
        AdtraceConfig.prototype.setIsDeviceKnown = function(isDeviceKnown) {
            this.isDeviceKnown = isDeviceKnown;
        };
        AdtraceConfig.prototype.setAllowiAdInfoReading = function(allowiAdInfoReading) {
            this.allowiAdInfoReading = allowiAdInfoReading;
        };
        AdtraceConfig.prototype.setAllowIdfaReading = function(allowIdfaReading) {
            this.allowIdfaReading = allowIdfaReading;
        };
        AdtraceConfig.prototype.setAppSecret = function(secretId, info1, info2, info3, info4) {
            this.secretId = secretId;
            this.info1 = info1;
            this.info2 = info2;
            this.info3 = info3;
            this.info4 = info4;
        };
        AdtraceConfig.prototype.setOpenDeferredDeeplink = function(shouldOpen) {
            this.openDeferredDeeplink = shouldOpen;
        };
        AdtraceConfig.prototype.setAttributionCallback = function(callback) {
            this.attributionCallback = callback;
        };
        AdtraceConfig.prototype.setEventSuccessCallback = function(callback) {
            this.eventSuccessCallback = callback;
        };
        AdtraceConfig.prototype.setEventFailureCallback = function(callback) {
            this.eventFailureCallback = callback;
        };
        AdtraceConfig.prototype.setSessionSuccessCallback = function(callback) {
            this.sessionSuccessCallback = callback;
        };
        AdtraceConfig.prototype.setSessionFailureCallback = function(callback) {
            this.sessionFailureCallback = callback;
        };
        AdtraceConfig.prototype.setDeferredDeeplinkCallback = function(callback) {
            this.deferredDeeplinkCallback = callback;
        };
        AdtraceConfig.prototype.setFbPixelDefaultEventToken = function(fbPixelDefaultEventToken) {
            this.fbPixelDefaultEventToken = fbPixelDefaultEventToken;
        };
        AdtraceConfig.prototype.addFbPixelMapping = function(fbEventNameKey, adjEventTokenValue) {
            this.fbPixelMapping.push(fbEventNameKey);
            this.fbPixelMapping.push(adjEventTokenValue);
        };
        AdtraceConfig.prototype.setUrlStrategy = function(urlStrategy) {
            this.urlStrategy = urlStrategy;
        };

    })();); // END preprocessorJSCode
    //, augmentedSection];
#undef __adj_js_func__
    return preprocessorJSCode;
}

@end
