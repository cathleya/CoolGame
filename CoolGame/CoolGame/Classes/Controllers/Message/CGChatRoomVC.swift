//
//  CGChatRoomVC.swift
//  CoolGame
//
//  Created by herry on 06/01/2017.
//  Copyright © 2017 herry. All rights reserved.
//



import UIKit

class CGChatRoomVC: CGBaseController , UITextViewDelegate, UITableViewDelegate, UITableViewDataSource ,SockDelegate{
    
    var sendField:UITextView!
    var table:UITableView!
    
    var msgArr = [Any]()
    var currentPage = 0
    
    
    let access = CGCoreSocket.access
    
    var chatUser = [String:Any]()
    var clientUsr = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = chatUser["alias"] as? String
        clientUsr = CGAppConfig.username()
        
        table = UITableView(frame: CGRect(x: 0, y: 64, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-104), style:.grouped)
        table.showsVerticalScrollIndicator = false
        table.backgroundColor = UIColor.clear
        table.separatorStyle = .none
        table.dataSource = self
        table.delegate = self
        view.addSubview(table)
        
        sendField = UITextView(frame: CGRect(x: 0, y: SCREEN_HEIGHT-40, width: SCREEN_WIDTH-60, height: 40))
        sendField.backgroundColor = UIColor.white
        sendField.delegate = self
        view.addSubview(sendField)
        
        let sendBtn = UIButton(frame: CGRect(x: SCREEN_WIDTH-60, y: SCREEN_HEIGHT-40, width: 60, height: 40))
        sendBtn.addTarget(self, action: #selector(self.sendAction), for: .touchUpInside)
        sendBtn.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        sendBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        sendBtn.layer.borderColor = UIColor.lightGray.cgColor
        sendBtn.setTitleColor(UIColor.black, for: .normal)
        sendBtn.backgroundColor = UIColor.white
        sendBtn.setTitle("发送", for: .normal)
        sendBtn.layer.borderWidth = 0.1
        view.addSubview(sendBtn)
        
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(self.tableRefresh(_:)), for: .valueChanged)
        table.addSubview(refresh)
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.keyBoardHidden))
        tap.numberOfTouchesRequired = 1
        tap.numberOfTapsRequired = 1
        view.addGestureRecognizer(tap)
        
        access.delegate = self
        
        
        
        //load local data
        let regx = "alias = '\(clientUsr)' || alias = '\(chatUser["uname"]!)'"
        let query = CoreDataStack.share.querypages("Messages", regx, currentPage)!
//        for elememt in query {msgArr.insert(elememt, at: 0)}
//        msgArr.reverse()
        
        let share = CoreDataStack.share
        
        
        msgArr = query
        //table.reloadData()
        
        DBLog(share.statistics("Messages", regx))
        
        
    }
    
    // MARK: - UITableViewDelegate, UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return msgArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let msgBody:[String:Any] = msgArr[indexPath.row] as! [String:Any]
        let msgfrom = msgBody["name"] as? String
        if msgfrom == clientUsr {
            let cell:CGChatSenCell = tableView.dequeueReusableCell(withIdentifier: "sencell") as! CGChatSenCell? ?? CGChatSenCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "sencell")
            cell.messageInfo = msgBody
            return cell
        }else{
            let cell:CGChatRevCell = tableView.dequeueReusableCell(withIdentifier: "revcell") as! CGChatRevCell? ?? CGChatRevCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "revcell")
            cell.messageInfo = msgBody
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let msgBody:[String:AnyObject] = msgArr[indexPath.row] as! [String:AnyObject]
        let content = msgBody["content"] as! String
        let mHeight = content.heightWithConstrainedWidth(SCREEN_WIDTH-100,UIFont.systemFont(ofSize: 12))
        return mHeight+25
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.000001;
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.000001;
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView){
        sendField.endEditing(true)
        UIView.animate(withDuration: 0.3, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        })
    }
    
    
    // MARK: - UITextViewDelegate
    func textViewDidBeginEditing(_ textView: UITextView) {
        UIView.animate(withDuration: 0.3, animations: {
            self.view.frame = CGRect(x: 0, y: -258, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        })
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        UIView.animate(withDuration: 0.3, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        })
    }
    
    // MARK: - Action Selector
    func keyBoardHidden(){
        sendField.endEditing(true)
        UIView.animate(withDuration: 0.3, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        })
    }
    
    func tableRefresh(_ sender:UIRefreshControl) {
        
        currentPage += 1
        
        let query = CoreDataStack.share.querypages("Messages", "alias = '\(clientUsr)' || alias = '\(chatUser["uname"]!)'", currentPage)!
        for elememt in query {msgArr.insert(elememt, at: 0)}
        msgArr.reverse()
        table.reloadData()
        sender.endRefreshing()
        table.scrollToTop()
    }
    
    func sendAction() {
        
        //{alias,name,content,srtype,mtime,groupid}
        
        let msgStr = sendField.text!
        
        if !msgStr.isEmpty {
            
            let dateFormat = DateFormatter()
            dateFormat.dateFormat = "MM.DD-HH:MM"
            let timeStr = dateFormat.string(from: NSDate() as Date)
            
            let msgBody = ["alias":chatUser["uname"]!,
                           "name":clientUsr,
                           "content":msgStr,
                           "srtype":"0",
                           "mtime":timeStr,
                           "groupid":"0"]
            
            msgArr.append(msgBody)
            let indexpath:IndexPath = IndexPath(row: msgArr.count-1, section: 0)
            table.insertRows(at: [indexpath], with: .fade)
            table.scrollToRow(at: indexpath, at: .bottom, animated: true)
            
            //send
            access.send(msgBody)
            sendField.text = ""
            
            //save message to local database
            CoreDataStack.share.insert("Messages",msgBody)
            
        }
    }
    
    func recieve(_ msg: [String:Any]) {
        
        let user = chatUser["uname"] as? String
        let msgfrom = msg["name"] as? String

        if msgfrom == user {
            msgArr.append(msg)
            let indexpath:IndexPath = IndexPath(row: msgArr.count-1, section: 0)
            table.insertRows(at: [indexpath], with: .fade)
            table.scrollToRow(at: indexpath, at: .bottom, animated: true)
            
        }
        
        
    }
    
    func conStatus(_ status:Bool){
        
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
