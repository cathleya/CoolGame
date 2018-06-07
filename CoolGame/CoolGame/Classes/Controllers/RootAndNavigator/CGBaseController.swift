//
//  CGBaseController.swift
//  CoolGame
//
//  Created by herry on 04/01/2017.
//  Copyright © 2017 herry. All rights reserved.
//

import UIKit

class CGBaseController: UIViewController {
    
    private let active = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        view.backgroundColor = RGB(0xFFFCEE)
        
        if self.navigationController != nil  {
            if (self.navigationController?.viewControllers.count)! > 1 {
                let img = UIImage(named: "left_back.png")
                let leftBar = UIBarButtonItem(image: img, style: .plain, target: self, action: #selector(self.backAction))
                leftBar.tintColor = UIColor.white
                self.navigationItem.leftBarButtonItem = leftBar
            }
        }
        

    }
    
    func backAction() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - 显示加载中
    func isLoading(_ loading:Bool) {
        if loading {
            active.frame = CGRect(x: (SCREEN_WIDTH-80)/2, y: (SCREEN_HEIGHT-208)/2, width: 80, height: 80)
            active.backgroundColor = UIColor(white: 0, alpha: 0.8)
            active.layer.cornerRadius = 10
            view.addSubview(active)
            active.startAnimating()
        }else{
            active.stopAnimating()
            active.removeFromSuperview()
        }
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
