//
//  CGMyMessageVC.swift
//  CoolGame
//
//  Created by herry on 04/01/2017.
//  Copyright © 2017 herry. All rights reserved.
//

import UIKit

class CGMessageVC: CGBaseController ,UITableViewDelegate,UITableViewDataSource {
    
    
    var contacts = [Any]()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "消息"
        
        let table = UITableView(frame: CGRect(x: 0, y: 64, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-64), style:.grouped)
        table.showsVerticalScrollIndicator = false
        table.separatorInset = UIEdgeInsetsMake(0, 0, 0, 15)
        table.backgroundColor = UIColor.clear
        table.dataSource = self
        table.delegate = self
        view.addSubview(table)
        
            
//        let user1 = ["uid":1,"alias":"herry","uname":"herry","lastmsg":"江湖梦，断肠情，人未进，杯莫停。","msgtime":LOCALTIME()] as [String : Any]
        
        //msgArr.append(user1)
        
        
        //load local data
        contacts = CoreDataStack.share.query("Contacts", "uname LIKE '*'")!
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:CGMessageCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CGMessageCell? ?? CGMessageCell(style: .subtitle , reuseIdentifier: "cell")
        cell.cellData = contacts[indexPath.row] as! [String : Any]
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

        let chat = CGChatRoomVC()
        chat.chatUser = contacts[indexPath.row] as! [String : Any]
        chat.hidesBottomBarWhenPushed = true
        _ = navigationController?.pushViewController(chat, animated: true)
        
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
