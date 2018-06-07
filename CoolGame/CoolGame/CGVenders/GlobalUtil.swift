//
//  GlobalUtil.swift
//  OrientalGroup
//
//  Created by herry on 16/12/2016.
//  Copyright © 2016 herry. All rights reserved.
//

import UIKit

class GlobalUtil: NSObject {
    
}
    
// MARK: - 系统常量的定义

//应用主窗口大小
let SCREENBOUNDS = UIScreen.main.bounds
// 屏幕的物理宽度
var SCREEN_WIDTH = UIScreen.main.bounds.size.width
// 屏幕的物理高度
var SCREEN_HEIGHT = UIScreen.main.bounds.size.height
//应用主窗口
let KEYWINDOW = UIApplication.shared.keyWindow
//应用当前版本
let CURRENTVERISON = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String


let CG_SELECTED = RGB(0xfebc55)
let CG_NORMAL = RGB(0xcd53f8)
let CG_UNSELECT = RGB(0x495D74)

let CG_SENMSGBGCOLOR = RGB(0xf2cffe)
let CG_RECMSGBGCOLOR = RGB(0xFFFFFF)
let CG_MSGBORDER = RGB(0xcd53f8)

//RGB(0xE6E6E6)

//    let MSGBGCOLOR = RGB(0xA1E461)
//    let MSGBORDER = RGB(0x96D461)


//let UL_SYSRED = RGB(0xcd53f8)


let UL_SYSBLUE = RGB(0x03b0bc)
//let UL_SYSRED = RGB(0xfa5041)
let UL_SYSBLACK = RGB(0x3e3e3e)
let UL_SYSGRAY = RGB(0xa0a0a0)
let UL_SYSLIGHTGRAY = RGB(0xf2f2f2)
let UL_BORDER = RGB(0xd2d2d2)


//十六进制颜色
func RGB(_ rgbValue:UInt)->UIColor {
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

func LOCALTIME()->String{
    let dateFormat = DateFormatter()
    dateFormat.dateFormat = "MM.DD-HH:MM"
    return dateFormat.string(from: NSDate() as Date)
}

extension Data {
    init<T>(from value: T) {
        var value = value
        self.init(buffer: UnsafeBufferPointer(start: &value, count: 1))
    }
    
    func to<T>(type: T.Type) -> T {
        return self.withUnsafeBytes { $0.pointee }
    }
}

//自动计算字符串高度
extension String {
    func heightWithConstrainedWidth(_ width: CGFloat, _ font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        return boundingBox.height
    }
    
    func widthWithConstrainedHight(_ hight: CGFloat, _ font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: CGFloat.greatestFiniteMagnitude, height: 15)
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        return boundingBox.width
    }
    
}

extension NSAttributedString {
    func heightWithConstrainedWidth(width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
        return ceil(boundingBox.height)
    }
}


// MARK: - App沙盒路径
func KAPPPATH() -> String! {
    return NSHomeDirectory()
}

// temp路径
func KTEMPPATH() -> String! {
    return NSTemporaryDirectory()
}

// Documents路径
func KDOCUMENTPATH() -> String! {
    return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
}

// Library路径
func KLIBRARYPATH() -> String! {
    return NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true).first
}

// Caches路径
func KCACHESPATH() -> String! {
    return NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first
}

//Debug下打印日志
func DBLog<T>(_ message: T, fileName: String = #file, funcName: String = #function, lineNum : Int = #line) {

    #if DEBUG
    /**
     * 此处还要在项目的build settings中搜索swift flags,找到 Other Swift Flags 找到Debug
     * 添加 -D DEBUG,即可。
     */
    // 1.对文件进行处理
    let file = (fileName as NSString).lastPathComponent
    // 2.打印内容
    print("[\(NSDate())][\(file)][\(funcName)](\(lineNum))\(message)")
    
    #endif

}





