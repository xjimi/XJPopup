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

+ (void)showPopupCompletion:(XJPopupDismissedBlock)completion;
- (void)showPopupCompletion:(XJPopupDismissedBlock)completion;

- (void)addBackgroundView;

- (void)show;

- (void)showAnimations;
- (void)hideAnimations;

//只用於 XJPopupWindow
- (void)addPopupWindowDismissBlock:(XJPopupWindowDismissedBlock)block;

@end
