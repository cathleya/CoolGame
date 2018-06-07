//
//  CGMessageCell.swift
//  CoolGame
//
//  Created by herry on 06/01/2017.
//  Copyright © 2017 herry. All rights reserved.
//

import UIKit

class CGMessageCell: UITableViewCell {
    
    var headImage:UIImageView!
    var usrName:UILabel!
    var usrMsg:UILabel!
    var msgTime:UILabel!
    
    var cellData:[String:Any]{
        get{
            return self.cellData
        }
        set{
            usrName.text = newValue["alias"] as! String?
//            usrMsg.text = newValue["lastmsg"] as! String?
//            msgTime.text = newValue["msgtime"] as! String?
            headImage.image = UIImage(named: "reciever.png")
            
        }
    }
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //backgroundColor = UIColor.clear
        
        headImage = UIImageView(frame: CGRect(x: 5, y: 5, width: 50, height: 50))
        headImage.backgroundColor = UIColor.magenta
        addSubview(headImage)
        
        usrName = UILabel(frame: CGRect(x: 60, y: 10, width: SCREEN_WIDTH-140, height: 15))
        usrName.font = UIFont.systemFont(ofSize: 14)
        usrName.textColor = UIColor.black
        usrName.numberOfLines = 1
        addSubview(usrName)
        
        usrMsg = UILabel(frame: CGRect(x: 60, y: 35, width: SCREEN_WIDTH-65, height: 15))
        usrMsg.font = UIFont.systemFont(ofSize: 12)
        usrMsg.textColor = UIColor.gray
        usrMsg.numberOfLines = 1
        addSubview(usrMsg)
        
        msgTime = UILabel(frame: CGRect(x: SCREEN_WIDTH-75, y: 10, width: 70, height: 15))
        msgTime.font = UIFont.systemFont(ofSize: 12)
        msgTime.textColor = UIColor.gray
        msgTime.numberOfLines = 1
        addSubview(msgTime)
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }



}
