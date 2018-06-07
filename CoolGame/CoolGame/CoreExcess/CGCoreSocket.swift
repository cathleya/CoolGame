//
//  CGCoreSocket.swift
//  CoolGame
//
//  Created by herry on 09/01/2017.
//  Copyright © 2017 herry. All rights reserved.
//

import UIKit
import Alamofire
import SwiftSocket
import SwiftyJSON

protocol SockDelegate {
    func recieve(_ msg:[String:Any])
    func conStatus(_ status:Bool)
    
}

class CGCoreSocket: NSObject {
    private static let client = TCPClient(address: "192.168.31.148", port: 2345)
    var delegate:SockDelegate?
    
    static let  access:CGCoreSocket = { CGCoreSocket() }()
    
    func connect() {
        switch CGCoreSocket.client.connect(timeout: 10) {
        case .success:
            self.delegate!.conStatus(true)
            DispatchQueue.global(qos: .background).async {
                while true{
                    let msg1 = self.readmsg()
                    if msg1.count>0{
                        DispatchQueue.main.async {
                            self.delegate?.recieve(msg1)
                        }
                    }else{
                        DispatchQueue.main.async {
                            self.disconnect()
                        }
                        break
                    }
                    
                }
            }

            break
        case .failure(let error):
            self.delegate!.conStatus(false)
            DBLog("// 💩\(error)")
            break
        }
        
    }
    
    
    func disconnect() {
        CGCoreSocket.client.close()
    }
    
    
    func send(_ sendMsg:[String:Any]) {
        DBLog("sendMsg==>\(sendMsg)")
        let sendData : Data! = try? JSONSerialization.data(withJSONObject: sendMsg, options: []) as Data!
        var len:Int32=Int32(sendData.count)
        var data = Data(bytes: &len, count: 4)
        data.append(sendData)
        _ = CGCoreSocket.client.send(data: data)

    }
    
    func readmsg()->[String:Any]{
        if let data=CGCoreSocket.client.read(4){
            if data.count==4{
                let data = Data(bytes: data)
                let len: Int32 = data.withUnsafeBytes { $0.pointee }
                DBLog(len)
                if let buff=CGCoreSocket.client.read(Int(abs(len))){
                    let msgd = Data(bytes: buff, count: buff.count)
                    if let dictionary = JSON(data: msgd).dictionaryObject{
                        //save message to local database
                        DBLog("receiveMsg==>\(dictionary)")
                        if dictionary.count == 6 {
                            CoreDataStack.share.insert("Messages",dictionary)
                        }
                        return dictionary
                    }else{
                        return [:]
                    }
                }
            }
        }
        return [:]
    }


}


class HttpAgent: NSObject {
    
    static let shared: SessionManager = {
        let configuration: URLSessionConfiguration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        configuration.timeoutIntervalForResource = 15
        return SessionManager(configuration: configuration)
    }()
    
    class func access(_ url:String,_ method:HTTPMethod,_ params:[String: Any],_ closure:@escaping (Any?,String?)->()){
        
        DBLog("\(params)")
        
        var apphost:String
        #if DEBUG
            apphost = "\(APPHOST_DEBUG)\(url)"
        #else
            apphost = "\(APPHOST_RELEASE)\(url)"
        #endif
        
        HttpAgent.shared.request(apphost, method: method,parameters: params).response(completionHandler: {(response)in
            if (response.error == nil) {
                if let dictionary = JSON(data: response.data!).dictionaryObject{
                    closure(dictionary, nil)
                    DBLog("[\(url)]======>\n\(dictionary)")
                }else{
                    closure(nil, "数据异常")
                    DBLog("[\(url)]======>\n\(String(bytes: response.data!, encoding: .utf8)!)")
                }
            }else{
                closure(nil, "\(response.error!._code)")
                DBLog("[\(url)]======>\n\(response.error)")
                
            }
            
        })
        
    }
    
}

//let json = try? JSONSerialization.jsonObject(with: msgd, options: [])
//let msgi = String(data: msgd, encoding: .utf8)
// let res = msg.components(separatedBy: "&")


