//
//  MainScrollView.m
//  ScrollViewTableDemo
//
//  Created by 徐志成 on 2022/9/2.
//

#import "MainScrollView.h"
#import "ContentScrollView.h"
@implementation MainScrollView

/// 支持多手势
/// @param gestureRecognizer gestureRecognizer description
/// @param otherGestureRecognizer otherGestureRecognizer description
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

@end
