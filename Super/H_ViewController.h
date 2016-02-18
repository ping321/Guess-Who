//
//  H_ViewController.h
//  Guess-Who
//
//  Created by 冯颐平 on 16/2/18.
//  Copyright © 2016年 冯颐平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "H_NavigationController.h"
@interface H_ViewController : UIViewController
@property(nonatomic,assign)BOOL needShowLoading;
@property(nonatomic,assign)BOOL showNetProgress;
@property(nonatomic,assign)BOOL showedInWillAppear;
@property(nonatomic,assign)NSInteger originYTable;
@property(nonatomic,assign)BOOL navAlpha0;         //隐藏 导航栏
@property(nonatomic,assign)BOOL isBlackStatusBar;  //显示黑色 status
@property(nonatomic,assign)BOOL isNoBackNav;   //导航栏 不显示 返回
@property(nonatomic,assign)BOOL isBlackBackNav; //导航栏 返回 黑色
@property(nonatomic,strong)NSString *titleMob;

+ (id)instance;
- (id)initWithNetType:(BOOL)showNetProgress;
- (void)rightButton:(NSString*)title;
- (void)rightButtonWithTitle:(NSString*)title andImage:(UIImage*)image;
- (void)rightButtonImageStr:(NSString *)imgStr;
- (void)leftButtonWithTitle:(NSString*)title;
- (void)leftButtonWithTitle:(NSString*)title withFont:(UIFont*)font;
- (void)leftButtonWithTitle:(NSString*)title andImage:(UIImage*)image;
- (void)rightClick;
- (void)leftClick;
// iconfont
- (void)rightButtonIcon:(NSString*)iconString;
- (void)leftButtonIcon:(NSString *)iconString;
//初始化加载时调用
- (void)doOnceInAppearFrame;

- (void)doOnceInAppearView;

//网络请求
- (void)loadNet;
- (void)dealloc;

//For nav
- (void)push:(UIViewController *)viewController;
- (void)push:(UIViewController *)viewController animated:(BOOL)animated;
- (void)pushCloseSelf:(UIViewController *)viewController;
- (void)push:(UIViewController *)viewController animated:(BOOL)animated;
- (void)pushReloadSelf:(UIViewController *)viewController andSelf:(UIViewController*)viewcontroller2;
- (H_NavigationController *)h_nav;
@end
