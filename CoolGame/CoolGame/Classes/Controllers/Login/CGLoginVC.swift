//
//  CGLoginVC.swift
//  CoolGame
//
//  Created by herry on 19/01/2017.
//  Copyright © 2017 herry. All rights reserved.
//

import UIKit

class CGLoginVC: CGBaseController ,SockDelegate{

    var uAccount:UITextField!
    var uPwd:UITextField!
    var rembtn:UIButton?
    var logCount:Int = 0
    let access = CGCoreSocket.access
    
    
    override func viewWillAppear(_ animated: Bool) {
        if CGAppConfig.whetherRemember() {
            rembtn?.isSelected = true
            uAccount.text = CGAppConfig.username()
            uPwd.text = CGAppConfig.userpwd()
        }else{
            rembtn?.isSelected = false
        }
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let accountBtn = UIButton(frame:CGRect(x: 0, y: 0, width: 38, height: 35))
        accountBtn.setImage(UIImage(named: "loghead.png"), for: UIControlState())
        uAccount = UITextField(frame:CGRect(x: 30, y: 180, width: SCREEN_WIDTH-60, height: 35))
        uAccount.backgroundColor = UL_SYSLIGHTGRAY
        uAccount.layer.cornerRadius = 5
        uAccount.placeholder = "请输入账号"
        uAccount.font = UIFont.systemFont(ofSize: 12)
        uAccount.leftViewMode = UITextFieldViewMode.always
        uAccount.leftView  = accountBtn
        view.addSubview(uAccount)
        
        let uPwdBtn = UIButton(frame:CGRect(x: 0, y: 0, width: 38, height: 35))
        uPwdBtn.setImage(UIImage(named: "logpwd.png"), for: UIControlState())
        uPwd = UITextField(frame:CGRect(x: 30, y: 230, width: SCREEN_WIDTH-60, height: 35))
        uPwd.backgroundColor = UL_SYSLIGHTGRAY
        uPwd.layer.cornerRadius = 5
        uPwd.isSecureTextEntry = true
        uPwd.placeholder = "请输入密码"
        uPwd.font = UIFont.systemFont(ofSize: 12)
        uPwd.leftViewMode = UITextFieldViewMode.always
        uPwd.leftView  = uPwdBtn
        view.addSubview(uPwd)
        
        //记住密码
        rembtn=UIButton(frame: CGRect(x: 35, y: 275,width: 15, height: 15))
        rembtn!.setImage(UIImage(named:"logcheck_17.png"), for: UIControlState.selected)
        rembtn!.layer.borderWidth = 1
        rembtn!.layer.borderColor = CG_NORMAL.cgColor
        rembtn?.addTarget(self, action: #selector(self.rembAction(_:)), for: .touchUpInside)
        view.addSubview(rembtn!)
        
        let remLab=UILabel(frame: CGRect(x: 55, y: 275, width: 70, height: 15))
        remLab.font = UIFont.systemFont(ofSize: 10)
        remLab.textColor = UIColor.darkGray
        remLab.text="记住密码";
        view.addSubview(remLab)
        
        let button = UIButton(frame: CGRect(x: 30, y: 300, width: SCREEN_WIDTH-60, height: 35))
        button.addTarget(self, action: #selector(self.loginAction), for: .touchUpInside)
        button.setTitle("登录", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.backgroundColor = CG_NORMAL
        button.layer.cornerRadius = 5
        view.addSubview(button)

        let tap = UITapGestureRecognizer(target: self, action: #selector(self.hidenKeyBoard))
        tap.numberOfTouchesRequired = 1
        tap.numberOfTapsRequired = 1
        view.addGestureRecognizer(tap)

    }
    
    func hidenKeyBoard() {
        view.endEditing(true)
    }
    
    func loginAction() {
        
        if uAccount.text!.isEmpty {
            EXAlert.alert("用户名不能为空", .CENTER)
            return
        }
        
        if uPwd.text!.isEmpty {
            EXAlert.alert("密码不能为空", .CENTER)
            return
        }
        
        self.isLoading(true)
        
        if logCount<1 {
            access.delegate = self
            access.connect()
        }else{
            let msg = ["uname":uAccount.text!,"upwd":uPwd.text!]
            access.send(msg)
            
        }
        
    }

    
    func conStatus(_ status:Bool){
        if status {
            logCount = 1
            DBLog("Connection successful 🎉")
            
            let msg = ["uname":uAccount.text!,"upwd":uPwd.text!]
            
            access.send(msg)
            
        }else{
            
            DBLog(" Connection failed // 💩")
            
            self.isLoading(false)
            EXAlert.alert("连接失败", .CENTER)
        
        }
    }
    
    func recieve(_ msg:[String:Any]){
        
        self.isLoading(false)
        
        let status = "\(msg["status"]!)"
        let result:Int = Int(status)!
        
        if result == 0 {
            EXAlert.alert("登录成功", .CENTER)
            CGAppConfig.saveUserName(uAccount.text!)
            CGAppConfig.saveUserpwd(uPwd.text!)
            KEYWINDOW?.rootViewController = CGTabBarController()
        }else if result == 1 {
            EXAlert.alert("用户不存在", .CENTER)
        }else if result == 2 {
            EXAlert.alert("密码错误", .CENTER)
        }else{
            logCount = 0
            access.disconnect()
            EXAlert.alert(msg["response"] as! String, .CENTER)
        }

    }
    
    func rembAction(_ sender:UIButton){
        sender.isSelected = !sender.isSelected
        CGAppConfig.savewhetherRemember(sender.isSelected)
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
