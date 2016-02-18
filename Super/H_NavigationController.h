//
//  H_NavigationController.h
//  Guess-Who
//
//  Created by 冯颐平 on 16/2/18.
//  Copyright © 2016年 冯颐平. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface H_NavigationController : UINavigationController
@property(nonatomic,assign)NSInteger navStatu; //0: default Color navBg,white text ; 1: white color navBg,black text like login;

- (void)pushInRoot:(UIViewController *)controller;

- (void)pushInRootCons:(NSArray *)arrControllers;
@end
