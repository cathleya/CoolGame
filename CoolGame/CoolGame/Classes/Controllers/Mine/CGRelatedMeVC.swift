//
//  CGRelatedMeVC.swift
//  CoolGame
//
//  Created by herry on 04/01/2017.
//  Copyright © 2017 herry. All rights reserved.
//

import UIKit

class CGRelatedMeVC: CGBaseController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "与我有关"
        
        
        let view1 = UIView(frame: CGRect(x: 20, y: 100, width: 200, height: 150))
        view1.backgroundColor = UIColor.purple
        view.addSubview(view1)
        
        
        let xMin = 30
        let yMin = 50
        
        let xMax = 160
        let yMax = 140
        
        let arrowPointX = 100
        let arrowPointY = yMin - 10
        
        let kArrowCurvature = 5
        
        let arrowPoint = CGPoint(x: arrowPointX, y: arrowPointY)

        
        let bezier = UIBezierPath()
        
        bezier.move(to: CGPoint(x: xMin, y: yMin+10)) //左上角
        bezier.addCurve(to: CGPoint(x: xMin+10, y: yMin), controlPoint1: CGPoint(x: xMin, y: yMin), controlPoint2: CGPoint(x: xMin, y: yMin))
        
        /********************向上的箭头**********************/
        bezier.addLine(to: CGPoint(x: arrowPointX - 10, y: yMin))
        bezier.addCurve(to: arrowPoint,
                        controlPoint1: CGPoint(x: arrowPointX - 10 + kArrowCurvature, y: yMin),
                        controlPoint2: arrowPoint)
        
        bezier.addCurve(to: CGPoint(x:arrowPointX + 10,y: yMin),
                        controlPoint1: arrowPoint,
                        controlPoint2: CGPoint(x: arrowPointX + 10 - kArrowCurvature,y: yMin))
        
        /********************向上的箭头**********************/
        
        bezier.addLine(to: CGPoint(x:  xMax-10, y: yMin))   //右上角
        bezier.addCurve(to: CGPoint(x: xMax,y: yMin+10),
                        controlPoint1: CGPoint(x: xMax,y:yMin),
                        controlPoint2: CGPoint(x: xMax,y:yMin))
        
        
        bezier.addLine(to: CGPoint(x: xMax,y:yMax-10))   //右下角
        bezier.addCurve(to: CGPoint(x: xMax-10,y:yMax),
                        controlPoint1: CGPoint(x: xMax,y:yMax),
                        controlPoint2: CGPoint(x: xMax,y:yMax))

        bezier.addLine(to: CGPoint(x: xMin+10,y:yMax))  //左下角
        bezier.addCurve(to: CGPoint(x: xMin,y:yMax-10),
                        controlPoint1: CGPoint(x: xMin,y:yMax),
                        controlPoint2: CGPoint(x: xMin,y:yMax))
        
        bezier.addLine(to: CGPoint(x: xMin,y: yMin+10))

        //填充颜色
        let layer = CAShapeLayer()
        layer.path = bezier.cgPath
        layer.strokeColor = UIColor.green.cgColor
        layer.fillColor = UIColor.red.cgColor
        
        view1.layer.addSublayer(layer)
        
        

        // Do any additional setup after loading the view.
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
