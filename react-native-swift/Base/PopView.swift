//
//  PopView.swift
//  react-native-swift
//
//  Created by Saiki on 2024/8/3.
//

import Foundation
import UIKit

// MARK: 容器视图所在位置
enum ContainerViewPosition {
    case center
    case bottom
}

// MARK: 弹框距离底部的距离
enum BottomMargin: CGFloat {
    // 常规距离
    case normal = 18
    // 为了避开中文键盘，设置为 336
    case keyboard = 336
}

// MARK: 容器布局参数
struct ContainerViewLayout {
    /// 容器所在位置
    var position: ContainerViewPosition = .bottom
    /// 高度
    var height: CGFloat = 172
    /// 水平外边距
    var horizontalMargin: CGFloat = 18
    /// 底部外边距，如果想避开键盘，可以设置为 336（中文键盘高度）
    var bottomMargin: CGFloat = BottomMargin.normal.rawValue
    /// 圆角
    var cornerRadius: CGFloat = 16
}

// MARK: 容器视图
class PopView: UIView {
    
    /// 容器View，需要显示的内容添加到该容器即可
    var containerView: UIView = UIView()
    /// 容器布局信息
    var containerViewLayout: ContainerViewLayout = ContainerViewLayout()
    /// 点击外部区域是否支持关闭弹窗
    var hideWhenTouchSpace: Bool = true
    
    /// 弹框显示完成时回调
    var didShowClosure: (() -> Void)? = nil
    /// 弹框消失完成时回调
    var didHideClosure: (() -> Void)? = nil
    
    /// 空白区域，点击容器可关闭
    private var alphaBtn: UIButton = UIButton(type: .custom)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 添加点击事件
        alphaBtn.backgroundColor = UIColor(hex: "#000000", alpha: 0.2)
        alphaBtn.addTarget(self, action: #selector(alphaBtnClicked), for: .touchUpInside)
        addSubview(alphaBtn)
        
        // 容器
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = containerViewLayout.cornerRadius
        containerView.layer.masksToBounds = true
        addSubview(containerView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        
    }
}

// MARK: 公共方法
extension PopView {
    
    /// 展示 PopView
    /// - Parameters:
    ///   - inView: 展示在哪个视图上
    ///   - didShowClosure: 动画结束时回调
    func show(inView: UIView) {
        inView.addSubview(self)
        
        alphaBtn.frame = inView.bounds
        containerView.frame = getHideFrame()
        UIView.animate(withDuration: 0.2) {
            self.containerView.frame = self.getShowFrame()
        } completion: { _ in
            self.didShowClosure?()
        }
    }
    
    /// 隐藏 PopView
    /// - Parameter animation: 是否显示动画
    func hide(animation: Bool = true) {
        if animation {
            UIView.animate(withDuration: 0.2) {
                self.containerView.frame = self.getHideFrame()
            } completion: { _ in
                self.removeFromSuperview()
                self.didHideClosure?()
            }
        } else {
            removeFromSuperview()
            self.didHideClosure?()
        }
    }
    
    @objc func alphaBtnClicked() {
        if hideWhenTouchSpace {
            hide(animation: true)
        }
    }
}

// MARK: 内部方法
extension PopView {
    
    /// 隐藏的布局
    private func getHideFrame() -> CGRect {
        guard let superview = superview else {
            return .zero
        }
        let x: CGFloat = containerViewLayout.horizontalMargin
        let y: CGFloat = Layout.getScreenSize().height
        let w: CGFloat = superview.bounds.width - containerViewLayout.horizontalMargin * 2
        let h: CGFloat = containerViewLayout.height
        return CGRect(x: x, y: y, width: w, height: h)
    }
    
    /// 显示的布局
    private func getShowFrame() -> CGRect {
        guard let superview = superview else {
            return .zero
        }
        let x: CGFloat = containerViewLayout.horizontalMargin
        let y: CGFloat = containerViewLayout.position == .center ? (superview.bounds.height - containerViewLayout.height)/2 : superview.bounds.height - containerViewLayout.height - containerViewLayout.bottomMargin
        let w: CGFloat = superview.bounds.width - containerViewLayout.horizontalMargin * 2
        let h: CGFloat = containerViewLayout.height
        return CGRect(x: x, y: y, width: w, height: h)
    }
}
