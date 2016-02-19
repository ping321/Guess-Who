//
//  FuctionButton.swift
//  Guess-Who
//
//  Created by 冯颐平 on 16/2/19.
//  Copyright © 2016年 冯颐平. All rights reserved.
//

import UIKit
@objc protocol MyButtonDelegate{
}
class FuctionButton: UIView {
    typealias funcBlock = () -> Void
    weak var myButtonDelegate:MyButtonDelegate?
    var actionBlock = funcBlock?()
    var button:UIButton = UIButton()
    var label:UILabel = UILabel()
    convenience init(type:Int,fame:CGRect,title:String,action:String,index:Int){
        self.init(frame:fame)
        button.frame.size = self.frame.size
        button.setTitle(title, forState: UIControlState.Normal)
        if type == 0{
            button.addTarget(self, action: "defaultJump", forControlEvents: UIControlEvents.TouchDown)
        }
        self.addSubview(button)
    }
    func defaultJump(){
        //myButtonDelegate?.defaultJumpd()
        if actionBlock != nil{
            self.actionBlock!()
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
