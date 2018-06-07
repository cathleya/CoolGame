//
//  CGMyBroadcastVC.swift
//  CoolGame
//
//  Created by herry on 04/01/2017.
//  Copyright © 2017 herry. All rights reserved.
//

import UIKit
import AVFoundation

class CGMyBroadcastVC: CGBaseController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "我要直播"
        
        let container = UIView(frame: CGRect(x: 5, y: 80, width: 300, height: 200))
        container.backgroundColor = UIColor.cyan
        view.addSubview(container)
        
        let url = URL(string: "http://localhost:8081/rtmp/home.m3u8")
        let player = AVPlayer(url: url!)
        
        let layer = AVPlayerLayer(player: player)
        layer.frame = container.bounds
        container.layer.addSublayer(layer)
        
        player.play()
        
        
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
