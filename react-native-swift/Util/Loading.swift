//
//  Loading.swift
//  react-native-swift
//
//  Created by Saiki on 2024/8/3.
//

import UIKit

/// 加载弹窗
class LoadingView {
    private static var dialog: LoadingView? = nil
    private var popView: PopView? = nil
    
    class func show(text: String? = nil, inView: UIView? = nil) {
        dialog = LoadingView()
        dialog?.show(text: text, inView: inView)
    }
    
    class func hide() {
        dialog?.hide()
    }
    
    deinit {
    }
}


extension LoadingView {
    
    private func show(text: String?, inView: UIView?) {
        popView?.hide()
        guard let superView = inView ?? Layout.getKeywindow() else { return }
        
        // 3个跳动的点
        let pointView_x: CGFloat = 0
        let pointView_y: CGFloat = 0
        let pointView_w: CGFloat = 120
        let pointView_h: CGFloat = 50
        let pointView = AnimationPointView(frame: CGRect(x: pointView_x, y: pointView_y, width: pointView_w, height: pointView_h))
        pointView.showAnimation()
        
        // 加载中
        let label_x: CGFloat = 0
        let label_y: CGFloat = pointView_y + pointView_h
        let label_w: CGFloat = pointView_w
        let label_h: CGFloat = 20
        let titleLabel = UILabel(frame: CGRect(x: label_x, y: label_y, width: label_w, height: label_h))
        titleLabel.text = text ?? "loading"
        titleLabel.font = .boldSystemFont(ofSize: 14)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        
        // 容器
        let popView = PopView(frame: superView.bounds)
        popView.didHideClosure = {
            LoadingView.dialog = nil
        }
        popView.hideWhenTouchSpace = false
        popView.containerViewLayout.position = .center
        popView.containerViewLayout.horizontalMargin = (superView.bounds.width - pointView_w)/2
        popView.containerViewLayout.height = titleLabel.frame.maxY + 20
        popView.containerView.addSubview(pointView)
        popView.containerView.addSubview(titleLabel)
        popView.show(inView: superView)
        self.popView = popView
        
        // 超时自动关闭
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) { [weak self] in
            self?.hide()
        }
    }
    
    private func hide() {
        popView?.hide()
    }
}

fileprivate class AnimationPointView: UIView {
    
    private var leftPoint: UIView!
    private var centerPoint: UIView!
    private var rightPoint: UIView!
    
    deinit {
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showAnimation() {
        addAnimation(forView: leftPoint, delay: 0.01)
        addAnimation(forView: centerPoint, delay: 0.08)
        addAnimation(forView: rightPoint, delay: 0.16)
    }
    
    private func addAnimation(forView: UIView, delay: CFTimeInterval) {
        let height: CGFloat = 7
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.y")
        let currentTx = forView.transform.ty
        animation.duration = 0.9
        animation.repeatCount = MAXFLOAT
        animation.autoreverses = true
        animation.isRemovedOnCompletion = false
        animation.values = [currentTx,
                            currentTx + height,
                            currentTx]
        animation.keyTimes = [NSNumber(value: 0.0),
                              NSNumber(value:0.6),
                              NSNumber(value:1)]
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        animation.repeatDuration = 0
        animation.beginTime = delay
        forView.layer.add(animation, forKey: "swimming")
    }
    
    private func setupView() {
        
        let cornerRadius: CGFloat = 5.0
        
        leftPoint = UIView(frame: CGRect(x: 35, y: 20, width: 10, height: 10))
        leftPoint.backgroundColor = UIColor(hex: "#1368fb")!
        leftPoint.translatesAutoresizingMaskIntoConstraints = false
        leftPoint.layer.cornerRadius = cornerRadius
        addSubview(leftPoint)
        
        centerPoint = UIView(frame: CGRect(x: 55, y: 20, width: 10, height: 10))
        centerPoint.backgroundColor = UIColor(hex: "#1368fb")!
        centerPoint.translatesAutoresizingMaskIntoConstraints = false
        centerPoint.layer.cornerRadius = cornerRadius
        addSubview(centerPoint)
        
        rightPoint = UIView(frame: CGRect(x: 75, y: 20, width: 10, height: 10))
        rightPoint.backgroundColor = UIColor(hex: "#1368fb")!
        rightPoint.translatesAutoresizingMaskIntoConstraints = false
        rightPoint.layer.cornerRadius = cornerRadius
        addSubview(rightPoint)
    }
}
