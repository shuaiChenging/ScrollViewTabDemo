//
//  ContentScrollView.m
//  ScrollViewTableDemo
//
//  Created by 徐志成 on 2022/9/2.
//

#import "ContentScrollView.h"
#import "Masonry.h"
@interface ContentScrollView ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, assign) BOOL canMove;
@end
@implementation ContentScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.showsVerticalScrollIndicator = self.showsHorizontalScrollIndicator = self.canMove = NO;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(contentcanMove) name:@"ContentCanMove" object:nil];
        self.pagingEnabled = YES;
        [self addChildView];
    }
    return self;
}

- (void)contentcanMove
{
    self.canMove = YES;
}

- (void)addChildView
{
    self.contentSize = CGSizeMake(4 * [UIScreen mainScreen].bounds.size.width, 0);
    
    
    for (int i = 0; i < 4; i++)
    {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(i * [UIScreen mainScreen].bounds.size.width, 0,self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.showsVerticalScrollIndicator = tableView.showsHorizontalScrollIndicator = NO;
        [self addSubview:tableView];
    }
}

#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellid = @"myCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    NSString *str = [NSString stringWithFormat:@"%lu", indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"我是第%@个", str];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (!self.canMove)
    {
        [scrollView setContentOffset:CGPointZero];
        for (UITableView *table in self.subviews)
        {
            [table setContentOffset:CGPointZero];
        }
    }
    
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY <= 0)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"MainCanMove" object:nil];
        self.canMove = NO;
    }
}
@end
