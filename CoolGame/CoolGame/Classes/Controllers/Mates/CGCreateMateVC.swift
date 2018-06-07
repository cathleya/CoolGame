//
//  CGCreateMateVC.swift
//  CoolGame
//
//  Created by herry on 03/03/2017.
//  Copyright © 2017 herry. All rights reserved.
//

import UIKit

class CGCreateMateVC: CGBaseController {
    
    var uAccount:UITextField!
    
    var closure:(()->())!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "添加好友"
       
        let accountBtn = UIButton(frame:CGRect(x: 0, y: 0, width: 38, height: 35))
        accountBtn.setTitleColor(UIColor.gray , for: .normal)
        accountBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        accountBtn.addTarget(self, action: #selector(self.addAction), for: .touchUpInside)
        accountBtn.setTitle("添加", for: .normal)
        
        uAccount = UITextField(frame:CGRect(x: 30, y: 80, width: SCREEN_WIDTH-60, height: 35))
        uAccount.backgroundColor = UL_SYSLIGHTGRAY
        uAccount.layer.cornerRadius = 5
        uAccount.placeholder = "请输入账号"
        uAccount.font = UIFont.systemFont(ofSize: 12)
        uAccount.rightViewMode = UITextFieldViewMode.always
        uAccount.rightView  = accountBtn
        view.addSubview(uAccount)
        
    }
    
    func addAction() {
        
        DBLog("\(uAccount.text)")
        
        let account = uAccount.text!.withoutSpacesAndNewLines
        
        if account.isEmpty {
            EXAlert.alert("账号不能为空", .CENTER)
            return
        }
        
        let parameter = ["myname":CGAppConfig.username(),"addname":account]
        
        self.isLoading(true)
        HttpAgent.access(url_AddMate, .post, parameter, {(resdata,error) in
            self.isLoading(false)
            if error == nil {
                
                let data:[String:Any] = resdata as! [String : Any]
                let status = "\(data["status"]!)"
                let result:Int = Int(status)!
                
                if result == 0 {
                    
                    EXAlert.alert("温馨提示：添加成功" ,.CENTER)
                    
                    self.closure()
                    self.navigationController?.popViewController()

                    
                }else{
                    EXAlert.alert("温馨提示：\(data["msg"] as? String)" ,.CENTER)
                }
                
            }else{
                EXAlert.alert("发生错误：\(error!)" ,.CENTER)
            }
            
        })
        
        
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
