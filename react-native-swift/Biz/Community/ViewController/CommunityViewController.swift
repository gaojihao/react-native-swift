//
//  CommunityViewController.swift
//  react-native-swift
//
//  Created by Saiki on 2024/7/31.
//

import UIKit
import WebKit

class CommunityViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        addWKWebView()
    }

    // 添加wkwebview并监听页面跳转
    func addWKWebView() {
        let webView = WKWebView(frame: .zero)
        webView.navigationDelegate = self
        webView.uiDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        webView.scrollView.bounces = false
//        webView.scrollView.isScrollEnabled = true
        webView.scrollView.showsVerticalScrollIndicator = false
        webView.scrollView.showsHorizontalScrollIndicator = false
        webView.scrollView.isScrollEnabled = true
        webView.load(URLRequest(url: URL(string: "https://h5-test.apcommunitys.com/#/home")!))
        self.view.addSubview(webView)
        
        webView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(self.view)
            make.top.equalTo(self.view.snp.top)
        }
    }
}

extension CommunityViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        print("decidePolicyFor")
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        print("decidePolicyFor")
        decisionHandler(.allow)
    }
}

extension CommunityViewController: WKUIDelegate {
    func webViewDidClose(_ webView: WKWebView) {
        
    }
}
