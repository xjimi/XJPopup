//
//  UIView+XJPopupBaseView.m
//  Pods
//
//  Created by XJIMI on 2016/1/22.
//
//

#import "UIView+XJPopupBaseView.h"
#import <objc/runtime.h>

static char XJPopupQueueObjectKey;

#pragma mark - UIView (XJPopupBaseView)

@implementation UIView (XJPopupBaseView)

@dynamic popupQueue;

- (NSMutableArray *)popupQueue
{
    NSMutableArray *popupQueues = objc_getAssociatedObject(self, &XJPopupQueueObjectKey);
    if (!popupQueues) {
        popupQueues = [NSMutableArray array];
        objc_setAssociatedObject(self, &XJPopupQueueObjectKey, popupQueues, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return popupQueues;
}

@end
