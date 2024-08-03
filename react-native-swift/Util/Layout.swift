//
//  Layout.swift
//  react-native-swift
//
//  Created by Saiki on 2024/8/3.
//

import Foundation
import UIKit

enum Layout {
    
    /// 获取屏幕大小
    static func getScreenSize() -> CGSize {
        return UIScreen.main.bounds.size
    }
    
    static func getKeywindow() -> UIWindow? {
        var keyWindow: UIWindow? = nil
        for windowScene: UIWindowScene in (UIApplication.shared.connectedScenes as? Set<UIWindowScene>)! {
            if windowScene.activationState == .foregroundActive {
                for window in windowScene.windows {
                    if window.isKeyWindow {
                        keyWindow = window
                        break
                    }
                }
            }
        }
        return keyWindow
    }
    
    /// 获取当前可见的  VC
    static func getCurrentViewController() -> UIViewController? {
        guard let window = getKeywindow(), let rootVC = window.rootViewController else {
            return nil
        }
        var currentVC = rootVC
        repeat {
            if let presentedVC = currentVC.presentedViewController {
                currentVC = presentedVC
            } else {
                if currentVC.isKind(of: UINavigationController.self),
                   let navigationVC = currentVC as? UINavigationController,
                    let visibleVC = navigationVC.visibleViewController {
                    currentVC = visibleVC
                } else if currentVC.isKind(of: UITabBarController.self),
                          let tabbarVC = currentVC as? UITabBarController,
                          let selectedVC = tabbarVC.selectedViewController {
                    currentVC = selectedVC
                } else {
                    break
                }
            }
        } while(true)
        return currentVC
    }
    
    /// 获取当前可见的 VC的视图
    static func getViewOfCurrentViewController() -> UIView? {
        return Layout.getCurrentViewController()?.view
    }
}
