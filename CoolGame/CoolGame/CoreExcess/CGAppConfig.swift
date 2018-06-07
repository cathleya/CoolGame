//
//  CGAppConfig.swift
//  CoolGame
//
//  Created by herry on 25/02/2017.
//  Copyright © 2017 herry. All rights reserved.
//

import UIKit
import KeychainSwift

class CGAppConfig: NSObject {
    
    // MARK: - users information saving
    
    /**
     *  @brief 保存&读取用户名本地保存状态
     *  @param NSString 用户代码
     */
    class func savewhetherRemember(_ remember:Bool){
        UserDefaults.standard.set(remember, forKey: "rememberunameandpwd")
    }
    
    class func whetherRemember()->Bool{
        return UserDefaults.standard.bool(forKey: "rememberunameandpwd")
    }
    
    /**
     *  @brief 保存&读取用户名
     *  @param NSString 用户代码
     */
    class func saveUserName(_ uname:String){
        let keychain = KeychainSwift()
        keychain.set(uname, forKey: "cgusername")
        
    }
    
    class func username()->String{
        let keychain = KeychainSwift()
        return keychain.get("cgusername")!
    }
    
    
    /**
     *  @brief 保存&读取用户密码
     *  @param NSString 用户ID
     */
    class func saveUserpwd(_ upwd:String){
        let keychain = KeychainSwift()
        keychain.set(upwd, forKey: "cguserpassword")
    }
    
    class func userpwd()->String {
        let keychain = KeychainSwift()
        return keychain.get("cguserpassword")!
    }


}



let APPHOST_DEBUG = "http://192.168.31.148:8088"

let APPHOST_RELEASE = "http://183.86.210.58:8085/index.php"

/**
 *  @brief 用户好友列表&群列表
 *  @param Dictionary  type ,username ,password
 *  @return  status,msg
 */
let url_Mates = "/home/rest_handler/mateslist"

/**
 *  @brief 用户群列表
 *  @param Dictionary  type ,username ,password
 *  @return  status,msg
 */
let url_Groups = "/groups"

/**
 *  @brief 用户添加好友
 *  @param Dictionary  type ,username ,password
 *  @return  status,msg
 */
let url_AddMate = "/home/rest_handler/addmate"








