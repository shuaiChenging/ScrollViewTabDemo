//
//  ViewController.m
//  ScrollViewTableDemo
//
//  Created by 徐志成 on 2022/9/2.
//

#import "ViewController.h"
#import "MainScrollView.h"
#import "ContentScrollView.h"
#import "Masonry.h"
#define MAXOFFSETY 80  // 最大偏移量
#define StatusH [UIApplication sharedApplication].statusBarFrame.size.height
#define NavigationBarH self.navigationController.navigationBar.frame.size.height

@interface ViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) MainScrollView *mainScroollView;
@property (nonatomic, assign) BOOL canMove;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.canMove = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mainCanMove) name:@"MainCanMove" object:nil];
    [self customerUI];
}

- (MainScrollView *)mainScroollView
{
    if (!_mainScroollView)
    {
        _mainScroollView = [[MainScrollView alloc] initWithFrame:CGRectMake(0, StatusH + NavigationBarH, [UIScreen mainScreen].bounds.size.width, self.view.frame.size.height-StatusH-NavigationBarH)];
        _mainScroollView.delegate = self;
        _mainScroollView.backgroundColor = [UIColor yellowColor];
        _mainScroollView.contentSize = CGSizeMake(0, [UIScreen mainScreen].bounds.size.height + 200);
        if (@available(iOS 11.0, *))
        {
            _mainScroollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _mainScroollView;
}

- (void)mainCanMove
{
    self.canMove = YES;
}

- (void)customerUI
{
    [self.view addSubview:self.mainScroollView];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
    topView.backgroundColor = [UIColor redColor];
    [_mainScroollView addSubview:topView];
    
    ContentScrollView *contentScrollView = [[ContentScrollView alloc] initWithFrame:CGRectMake(0, 200,[UIScreen mainScreen].bounds.size.width, _mainScroollView.frame.size.height - (200 - MAXOFFSETY))];
    contentScrollView.contentSize = CGSizeMake(4 * [UIScreen mainScreen].bounds.size.width, 0);
    [_mainScroollView addSubview:contentScrollView];
    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    CGFloat maxOffsetY = MAXOFFSETY;
    if (contentOffsetY >= maxOffsetY)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ContentCanMove" object:nil]; // 告诉底部内容视图能进行滑动了
        self.canMove = NO;   // 自己不能滑动了
    }
    if (!self.canMove)
    {
        [scrollView setContentOffset:CGPointMake(0, maxOffsetY)];
    }
}


@end
