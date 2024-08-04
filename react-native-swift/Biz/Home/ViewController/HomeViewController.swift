//
//  HomeViewController.swift
//  react-native-swift
//
//  Created by Saiki on 2024/7/31.
//

import UIKit

class HomeViewController: BaseViewController {
    let navbar = NavigationBar()
    
    private lazy var homeBTN: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "home", in: Bundle.main, with: nil), for: .normal)
        return button
    }()
    
    private lazy var liveBTN: UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(toLive), for: .touchUpInside)
        button.setImage(UIImage(named: "live", in: Bundle.main, with: nil), for: .normal)
        return button
    }()
    
    private lazy var sportsBTN: UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(toSport), for: .touchUpInside)
        button.setImage(UIImage(named: "sports", in: Bundle.main, with: nil), for: .normal)
        return button
    }()
    
    private lazy var lineView: UIView = {
        let view =  UIView()
        view.backgroundColor = UIColor(hex: "#171A1E", alpha: 1)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupView() {
        self.view.addSubview(navbar)
        self.view.addSubview(homeBTN)
        self.view.addSubview(liveBTN)
        self.view.addSubview(sportsBTN)
        self.view.addSubview(lineView)
        configNavBar()
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        navbar.snp.makeConstraints { make in
            make.left.right.equalTo(self.view)
            make.top.equalTo(self.view.snp_topMargin)
            make.height.equalTo(44)
        }
        
        homeBTN.snp.makeConstraints { make in
            make.left.equalTo(self.view.snp.left).offset(16)
            make.top.equalTo(navbar.snp.bottom)
            make.height.equalTo(44)
        }
        
        liveBTN.snp.makeConstraints { make in
            make.left.equalTo(homeBTN.snp.right).offset(12)
            make.top.equalTo(navbar.snp.bottom)
            make.height.equalTo(44)
        }
        
        sportsBTN.snp.makeConstraints { make in
            make.left.equalTo(liveBTN.snp.right).offset(12)
            make.top.equalTo(navbar.snp.bottom)
            make.height.equalTo(44)
        }
        
        lineView.snp.makeConstraints { make in
            make.left.right.equalTo(self.view)
            make.top.equalTo(homeBTN.snp.bottom)
            make.height.equalTo(1)
        }
    }
    
    private func configNavBar() {
        navbar.titleBtn?.setImage(UIImage(named: "logo", in: Bundle.main, with: nil), for: .normal)
        navbar.leftBtn?.setImage(UIImage(named: "user", in: Bundle.main, with: nil), for: .normal)
        navbar.rightBtn?.setImage(UIImage(named: "search", in: Bundle.main, with: nil), for: .normal)
    }
    
    @objc private func toLive() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "tabJump"), object: 2)
    }
    
    @objc private func toSport() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "tabJump"), object: 1)
    }
}
