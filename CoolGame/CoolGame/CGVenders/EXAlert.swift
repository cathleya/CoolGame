//
//  EXAlert.swift
//  OrientalGroup
//
//  Created by herry on 26/12/2016.
//  Copyright © 2016 herry. All rights reserved.
//

import UIKit

enum EXAlertStyle{
    /// 位于屏幕底部
    case TOP
    /// 位于屏幕中间
    case CENTER
    /// 位于屏幕底部
    case BOTTOM
}

class EXAlert: NSObject {

    // MARK: - 显示一条通知
    class func alert(_ msg:String,_ style:EXAlertStyle){
        let msgSize:CGSize = msg.boundingRect(with: CGSize(width: 300, height: 15),
                                                  options:NSStringDrawingOptions.usesLineFragmentOrigin  ,
                                                  attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 10)],
                                                  context:nil).size
        
        var showLab:UILabel
        switch style {
        case .TOP:
           showLab = UILabel(frame: CGRect(x: (SCREEN_WIDTH-(msgSize.width+30))/2, y: 0, width: msgSize.width+30, height: msgSize.height+15))
        case .CENTER:
            showLab = UILabel(frame: CGRect(x: (SCREEN_WIDTH-(msgSize.width+30))/2, y: (SCREEN_HEIGHT-20)/2, width: msgSize.width+30, height: msgSize.height+15))
        case .BOTTOM:
            showLab = UILabel(frame: CGRect(x: (SCREEN_WIDTH-(msgSize.width+30))/2, y: SCREEN_HEIGHT-100, width: msgSize.width+30, height: msgSize.height+15))
        }
        showLab.backgroundColor = UIColor(white: 0, alpha: 0.9)
        showLab.textAlignment = NSTextAlignment.center
        showLab.textColor = UIColor.white
        showLab.font = UIFont.systemFont(ofSize: 12)
        showLab.text = msg
        showLab.layer.cornerRadius = 5
        showLab.clipsToBounds = true
        
        UIApplication.shared.keyWindow?.addSubview(showLab)
        
        UIView.animate(withDuration: 2, animations: {
            showLab.alpha = 0
        }, completion: {finished in
            if finished{
                showLab.removeFromSuperview()
            }
        }
        )
    }
    
    
    
    

}
