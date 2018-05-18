//
//  ViewController.m
//  QQ个人界面
//
//  Created by linjianguo on 2018/5/18.
//  Copyright © 2018年 com.justsee. All rights reserved.
//

#import "ViewController.h"
#import "ZYFBar.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    ZYFBar *navBar;
    UIImageView *bgView;
    CGRect originalFrame;
}
@end

@implementation ViewController

static const CGFloat headHeight = 160.0f;
static const CGFloat ratio = 0.8f;
#define SCREENSIZE [UIScreen mainScreen].bounds.size
#define kRandomColor  [UIColor colorWithRed:arc4random() % 256 / 255. green:arc4random() % 256 / 255. blue:arc4random() % 256 / 255. alpha:1]

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, ratio*self.view.frame.size.width)];
    bgView.image = [UIImage imageNamed:@"111.jpg"];
    originalFrame = bgView.frame;
    [self.view addSubview:bgView];
    
    navBar = [ZYFBar new];
    navBar.title = @"峰峰爱吃饭";
    navBar.leftImage = @"Mail";
    navBar.rightImage = @"Setting";
    navBar.titleColor = [UIColor whiteColor];
    [self.view addSubview:navBar];
    
    //实现tableView
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0.f, 64.0f, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-64.f) style:UITableViewStylePlain];
    table.backgroundColor = [UIColor clearColor];
    table.showsVerticalScrollIndicator = NO;
    table.delegate = self;
    table.dataSource = self;
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.view.frame.size.width, headHeight)];
    headView.backgroundColor = [UIColor clearColor];
    table.tableHeaderView = headView;
    
    [self.view addSubview:table];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.textLabel.text = @"峰峰爱吃草莓";
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat yOffset = scrollView.contentOffset.y;
    NSLog(@"%.2f",yOffset);
    if (yOffset < headHeight) {
        CGFloat colorAlpha = yOffset/headHeight;
        navBar.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:colorAlpha];
        navBar.leftImage = @"Mail";
        navBar.rightImage =@"Setting";
        navBar.titleColor = [UIColor whiteColor];
    }else {  //超过导航栏底部了
        
        navBar.backgroundColor = [UIColor whiteColor];
        navBar.leftImage = @"Mail-click";
        navBar.rightImage = @"Setting-click";
        navBar.titleColor = kRandomColor;
        
    }
    if (yOffset > 0) {
        bgView.frame  = ({
            CGRect frame = originalFrame;
            frame.origin.y = originalFrame.origin.y - yOffset;
            frame;
        });
    } else {
        bgView.frame  =  ({
            CGRect frame = originalFrame;
            frame.size.height = originalFrame.size.height - yOffset;
            frame.size.width = frame.size.height/ratio;
            frame.origin.x = originalFrame.origin.x - (frame.size.width-originalFrame.size.width)/2;
            frame;
        });
    }
}



@end
