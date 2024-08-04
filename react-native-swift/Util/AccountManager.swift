//
//  AccountManager.swift
//  react-native-swift
//
//  Created by Saiki on 2024/8/4.
//

import Foundation

final class AccountManager {
    
    /// 流程控制器单例
    static let manager = AccountManager()
    var account: Account?
}
