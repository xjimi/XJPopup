//
//  XJPopupBaseViewController.h
//  Pods
//
//  Created by XJIMI on 2015/12/16.
//
//

#import <UIKit/UIKit.h>

typedef void(^XJPopupDismissedBlock)(void);

//只用於 XJPopWindow
typedef void(^XJPopupWindowDismissedBlock)(void);


@interface XJPopupBaseViewController : UIViewController

//讓 XJPopupWindow 判斷用 (只用於 XJPopupWindow)
@property (nonatomic, getter=isShowing) BOOL showing;

//只用於 XJPopupWindow
- (void)showWithAnimations:(void (^)(void))animations;
- (void)hideWithAnimations:(void (^)(void))animations completion:(void(^)(void))completion;
- (void)addPopupWindowDismissBlock:(XJPopupWindowDismissedBlock)block;

+ (void)showPopupCompletion:(XJPopupDismissedBlock)completion;


@end
