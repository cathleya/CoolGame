//
//  CGChatSenCell.swift
//  CoolGame
//
//  Created by herry on 09/01/2017.
//  Copyright © 2017 herry. All rights reserved.
//

import UIKit

class CGChatSenCell: UITableViewCell {
    
    var portrait:UIImageView!
    var msgBody:UILabel!
    let bezier = UIBezierPath()
    let bglayer = CAShapeLayer()
    
    var messageInfo:[String:Any]?{
        get{
            return self.messageInfo
        }
        set{
            
            let msg:String = newValue!["content"] as! String
            var mWidth = msg.widthWithConstrainedHight(15, UIFont.systemFont(ofSize: 12))+10
            var  mHeight:CGFloat
            
            if mWidth < SCREEN_WIDTH-105 {
                mHeight = 20.0
            }else{
                mWidth = SCREEN_WIDTH-100
                mHeight = msg.heightWithConstrainedWidth(mWidth,UIFont.systemFont(ofSize: 12))
            }
            
            msgBody.text = msg
            msgBody.frame = CGRect(x: SCREEN_WIDTH - mWidth - 50 + 5 , y: 10, width: mWidth, height: mHeight)
            bglayer.removeFromSuperlayer()
            layer.addSublayer(self.contour(SCREEN_WIDTH - mWidth - 50, 5, mWidth+5, mHeight+12))
            self.bringSubview(toFront: msgBody)
            
            
        }
    }
    

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor.clear
        
        portrait = UIImageView(frame: CGRect(x: SCREEN_WIDTH - 35, y: 5, width: 30, height: 30))
        portrait.backgroundColor = UIColor.magenta
        portrait.image = UIImage(named: "sender.png")
        addSubview(portrait)
        
        
        msgBody = UILabel(frame: CGRect(x: 55, y: 7, width: SCREEN_WIDTH-105, height: 25))
        msgBody.font = UIFont.systemFont(ofSize: 12)
        msgBody.textColor = RGB(0x212121)
        msgBody.layer.cornerRadius = 3
        msgBody.numberOfLines = 0
        addSubview(msgBody)

    }
    
    
    func contour(_ xMin:CGFloat,_ yMin:CGFloat,_ cWidth:CGFloat,_ cHight:CGFloat) -> CAShapeLayer{
        
        let xMax = xMin+cWidth
        let yMax = yMin+cHight
        
        let arrowPointX = xMax+5.0
        let arrowPointY = yMin + 10.0
        
        bezier.removeAllPoints()
        
        bezier.move(to: CGPoint(x: xMax, y: yMin+5))
        
        bezier.addCurve(to: CGPoint(x: arrowPointX, y: arrowPointY),
                        controlPoint1: CGPoint(x: arrowPointX, y: arrowPointY-2),
                        controlPoint2: CGPoint(x: arrowPointX, y:arrowPointY))
        
        bezier.addCurve(to: CGPoint(x: xMax, y: arrowPointY+5),
                        controlPoint1: CGPoint(x: xMax, y: arrowPointY+2),
                        controlPoint2: CGPoint(x: xMax, y:arrowPointY+5))
        
        bezier.addLine(to: CGPoint(x: xMax, y: yMax-5))
        bezier.addCurve(to: CGPoint(x: xMax-5, y: yMax),
                        controlPoint1: CGPoint(x: xMax, y: yMax),
                        controlPoint2: CGPoint(x: xMax, y:yMax))
        
        bezier.addLine(to: CGPoint(x: xMin+5, y: yMax))
        bezier.addCurve(to: CGPoint(x: xMin, y: yMax-5),
                        controlPoint1: CGPoint(x: xMin, y: yMax),
                        controlPoint2: CGPoint(x: xMin, y:yMax))
        
        bezier.addLine(to: CGPoint(x: xMin, y: yMin+5))
        bezier.addCurve(to: CGPoint(x: xMin+5, y: yMin),
                        controlPoint1: CGPoint(x: xMin, y: yMin),
                        controlPoint2: CGPoint(x: xMin, y:yMin))
        
        bezier.addLine(to: CGPoint(x: xMax-5, y: yMin))
        bezier.addCurve(to: CGPoint(x: xMax, y: yMin+5),
                        controlPoint1: CGPoint(x: xMax, y: yMin),
                        controlPoint2: CGPoint(x: xMax, y:yMin))
        
        bezier.close()
        
        //fill color
        bglayer.path = bezier.cgPath
        bglayer.strokeColor = CG_MSGBORDER.cgColor
        bglayer.fillColor = CG_SENMSGBGCOLOR.cgColor
        
        

        return bglayer
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
