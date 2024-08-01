//
//  BaseViewController.swift
//  react-native-swift
//
//  Created by Saiki on 2024/7/31.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#080808", alpha: 1)
        // 装载视图
        setupView()
        
        // 绑定 ViewModel
        bindViewModel()
        
        // 加载数据
        loadData()
        // 更新约束
        view.setNeedsUpdateConstraints()
    }
    
    /// 装载视图
    @objc open func setupView() {}
    /// 添加订阅
    @objc open func bindViewModel() {}
    /// 加载数据
    @objc open func loadData() {}
    
}
