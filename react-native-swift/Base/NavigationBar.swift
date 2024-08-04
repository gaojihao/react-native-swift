//
//  NavigationBar.swift
//  react-native-swift
//
//  Created by Saiki on 2024/8/4.
//

import UIKit

/// 导航栏组件
class NavigationBar: UIView {
    
    /// 导航栏左侧按钮
    internal var leftBtn: UIButton? = nil
    /// 导航栏右侧按钮
    internal var rightBtn: UIButton? = nil
    /// 页面标题
    internal var titleBtn: UIButton? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(hex: "#080808", alpha: 1)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
    }
}

// MARK: Layout
extension NavigationBar {
    
    private func setupView() {
        
        // 左侧按钮
        let tmpLeftBtn = UIButton(type: .custom)
//        tmpLeftBtn.isHidden = true
        addSubview(tmpLeftBtn)
        leftBtn = tmpLeftBtn
        
        // 右侧按钮
        let tmpRightBtn = UIButton(type: .custom)
//        tmpRightBtn.isHidden = true
        addSubview(tmpRightBtn)
        rightBtn = tmpRightBtn
        
        // 标题
        let tmpTitleLabel = UIButton(type: .custom)
//        tmpTitleLabel.isHidden = true
        addSubview(tmpTitleLabel)
        titleBtn = tmpTitleLabel
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        leftBtn?.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        leftBtn?.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        leftBtn?.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        leftBtn?.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        leftBtn?.snp.makeConstraints({ make in
            make.left.top.bottom.equalTo(self)
            make.width.equalTo(60)
        })
        
        titleBtn?.snp.makeConstraints({ make in
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY)
        })
        
        rightBtn?.snp.makeConstraints({ make in
            make.right.top.bottom.equalTo(self)
            make.width.equalTo(60)
        })
    }
}
