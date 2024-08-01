//
//  Color.swift
//  react-native-swift
//
//  Created by Saiki on 2024/8/1.
//

import UIKit

extension UIColor {
    
    /// 颜色拓展范发给
    /// - Parameters:
    ///   - r: 红色（0~255)
    ///   - g: 绿色（0~255)
    ///   - b: 蓝色（0~255)
    ///   - a: 透明度（0~1)
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1.0) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }
    
    /// 颜色拓展方法
    /// - Description 支持两种前缀（0x 和 #），支持两种长度（8位argb和6位rgb）
    /// - Parameters:
    ///   - hex: 十六进制表示法
    ///   - alpha: 如果前面 hex 为6位，那么可以用这个字段设置 alpha，不设置默认为1.0
     convenience init?(hex: String, alpha: CGFloat = 1.0) {
        var hexColor: String
        if hex.hasPrefix("#") {
            let startIndex = hex.index(hex.startIndex, offsetBy: 1)
            hexColor = String(hex[startIndex..<hex.endIndex])
        } else if hex.hasPrefix("0x") {
            let startIndex = hex.index(hex.startIndex, offsetBy: 2)
            hexColor = String(hex[startIndex..<hex.endIndex])
        } else {
            hexColor = hex
        }
        if hexColor.count == 8 {
            let scanner = Scanner(string: hexColor)
            var hexNumber: UInt64 = 0
            if scanner.scanHexInt64(&hexNumber) {
                let a = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                let r = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                let g = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                let b = CGFloat(hexNumber & 0x000000ff) / 255
                self.init(red: r, green: g, blue: b, alpha: a)
                return
            }
        }
        if hexColor.count == 6 {
            let scanner = Scanner(string: hexColor)
            var hexNumber: UInt64 = 0
            if scanner.scanHexInt64(&hexNumber) {
                let r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
                let g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
                let b = CGFloat(hexNumber & 0x0000ff) / 255
                self.init(red: r, green: g, blue: b, alpha: alpha)
                return
            }
        }
        return nil
    }
}


extension UIColor {
    
    /// 将颜色转为图片
    /// - Parameter size: 图片大小
    /// - Returns: 图片对象
    func asImage(_ size: CGSize) -> UIImage? {
        var resultImage: UIImage? = nil
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.main.scale)
                
        guard let context = UIGraphicsGetCurrentContext() else { return resultImage }
                
        context.setFillColor(self.cgColor)
        context.fill(rect)
        resultImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resultImage
    }
}
