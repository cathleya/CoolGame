//
//  CGMates.swift
//  CoolGame
//
//  Created by herry on 19/01/2017.
//  Copyright © 2017 herry. All rights reserved.
//

import UIKit

class CGMates: CGBaseController ,UITableViewDelegate,UITableViewDataSource{
    
    
    var table:UITableView!
    
    var matesArr = [Any]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "好友"
        
        table = UITableView(frame: CGRect(x: 0, y: 64, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-64), style:.grouped)
        table.showsVerticalScrollIndicator = false
        table.separatorInset = UIEdgeInsetsMake(0, 0, 0, 15)
        table.backgroundColor = UIColor.clear
        table.dataSource = self
        table.delegate = self
        view.addSubview(table)
        
        let barbtn = UIBarButtonItem(title: "添加", style: .plain, target: self, action: #selector(self.addaction))
        barbtn.tintColor = UIColor.white
        navigationItem.rightBarButtonItem = barbtn
        

        self.setupuserdata()
        
    }
    
    func addaction() {
        let addmate = CGCreateMateVC()
        addmate.closure = {
            self.setupuserdata()
        }
        navigationController?.pushViewController(addmate, animated: true)
    }
    
    func setupuserdata() {
        
        let parameter = ["uname":CGAppConfig.username()]
        
        self.isLoading(true)
        HttpAgent.access(url_Mates, .post, parameter, {(resdata,error) in
            self.isLoading(false)
            if error == nil {
                
                let data:[String:Any] = resdata as! [String : Any]
                let status = "\(data["status"]!)"
                let result:Int = Int(status)!
                
                if result == 0 {
                    
                    self.matesArr = data["msg"] as! [Any]
                    
                    self.table.reloadData()
                    
                }else{
                    EXAlert.alert("温馨提示：\(data["msg"] as? String)" ,.CENTER)
                }
                
            }else{
                EXAlert.alert("发生错误：\(error!)" ,.CENTER)
            }
            
        })

        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matesArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:CGMateCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CGMateCell? ?? CGMateCell(style: .subtitle , reuseIdentifier: "cell")
        cell.cellData = matesArr[indexPath.row] as! [String : Any]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0000001
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0000001
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let user = matesArr[indexPath.row] as! [String:Any]
//        let reUser = ["uid":user["uid"]!,"alias":user["alias"]!,"uname":user["uname"]!,"lastmsg":"江湖梦，断肠情。","msgtime":LOCALTIME()]
        
        let chat = CGChatRoomVC()
        chat.chatUser = user
        chat.hidesBottomBarWhenPushed = true
        _ = navigationController?.pushViewController(chat, animated: true)
        
        
        let result = CoreDataStack.share.query("Contacts", "uname='\(user["uname"]!)'")!
        
        if result.count<1 {
            //save message to local database
            CoreDataStack.share.insert("Contacts",user)
        }
        
        DBLog(result)
        
        DBLog(user)
        
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
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
