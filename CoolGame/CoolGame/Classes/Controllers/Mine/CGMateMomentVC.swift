//
//  CGMateMomentVC.swift
//  CoolGame
//
//  Created by herry on 04/01/2017.
//  Copyright © 2017 herry. All rights reserved.
//

import UIKit
import SwiftSocket

class CGMateMomentVC: CGBaseController {
    
    let client = TCPClient(address: "192.168.31.148", port: 2345)
    let field = UITextView(frame: CGRect(x: 50, y: 200, width: 200, height: 150))

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "好友动态"
        
        let arr = ["链接","发送","断开"]
        
        for i in 0 ..< arr.count {
            let btn = UIButton(frame: CGRect(x: 50+(i*80), y: 100, width: 60, height: 30))
            btn.addTarget(self, action: #selector(self.operateAction(_:)), for: .touchUpInside)
            btn.backgroundColor = UIColor.red
            btn.setTitle(arr[i], for: .normal)
            btn.tag = 1000+i
            view.addSubview(btn)
            
        }
    
        
        field.backgroundColor = UIColor.cyan
        view.addSubview(field)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.keyBoardHidden))
        tap.numberOfTouchesRequired = 1
        tap.numberOfTapsRequired = 1
        view.addGestureRecognizer(tap)
        
    }
    
    func keyBoardHidden(){
        field.endEditing(true)

    }
    
    func operateAction(_ sender:UIButton) {
        
        if sender.tag == 1000 {
            switch client.connect(timeout: 10) {
            case .success:
                DBLog("Connection successful 🎉")
                
                DispatchQueue.global(qos: .background).async {
                    while true{
                        if let msg=self.readmsg(){
                            
                            DBLog("msg==🎉\(msg)")
                            
                        }else{
                            DispatchQueue.main.async {
                                //self.disconnect()
                            }
                            break
                        }
                    }
                }

                break
            case .failure(let error):
                DBLog("// 💩\(error)")
                break
            }
        }else if sender.tag == 1001 {
            
            if !field.text!.isEmpty {
                
                //sendMsg(msg: ["cmd":field.text!])
                
                let sendData = field.text!.data(using: .utf8)
                
                //var len:Int32=Int32(sendData!.count)
                
                
                //let data = Data(bytes: &len, count: 4)
                //_ = client.send(data: data)
                _ = client.send(data: sendData!)
                
                
                field.text = ""

            }
            
        }else if sender.tag == 1002 {
            client.close()
            
            DBLog("// close 💩  ")
        }
    }
    
    //func readmsg()->[String:Any]?{
    func readmsg()->String?{
        //read 4 byte int as type
        if let data=client.read(4){
            if data.count==4{
                let ndata=NSData(bytes: data, length: data.count)
                var len:Int32=0
                ndata.getBytes(&len, length: data.count)
                if let buff=client.read(Int(len)){
                    let msgd = Data(bytes: buff, count: buff.count)
                    
                    let msgi = String(data: msgd, encoding: .utf8)
                    
//                    let msgi = (try! JSONSerialization.jsonObject(with: msgd,
//                                                                  options: .mutableContainers)) as! [String:Any]
                    return msgi
                }
            }
        }
        return nil
    }

    
    
    func sendMsg(msg:[String:Any]){
        let jsondata=try? JSONSerialization.data(withJSONObject: msg, options:
            JSONSerialization.WritingOptions.prettyPrinted)
        var len:Int32=Int32(jsondata!.count)
        
        DBLog("json=>\(jsondata!)&msg=>\(msg)")
        
        let data = Data(bytes: &len, count: 4)
        _ = client.send(data: data)
        _ = client.send(data: jsondata!)
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
