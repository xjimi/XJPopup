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

@property (nonatomic, strong) UIButton *bgView;

@property (nonatomic, copy) XJPopupDismissedBlock popupDismissedBlock;
@property (nonatomic, copy) XJPopupWindowDismissedBlock popupWindowDismissedBlock;

@end

@implementation XJPopupBaseViewController

+ (void)showPopupCompletion:(XJPopupDismissedBlock)completion
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.userInteractionEnabled = NO;
}

- (void)addBackgroundView
{
    UIButton *bgView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, PortraitW, PortraitH)];
    bgView.backgroundColor = [UIColor blackColor];
    [bgView addTarget:self action:@selector(action_dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bgView];
    self.bgView = bgView;
}

- (void)addPopupWindowDismissBlock:(XJPopupWindowDismissedBlock)block
{
    self.popupWindowDismissedBlock = block;
}

- (void)showWithAnimations:(void (^)(void))animations
{
    self.bgView.alpha = 0.0f;
    [UIView animateWithDuration:.4
                          delay:0
                        options:(7 << 16)
                     animations:^{
                         
                         self.bgView.alpha = 0.7f;
                         if (animations) animations();
                         
                     } completion:^(BOOL finished) {
                         
                         self.view.userInteractionEnabled = YES;
                         
                     }];
}


- (void)hideWithAnimations:(void (^)(void))animations completion:(void(^)(void))completion
{
    [UIView animateWithDuration:.4
                          delay:0
                        options:(7 << 16)
                     animations:^{
                         
                         self.bgView.alpha = 0.0f;
                         if (animations) animations();
                         
                     } completion:^(BOOL finished) {
                         
                         if (completion) completion();
                         
                     }];
}

- (void)action_dismiss
{
    __weak typeof(self)weakSelf = self;
    [self hideWithAnimations:^{
        
    } completion:^{
        
        if (weakSelf.popupDismissedBlock) {
            weakSelf.popupDismissedBlock();
        }
        
        if (weakSelf.popupWindowDismissedBlock) {
            weakSelf.popupWindowDismissedBlock();
        }
        
    }];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

@end
