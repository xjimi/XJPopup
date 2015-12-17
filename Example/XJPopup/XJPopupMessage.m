//
//  XJPopupMessage.m
//  XJPopup
//
//  Created by XJIMI on 2015/12/16.
//  Copyright © 2015年 XJIMI. All rights reserved.
//

#import "XJPopupMessage.h"
#import "XJPopupWindow.h"

@interface XJPopupMessage ()

@property (nonatomic, strong) UIView *messageView;
@property (nonatomic, strong) NSString *messageTitle;
@property (nonatomic, strong) NSString *messageSubtitle;


@end

@implementation XJPopupMessage

+ (void)showMessageWithTitle:(NSString *)title
                    subtitle:(NSString *)subtitle
                  completion:(void(^)(void))completion
{
    XJPopupMessage *popupMessage = [XJPopupMessage new];
    popupMessage.messageTitle = title;
    popupMessage.messageSubtitle = subtitle;
    [popupMessage addBlurBackgroundView];
    [popupMessage showPopupWithCompletion:completion];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.messageView];
}

- (UIView *)messageView
{
    if (!_messageView)
    {
        UIView *messageView = [[UIView alloc] init];
        messageView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5];
        
        CGFloat padding = 20.0f;
        CGFloat ladbelSpace = 10.0f;
        CGFloat labelW = PortraitW - padding * 2;
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding, padding, labelW, 0.0f)];
        titleLabel.font = [UIFont systemFontOfSize:16.0f];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        titleLabel.numberOfLines = 0;
        titleLabel.text = self.messageTitle;
        [messageView addSubview:titleLabel];
        [titleLabel sizeToFit];
        CGRect titleLabelFrame = titleLabel.frame;
        titleLabelFrame.size.width = labelW;
        titleLabel.frame = titleLabelFrame;
        
        UILabel *subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding, CGRectGetMaxY(titleLabelFrame) + ladbelSpace, labelW, 0.0f)];
        subtitleLabel.font = [UIFont systemFontOfSize:13.0f];
        subtitleLabel.textAlignment = NSTextAlignmentCenter;
        subtitleLabel.textColor = [UIColor whiteColor];
        subtitleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        subtitleLabel.numberOfLines = 0;
        subtitleLabel.text = self.messageSubtitle;
        [messageView addSubview:subtitleLabel];
        [subtitleLabel sizeToFit];
        CGRect subtitleLabelFrame = subtitleLabel.frame;
        subtitleLabelFrame.size.width = labelW;
        subtitleLabel.frame = subtitleLabelFrame;

        CGFloat messageH = subtitleLabel.frame.origin.y + subtitleLabel.frame.size.height + padding;
        messageView.frame = CGRectMake(0, -messageH, PortraitW, messageH);
        
        _messageView = messageView;
    }
    return _messageView;
}

- (void)show
{
    self.messageView.alpha = 1.0f;
    CGRect messageViewFrame = self.messageView.frame;
    messageViewFrame.origin.y = 0;
    [self showAnimateWithDuration:.4 options:(7 << 16) animations:^{
        
        self.messageView.frame = messageViewFrame;
        
    } completion:^{
        
    }];
}

- (void)hide
{
    CGRect messageViewFrame = self.messageView.frame;
    messageViewFrame.origin.y = -messageViewFrame.size.height;
    [self hideAnimateWithDuration:.4 options:(7 << 16) animations:^{
        
        self.messageView.frame = messageViewFrame;
        
    } completion:^{
        
        
    }];
}

@end
