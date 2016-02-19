//
//  sizeOfScreen.swift
//  Guess-Who
//
//  Created by 冯颐平 on 16/2/19.
//  Copyright © 2016年 冯颐平. All rights reserved.
//

import Foundation
extension Float {
    static func Ui_screen_width() -> CGFloat {
        return UIScreen.mainScreen().bounds.size.width
    }
    static func Ui_screen_height() -> CGFloat {
        return UIScreen.mainScreen().bounds.size.height
    }
}

extension UIView{
    func removeAllSubViews(){
        for view in self.subviews {
            view.removeFromSuperview()
        }
    }
    
}


extension UIViewController{
    func  paController(className:String) -> AnyObject?{
        if self.isKindOfClass(NSClassFromString(className)!){
            return self
        }else if(self.parentViewController != nil){
            return self.parentViewController!.paController(className)
        }else{
            return nil
        }
    }
}
    