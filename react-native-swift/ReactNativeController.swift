//
//  ViewController.swift
//  react-native-swift
//
//  Created by Saiki on 2023/5/15.
//

import UIKit
import React
import SnapKit
import ARKit

class ReactNativeController: UIViewController {
    private var bridge: RCTBridge? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "首页"
        setupReactNativeView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func setupReactNativeView() {
        guard let bridge = RCTBridge(delegate: self) else {
            return
        }
        self.bridge = bridge
        let rootView = RCTRootView(bridge: bridge, moduleName: "hybrid_earth", initialProperties: nil)
        view.addSubview(rootView)
        
        rootView.snp.makeConstraints({ make in
            make.edges.equalTo(self.view)
        })
    }
}

extension ReactNativeController: RCTBridgeDelegate {

    func sourceURL(for bridge: RCTBridge!) -> URL! {
#if DEBUG
        return RCTBundleURLProvider.sharedSettings().jsBundleURL(forBundleRoot: "index");
#else
        return Bundle.main.url(forResource: "main", withExtension: "jsbundle")
#endif
    }
    
    func concurrentRootEnabled() -> Bool {
        return true;
    }
    
}

