//
//  Toast.swift
//  react-native-swift
//
//  Created by Saiki on 2024/8/3.
//

import UIKit
import ObjectiveC

extension UIView {
    
    private struct ToastKeys {
        static var timer        = "com.toast-swift.timer"
        static var duration     = "com.toast-swift.duration"
        static var point        = "com.toast-swift.point"
        static var completion   = "com.toast-swift.completion"
        static var activeToasts = "com.toast-swift.activeToasts"
    }
    
    private class ToastCompletionWrapper {
        
        let completion: ((Bool) -> Void)?
        
        init(_ completion: ((Bool) -> Void)?) {
                self.completion = completion
        }
    }
        
    private var activeToasts: NSMutableArray {
        get {
            if let activeToasts = objc_getAssociatedObject(self, &ToastKeys.activeToasts) as? NSMutableArray {
                return activeToasts
            } else {
                let activeToasts = NSMutableArray()
                objc_setAssociatedObject(self, &ToastKeys.activeToasts, activeToasts, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return activeToasts
            }
        }
    }
    
    func makeToast(_ message: String) {
        let toast = toastViewForMessage(message)
        showToast(toast, duration: 2.0, completion: nil)
    }
    
    func showToast(_ toast: UIView, duration: TimeInterval = 2.0, completion: ((_ didTap: Bool) -> Void)? = nil) {
        let point = CGPoint(x: self.bounds.size.width / 2.0, y: self.bounds.size.height / 2.0)
        showToast(toast, duration: duration, point: point, completion: completion)
    }
    
    func showToast(_ toast: UIView, duration: TimeInterval = 2.0, point: CGPoint, completion: ((_ didTap: Bool) -> Void)? = nil) {
        objc_setAssociatedObject(toast, &ToastKeys.completion, ToastCompletionWrapper(completion), .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        showToast(toast, duration: duration, point: point)
    }
    
    func hideToast() {
        guard let activeToast = activeToasts.firstObject as? UIView else { return }
        hideToast(activeToast)
    }
    
    func hideToast(_ toast: UIView) {
        guard activeToasts.contains(toast) else { return }
        hideToast(toast, fromTap: false)
    }
    
    private func showToast(_ toast: UIView, duration: TimeInterval, point: CGPoint) {
        toast.center = point
        toast.alpha = 0.0
            
        activeToasts.add(toast)
        self.addSubview(toast)
            
        UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseOut, .allowUserInteraction], animations: {
                toast.alpha = 1.0
            }) { _ in
                let timer = Timer(timeInterval: duration, target: self, selector: #selector(UIView.toastTimerDidFinish(_:)), userInfo: toast, repeats: false)
                RunLoop.main.add(timer, forMode: .common)
                objc_setAssociatedObject(toast, &ToastKeys.timer, timer, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
    }
    
    private func hideToast(_ toast: UIView, fromTap: Bool) {
        if let timer = objc_getAssociatedObject(toast, &ToastKeys.timer) as? Timer {
            timer.invalidate()
        }
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseIn, .beginFromCurrentState], animations: {
            toast.alpha = 0.0
        }) { _ in
            toast.removeFromSuperview()
            self.activeToasts.remove(toast)
            
            if let wrapper = objc_getAssociatedObject(toast, &ToastKeys.completion) as? ToastCompletionWrapper, let completion = wrapper.completion {
                completion(fromTap)
            }
        }
    }
        
    @objc
    private func toastTimerDidFinish(_ timer: Timer) {
        guard let toast = timer.userInfo as? UIView else { return }
        hideToast(toast)
    }
    
    func toastViewForMessage(_ message: String) -> UIView {
            
        var messageLabel: UILabel?
            
        let wrapperView = UIView()
        wrapperView.backgroundColor = .white
        wrapperView.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin, .flexibleTopMargin, .flexibleBottomMargin]
        wrapperView.layer.cornerRadius = 8
        
        wrapperView.layer.shadowColor = UIColor(white: 0, alpha: 0.1).cgColor
        wrapperView.layer.shadowOpacity = 1
        wrapperView.layer.shadowRadius = 40.0
        wrapperView.layer.shadowOffset = CGSize(width: 0, height: 3.0)
        
        let imageRect = CGRect.zero
        
        messageLabel = UILabel()
        messageLabel?.text = message
        messageLabel?.numberOfLines = 0
        messageLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        messageLabel?.textAlignment = .center
        messageLabel?.textColor = .black
        messageLabel?.backgroundColor = UIColor.clear
        
        let maxMessageSize = CGSize(width: (self.bounds.size.width * 0.8) - imageRect.size.width, height: self.bounds.size.height * 0.8)
        let messageSize = messageLabel?.sizeThatFits(maxMessageSize)
        
        if let messageSize = messageSize {
            let actualWidth = min(messageSize.width, maxMessageSize.width)
            let actualHeight = min(messageSize.height, maxMessageSize.height)
            messageLabel?.frame = CGRect(x: 0.0, y: 0.0, width: actualWidth, height: actualHeight)
        }
            
        var messageRect = CGRect.zero
        let titleRect = CGRect.zero
            
        if let messageLabel = messageLabel {
            messageRect.origin.x = imageRect.origin.x + imageRect.size.width + 36
            messageRect.origin.y = titleRect.origin.y + titleRect.size.height + 12
            messageRect.size.width = messageLabel.bounds.size.width
            messageRect.size.height = messageLabel.bounds.size.height
        }
        
        let longerWidth = max(titleRect.size.width, messageRect.size.width)
        let longerX = max(titleRect.origin.x, messageRect.origin.x)
        let wrapperWidth = max((imageRect.size.width + 71), (longerX + longerWidth + 36))
        let wrapperHeight = max((messageRect.origin.y + messageRect.size.height + 12), (imageRect.size.height + 24))
        
        wrapperView.frame = CGRect(x: 0.0, y: 0.0, width: wrapperWidth, height: wrapperHeight)
            
        if let messageLabel = messageLabel {
            messageRect.size.width = longerWidth
            messageLabel.frame = messageRect
            wrapperView.addSubview(messageLabel)
        }
        
        return wrapperView
    }
}
