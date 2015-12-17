//
//  XJPopupBaseViewController.m
//  Pods
//
//  Created by XJIMI on 2015/12/16.
//
//

#import "XJPopupBaseViewController.h"
#import "XJPopupWindow.h"

@interface XJPopupBaseViewController ()

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, copy) XJPopupDismissedBlock popupDismissedBlock;
@property (nonatomic, copy) XJPopupWindowDismissedBlock popupWindowDismissedBlock;

@end

@implementation XJPopupBaseViewController

+ (void)showPopupWithCompletion:(XJPopupDismissedBlock)completion
{
    //Sample 
    XJPopupBaseViewController *popupBaseVC = [XJPopupBaseViewController new];
    [popupBaseVC addBackgroundView];
    [popupBaseVC showPopupWithCompletion:completion];
}

- (void)showPopupWithCompletion:(XJPopupDismissedBlock)completion
{
    self.popupDismissedBlock = completion;
    [[XJPopupWindow sharedInstance] addPopupViewController:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.userInteractionEnabled = NO;
    self.dismissWhenTouchBackground = YES;
}

- (UIView *)bgView
{
    if (!_bgView)
    {
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, PortraitW, PortraitH)];
        bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.8];
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(action_dismiss)];
        tapGestureRecognizer.numberOfTapsRequired = 1;
        [bgView addGestureRecognizer:tapGestureRecognizer];
        _bgView = bgView;
    }
    return _bgView;
}

- (void)addBackgroundView {
    [self.view insertSubview:self.bgView atIndex:0];
}

- (void)addBlurBackgroundView
{
    [self addBackgroundView];
    
    UIWindow *screenWindow = [UIApplication sharedApplication].windows.firstObject;
    UIGraphicsBeginImageContext(screenWindow.frame.size);
    [screenWindow.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *screenImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:screenImage];
    imageView.frame = self.bgView.bounds;
    [self.bgView addSubview:imageView];
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    blurEffectView.frame = self.bgView.bounds;
    blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    blurEffectView.userInteractionEnabled = NO;
    [self.bgView addSubview:blurEffectView];
}

- (void)addPopupWindowDismissBlock:(XJPopupWindowDismissedBlock)block
{
    self.popupWindowDismissedBlock = block;
}

- (void)show
{
    [self showAnimateWithDuration:0.4f options:(7 << 16) animations:^{
    } completion:^{
    }];
}

- (void)showAnimateWithDuration:(NSTimeInterval)duration
                        options:(UIViewAnimationOptions)options
                     animations:(void (^)(void))animations
                     completion:(void (^)(void))completion
{
    self.bgView.alpha = 0.0f;
    [UIView animateWithDuration:duration delay:0 options:options animations:^{
                         
        self.bgView.alpha = 1.0f;
        if (animations) animations();
        
    } completion:^(BOOL finished) {
                         
        self.view.userInteractionEnabled = YES;
        if (completion) completion();
                         
    }];
}

- (void)hide
{
    [self hideAnimateWithDuration:0.04f options:(7 << 16) animations:^{
    } completion:^{
    }];
}

- (void)hideAnimateWithDuration:(NSTimeInterval)duration
                        options:(UIViewAnimationOptions)options
                     animations:(void (^)(void))animations
                     completion:(void (^)(void))completion
{
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:duration delay:0 options:options animations:^{
                         
        self.bgView.alpha = 0.0f;
        if (animations) animations();
                         
    } completion:^(BOOL finished) {
        
        if (completion) completion();

        if (weakSelf.popupDismissedBlock) {
            weakSelf.popupDismissedBlock();
        }

        if (weakSelf.popupWindowDismissedBlock) {
            weakSelf.popupWindowDismissedBlock();
        }

    }];
}

- (void)action_dismiss
{
    if (self.dismissWhenTouchBackground) [self hide];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

@end
