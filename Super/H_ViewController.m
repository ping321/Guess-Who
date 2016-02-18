//
//  H_ViewController.m
//  Guess-Who
//
//  Created by 冯颐平 on 16/2/18.
//  Copyright © 2016年 冯颐平. All rights reserved.
//

#import "H_ViewController.h"

@interface H_ViewController ()

@end

@implementation H_ViewController
{
    
    BOOL showedInDidAppear;
    
}

+ (id)instance
{
    Class class = [self class];
    id selfObj = [[class alloc]init];
    return selfObj;
    
}

- (id)initWithNetType:(BOOL)showNetProgress
{
    self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil];
    if (self) {
        self.showNetProgress = showNetProgress;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //    UIView *viewBg = [[UIView alloc]initWithFrame:CGRectMake(0, -64, 320.0, 64)];
    //    viewBg.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    //    viewBg.backgroundColor = [UIColor redColor];
    //    viewBg.tag = 30;
    //    [self.view addSubview:viewBg];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.isBlackStatusBar) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    }else{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }
    if (!_titleMob.length) {
        _titleMob = self.navigationItem.title?:self.title;
    }
    if (!self.showedInWillAppear) {
        self.showedInWillAppear = YES;
        
        if (!self.isNoBackNav) {
            [self addBarBack];
        }
        
        [self doOnceInAppearFrame];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (self.showNetProgress) {
        [self doAddNetProgress];
        [self loadNet];
        
    }
    if (!showedInDidAppear) {
        showedInDidAppear = YES;
        if (!self.showNetProgress) {
            [self doOnceInAppearView];
        }
    }
    
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.hidesBottomBarWhenPushed = YES;
}

//- (UIStatusBarStyle)preferredStatusBarStyle
//{
//    return UIStatusBarStyleLightContent;
//}

- (void)addBarBack{
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
    barButton.width = -5;
    UIButton *but = [[UIButton alloc]initWithFrame:CGRectMake(0, 3, 60,40)];
    [but setTitle:@"\U0000e624" forState:UIControlStateNormal];
    but.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    UIColor *textColor;
    if (self.isBlackBackNav) {
        textColor = [UIColor blackColor];
    }else{
        textColor = [UIColor whiteColor];
    }
    [but setTitleColor:textColor forState:UIControlStateNormal];
    //    but.titleLabel.textColor = self.isBlackBackNav?[UIColor blackColor]: [UIColor whiteColor];
    but.titleLabel.font = [UIFont fontWithName:@"iconfont" size:21];
    [but addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *icon = [[UIBarButtonItem alloc]initWithCustomView:but];
    self.navigationItem.leftBarButtonItems = @[barButton,icon];
}

#pragma mark - for nav UI

- (void)rightButton:(NSString*)title
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(rightClick)];
    
    //    UIButton *rightButton =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
    //    rightButton.titleLabel.textColor = [UIColor whiteColor];
    //    rightButton.titleLabel.font = [UIFont systemFontOfSize:18];
    //    [rightButton setTitle:title forState:UIControlStateNormal];
    //    [rightButton addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    //    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
}
- (void)rightButtonWithTitle:(NSString*)title andImage:(UIImage*)image
{
    // self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(dismissSelf)];
    
    UIButton *rightButton =[[UIButton alloc]initWithFrame:CGRectMake(0, 5, 70, 30)];
    rightButton.titleLabel.textColor = [UIColor whiteColor];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [rightButton setTitle:title forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [rightButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    [rightButton setImage:image forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 40)];
    rightView.userInteractionEnabled = YES;
    [rightView addSubview:rightButton];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightView];
}


- (void)rightButtonImageStr:(NSString *)imgStr
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:imgStr] style:UIBarButtonItemStylePlain target:self action:@selector(rightClick)];
}
- (void)rightButtonIcon:(NSString *)iconString
{
    UIButton *rightButton =[[UIButton alloc]initWithFrame:CGRectMake(0, 5, 30, 30)];
    rightButton.titleLabel.textColor = [UIColor whiteColor];
    rightButton.titleLabel.font = [UIFont fontWithName:@"iconfont" size:23];
    [rightButton setTitle:iconString forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor colorWithWhite:1 alpha:0.5] forState:UIControlStateHighlighted];
    [rightButton addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
}
- (void)leftButtonIcon:(NSString *)iconString
{
    UIButton *leftButton =[[UIButton alloc]initWithFrame:CGRectMake(0, 5, 60, 30)];
    leftButton.titleLabel.textColor = [UIColor whiteColor];
    leftButton.titleLabel.font = [UIFont systemFontOfSize:18];
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:iconString];
    [attStr addAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"iconfont" size:20]} range:NSMakeRange(0, 1)];
    [leftButton setAttributedTitle:attStr forState:UIControlStateNormal];
    [leftButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 50)];
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor colorWithWhite:1 alpha:0.5] forState:UIControlStateHighlighted];
    [leftButton addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 40)];
    leftView.userInteractionEnabled = YES;
    [leftView addSubview:leftButton];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftView];
    
}
- (void)leftButtonWithTitle:(NSString*)title
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(leftClick)];
    
}
- (void)leftButtonWithTitle:(NSString*)title withFont:(UIFont*)font
{
    UIButton *leftButton =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 40)];
    leftButton.titleLabel.textColor = [UIColor whiteColor];
    leftButton.titleLabel.font = font;
    [leftButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    [leftButton setTitle:title forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    
}
- (void)leftButtonWithTitle:(NSString*)title andImage:(UIImage*)image
{
    UIButton *leftButton =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 40)];
    leftButton.titleLabel.textColor = [UIColor whiteColor];
    leftButton.titleLabel.font = [UIFont systemFontOfSize:18];
    // [leftButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [leftButton setTitle:title forState:UIControlStateNormal];
    [leftButton setImage:image forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
}

