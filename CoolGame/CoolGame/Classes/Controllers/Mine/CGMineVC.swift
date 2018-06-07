//
//  CGMineVC.swift
//  CoolGame
//
//  Created by herry on 04/01/2017.
//  Copyright © 2017 herry. All rights reserved.
//

import UIKit

class CGMineVC: CGBaseController ,UITableViewDelegate,UITableViewDataSource{
    
    let array = [["好友动态","与我有关"],
                 ["我的收藏","观看直播"],
                 ["设置中心","退出"]]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let header = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 135))
        
        let table = UITableView(frame: CGRect(x: 0, y: 64, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-113), style:UITableViewStyle.grouped)
        table.separatorInset = UIEdgeInsetsMake(0, 0, 0, 15)
        table.backgroundColor = UIColor.clear
        table.dataSource = self
        table.delegate = self
        table.tableHeaderView = header
        view.addSubview(table)
        
    }
    
    
    // MARK: - 事件<代理和协议>
    func numberOfSections(in tableView: UITableView) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (array[section] as AnyObject).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "cell")
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        cell.textLabel!.textColor = UIColor.darkGray
        cell.textLabel!.font = UIFont.systemFont(ofSize: 15)
        
        let arr = array[indexPath.section]
        let cellArr = arr[indexPath.row]
        
        cell.textLabel!.text = "\(cellArr)"
        
        //cell.imageView!.image = UIImage(named: cellArr[1] as! String)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.000000001
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section==0&&indexPath.row==0{
            let bvc = CGMateMomentVC()
            bvc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(bvc, animated: true)
        }else if indexPath.section==0&&indexPath.row==1{
            let bvc = CGRelatedMeVC()
            bvc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(bvc, animated: true)
        }else if indexPath.section==1&&indexPath.row==0{
            let bvc = CGMyCollectionVC()
            bvc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(bvc, animated: true)
        }else if indexPath.section==1&&indexPath.row==1{
            let bvc = CGMyBroadcastVC()
            bvc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(bvc, animated: true)
        }else if indexPath.section==2&&indexPath.row==0{
            let bvc = CGSettingCenterVC()
            bvc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(bvc, animated: true)
        }else if indexPath.section==2&&indexPath.row==1{
            CGCoreSocket.access.disconnect()
            KEYWINDOW?.rootViewController = CGLoginVC()
        }
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
