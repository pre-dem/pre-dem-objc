#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "PREDBaseModel.h"
#import "PREDCustomEvent.h"
#import "PREDDefines.h"
#import "PREDemCocoa.h"
#import "PREDLog.h"
#import "PREDManager.h"
#import "PREDNetDiagResult.h"

FOUNDATION_EXPORT double PreDemCocoaVersionNumber;
FOUNDATION_EXPORT const unsigned char PreDemCocoaVersionString[];
