//
//  CGMateCell.swift
//  CoolGame
//
//  Created by herry on 31/01/2017.
//  Copyright © 2017 herry. All rights reserved.
//

import UIKit

class CGMateCell: UITableViewCell {
    
    var headImage:UIImageView!
    var usrName:UILabel!
    
    var cellData:[String:Any]{
        get{
            return self.cellData
        }
        set{
            usrName.text = newValue["alias"] as! String?
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
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