//- (UIBarButtonItem *)leftBarButton{
//
//
//    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 25, 60, 35)];
//    backButton.titleLabel.textColor = [UIColor whiteColor];
//    backButton.titleLabel.font = [UIFont fontWithName:@"iconfont" size:18];
//    [backButton setTitle:@"\U0000e624" forState:UIControlStateNormal];
//    [backButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 30)];
//    backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    [backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *returnButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
//    return returnButtonItem;
//}

//- (UIBarButtonItem *)fixBarItem{
//    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//    item.width = -5;
//    return item;
//}

//- (UIBarButtonItem *)leftBarItem{
//    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60,40)];
//    [backBtn setTitle:@"\U0000e624" forState:UIControlStateNormal];
//    backBtn.titleLabel.textColor = [UIColor whiteColor];
//    backBtn.titleLabel.font = [UIFont fontWithName:@"iconfont" size:21];
////    backBtn!.setTitle("\u{0000e624}", forState: UIControlState.Normal)
////    backBtn!.titleLabel!.textColor = UIColor.whiteColor()
////    backBtn!.titleLabel!.font = UIFont(name:"iconfont", size:21)
//    //        backBtn!.titleLabel.font = [UIFont fontWithName:"iconfont" size:21];
//    //        [backButton setTitle:@"\U0000e624" forState:UIControlStateNormal];
//    //        [backButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 40)];
////    backBtn!.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
//    return nil;
//}


- (void)leftClick
{
    [self.navigationController popViewControllerAnimated:true];
}

- (void)rightClick
{
    
}
- (void)doOnceInAppearFrame
{
    
}

- (void)doOnceInAppearView
{
    
}

- (void)doAddNetProgress
{
    //加载中时的图像
}

- (void)loadNet
{
    
}

- (void)failedLoadNet
{
    //加载失败,重新加载按钮
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    NSLog(@"%@ dealloc",NSStringFromClass([self class]));
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)push:(UIViewController *)viewController
{
    [self push:viewController animated:YES];
}



- (void)pushCloseSelf:(UIViewController *)viewController
{
    UIBarButtonItem *returnButtonItem = [[UIBarButtonItem alloc] init];
    
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 25, 60, 35)];
    backButton.titleLabel.textColor = [UIColor whiteColor];
    backButton.titleLabel.font = [UIFont fontWithName:@"iconfont" size:18];
    [backButton setTitle:@"\U0000e624" forState:UIControlStateNormal];
    [backButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 30)];
    backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.navigationItem.backBarButtonItem = returnButtonItem;
    H_NavigationController *nav = (H_NavigationController *)self.navigationController;
    NSMutableArray *arrPro = [[NSMutableArray alloc]initWithArray:nav.childViewControllers];
    [arrPro removeObject:self];
    [arrPro addObject:viewController];
    UIViewController *viewCon = arrPro[0];
    viewCon.hidesBottomBarWhenPushed = YES;
    [arrPro enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (idx<[arrPro count]-1) {
            UIViewController *viewCon = obj;
            viewCon.hidesBottomBarWhenPushed = YES;
        }
        
    }];
    
    [nav setViewControllers:arrPro animated:YES];
    viewCon.hidesBottomBarWhenPushed = NO;
}
- (void)pushReloadSelf:(UIViewController *)viewController andSelf:(UIViewController*)viewcontroller2
{
    //    UIBarButtonItem *returnButtonItem = [[UIBarButtonItem alloc] init];
    //    returnButtonItem.title = @"";
    //    self.navigationItem.backBarButtonItem = returnButtonItem;
    H_NavigationController *nav = (H_NavigationController *)self.navigationController;
    NSMutableArray *arrPro = [[NSMutableArray alloc]initWithArray:nav.childViewControllers];
    [arrPro removeObject:self];
    if (viewcontroller2 != nil)[arrPro addObject:viewcontroller2];
    [arrPro addObject:viewController];
    UIViewController *viewCon = arrPro[0];
    viewCon.hidesBottomBarWhenPushed = YES;
    [arrPro enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (idx<[arrPro count]-1) {
            UIViewController *viewCon = obj;
            viewCon.hidesBottomBarWhenPushed = YES;
        }
        
    }];
    
    [nav setViewControllers:arrPro animated:NO];
    viewCon.hidesBottomBarWhenPushed = NO;
}

- (void)push:(UIViewController *)viewController animated:(BOOL)animated
{
    
    [self.navigationController pushViewController:viewController animated:animated];
}

- (H_NavigationController *)h_nav
{
    return (H_NavigationController *)self.navigationController;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
