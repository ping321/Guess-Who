//
//  ViewController.m
//  Guess-Who
//
//  Created by 冯颐平 on 16/2/18.
//  Copyright © 2016年 冯颐平. All rights reserved.
//

#import "ViewController.h"
#import "GuessWho-Swift.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    [self animationForTextFieldAndButton];
    // Do any additional setup after loading the view, typically from a nib.
}



- (void)animationForTextFieldAndButton{
    //start from
    
    CGPoint nameCenter = _userName.center;
    CGPoint passwordCenter = _password.center;
    nameCenter.x -= 200;
    passwordCenter.x -= 200;
    _userName.center = nameCenter;
    _password.center = passwordCenter;
    _login.alpha = 0;
    
    //final location
    
    nameCenter.x += 200;
    passwordCenter.x += 200;
    [UIView animateWithDuration:1.0 animations:^{
        _userName.center = nameCenter;
        [UIView animateWithDuration:1.0 delay:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            _password.center = passwordCenter;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:1.0 animations:^{
                _login.alpha = 1;
            }];
        }];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//云信手动登录
- (void)loginForNIMWith:(NSString *)uID andPassword:(NSString *)pwd{
    [[[NIMSDK sharedSDK]loginManager]login:uID token:pwd completion:^(NSError *error) {
        NSLog(@"云信登录");
        //[self getMembers];
        //push 新页面
    }];
    //登陆成功后执行
    HomeViewController *home = [[HomeViewController alloc]init];
    home.isNoBackNav = YES;
    home.navigationItem.hidesBackButton = YES;
    [self.navigationController pushViewController:home animated:YES];
}

//获取小组玩家信息
- (void)getMembers{
    
}


- (IBAction)btnAct:(id)sender {
    
    [self loginForNIMWith:_userName.text andPassword:_password.text];

}
@end
