//
//  CGTabBarController.swift
//  CoolGame
//
//  Created by herry on 04/01/2017.
//  Copyright © 2017 herry. All rights reserved.
//

import UIKit

class CGTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UINavigationBar.appearance().barTintColor = CG_NORMAL
        
        //view.backgroundColor = UIColor.white
        
        let imgArr = [["icon3_1.png","icon3_2.png"],["icon1_1.png","icon1_2.png"],["icon4_1.png","icon4_2.png"]]
        
        let titArr = ["消息","好友","我的"]
        
        let vcArr = [CGMessageVC(),CGMates(),CGMineVC()]
        
        var navAar = [UINavigationController]()
        
        
        for i in 0 ..< titArr.count{
            
            let nav = UINavigationController(rootViewController: vcArr[i])
            nav.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
            
            let img0 = UIImage(named: imgArr[i][0])
            nav.tabBarItem.image = img0!.withRenderingMode(.alwaysOriginal)
            
            let img1 = UIImage(named: imgArr[i][1])
            nav.tabBarItem.selectedImage = img1!.withRenderingMode(.alwaysOriginal)
            
            
            nav.title = titArr[i]
            navAar.append(nav)
            
        }
        
        
        
        viewControllers = navAar
        
//        //标签选中颜色
        tabBar.tintColor = CG_NORMAL
        
        
        //标签按钮背景颜色
        tabBar.barTintColor = UIColor.white
        
        //处理正常状态的字体渲染
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: CG_UNSELECT], for:.normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: CG_NORMAL], for:.selected)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
