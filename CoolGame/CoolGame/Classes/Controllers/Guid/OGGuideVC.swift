//
//  OGGuideVC.swift
//  CoolGame
//
//  Created by herry on 04/01/2017.
//  Copyright © 2017 herry. All rights reserved.
//

import UIKit

class OGGuideVC: CGBaseController , UIScrollViewDelegate{
    
    var PCDot:UIPageControl?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        automaticallyAdjustsScrollViewInsets = false
        view.backgroundColor = UIColor.white
        
        
        let score = UIScrollView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        score.contentSize = CGSize(width: SCREEN_WIDTH*3, height: 150)
        score.showsHorizontalScrollIndicator = false
        score.showsVerticalScrollIndicator = false
        score.isPagingEnabled = true
        score.delegate = self
        view.addSubview(score)
        
        for pos in 0...3{
            let img = UIImageView(frame: CGRect(x: (CGFloat(pos) * SCREEN_WIDTH), y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
            img.isUserInteractionEnabled = true
            img.image=UIImage(named: "guide0\(pos+1).png")
            score.addSubview(img)
            if pos == 2{
                let btn = UIButton(frame: CGRect(x: (SCREEN_WIDTH-110)/2, y: SCREEN_HEIGHT-210, width: 110, height: 30))
                btn.addTarget(self, action: #selector(self.lanchTap), for: UIControlEvents.touchUpInside)
                btn.setTitle("开启", for: UIControlState())
                btn.layer.borderColor = UIColor.white.cgColor
                btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
                btn.backgroundColor = UIColor.lightGray
                btn.layer.cornerRadius = 10
                btn.layer.borderWidth = 1
                img.addSubview(btn)
            }
            
        }
        
        PCDot = UIPageControl(frame: CGRect(x: SCREEN_WIDTH/2-50, y: SCREEN_HEIGHT-60, width: 100, height: 37))
//        PCDot?.pageIndicatorTintColor = RGBAN(206, g: 206, b: 206, a: 1)
//        PCDot?.currentPageIndicatorTintColor = UL_SYSGRAY
        PCDot?.numberOfPages = 3
        PCDot?.currentPage = 0
        view.addSubview(PCDot!)
        
        

        // Do any additional setup after loading the view.
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWith:CGFloat=scrollView.frame.width;
        let page = floor((scrollView.contentOffset.x-pageWith/2)/pageWith)+1;
        PCDot?.currentPage = Int(page)
    }
    
    func lanchTap(){
//        let nav = UINavigationController(rootViewController: ULLandVC())
//        nav.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
//        UIApplication.shared.keyWindow!.rootViewController = nav
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
