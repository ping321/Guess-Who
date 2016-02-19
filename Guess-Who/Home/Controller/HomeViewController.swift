//
//  HomeViewController.swift
//  Guess-Who
//
//  Created by 冯颐平 on 16/2/18.
//  Copyright © 2016年 冯颐平. All rights reserved.
//

import UIKit
class HomeViewController: H_ViewController,MyButtonDelegate{
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.redColor()
        self.creatButton()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func creatButton(){
        let buttonPlay = FuctionButton(type: 0, fame: CGRectMake(0, 100,50,20), title:"play", action: "Home", index: 0)
//      buttonPlay.myButtonDelegate = self
        let vc = GameController()
        buttonPlay.actionBlock = {() in
            self.push(vc)
        }
        self.view.addSubview(buttonPlay)
    }
    func defaultJumpd() {
        let vc = GameController()
        self.push(vc, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
