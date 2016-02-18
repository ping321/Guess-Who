//
//  H_NavigationController.m
//  Guess-Who
//
//  Created by 冯颐平 on 16/2/18.
//  Copyright © 2016年 冯颐平. All rights reserved.
//

#import "H_NavigationController.h"
#import "H_ViewController.h"
@interface H_NavigationController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>

@end

@implementation H_NavigationController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationBar setBackgroundColor:[UIColor redColor]];
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:20]}];
    [self.navigationBar setTintColor:[UIColor whiteColor]];
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} forState:UIControlStateNormal];
    
    self.interactivePopGestureRecognizer.enabled = true;
    self.interactivePopGestureRecognizer.delegate = self;
    self.delegate = self;
    // Do any additional setup after loading the view.
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    
    if (self.childViewControllers.count == 1)//关闭主界面的右滑返回
    {
        return NO;
    }
    else
    {
        return YES;
    }
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //    NSLog(@"%@",viewController.tabBarController);
    if ([self.childViewControllers count]==0) {
        [super pushViewController:viewController animated:animated];
        return;
    }
    // [self.screenShotsList addObject:[self capture]];
    //  NSLog(@"add%@,%@",self.screenShotsList[0],self);
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
        self.interactivePopGestureRecognizer.enabled = NO;
    [super pushViewController:viewController animated:animated];
    
}

- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated
{
    if ([navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    H_ViewController *viewCon = (H_ViewController *)viewController;
    if (viewCon.navAlpha0) {
        [viewCon.navigationController setNavigationBarHidden:true animated:animated];
        //        viewCon.navigationController.navigationBar.alpha = 0;
        //        viewCon.navigationController.navigationBar.translucent = YES;
        //        viewCon.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.000 green:0.000 blue:0.000 alpha:1.000];
        
    }else{
        [viewCon.navigationController setNavigationBarHidden:false animated:animated];
        //        viewCon.navigationController.navigationBar.alpha = 1;
        //        viewCon.navigationController.navigationBar.translucent = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushInRoot:(UIViewController *)controller
{
    NSMutableArray *arrPro = [[NSMutableArray alloc]initWithArray:self.childViewControllers];
    [arrPro removeObjectsInRange:NSMakeRange(1, arrPro.count-1)];
    [arrPro addObject:controller];
    UIViewController *viewCon = arrPro[0];
    viewCon.hidesBottomBarWhenPushed = YES;
    [self setViewControllers:arrPro animated:YES];
    viewCon.hidesBottomBarWhenPushed = NO;
}

- (void)pushInRootCons:(NSArray *)arrControllers
{
    NSMutableArray *arrPro = [[NSMutableArray alloc]initWithArray:self.childViewControllers];
    [arrPro removeObjectsInRange:NSMakeRange(1, arrPro.count-1)];
    [arrPro addObjectsFromArray:arrControllers];
    UIViewController *viewCon = arrPro[0];
    viewCon.hidesBottomBarWhenPushed = YES;
    [arrControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (idx<[arrControllers count]-1) {
            UIViewController *viewCon = obj;
            viewCon.hidesBottomBarWhenPushed = YES;
        }
        
    }];
    
    [self setViewControllers:arrPro animated:YES];
    viewCon.hidesBottomBarWhenPushed = NO;
}

- (BOOL)shouldAutorotate
{
    return [self.topViewController shouldAutorotate];
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return [self.topViewController preferredInterfaceOrientationForPresentation];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [self.topViewController supportedInterfaceOrientations];
}

@end
