//
//  BaseTableViewController.swift
//  react-native-swift
//
//  Created by Saiki on 2024/8/1.
//

import UIKit
import SnapKit
import MJRefresh

class BaseTableViewController: BaseViewController {

    public lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.delegate = self
        view.dataSource = self
        view.separatorStyle = .none
        view.backgroundColor = UIColor(hex: "#080808", alpha: 1)
        view.contentInsetAdjustmentBehavior = .never

        view.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(refreshData))
        view.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(loadMoreData))
        return view
    }()
    
    open override func setupView() {
        super.setupView()
        view.addSubview(tableView)
    }
    
    open override func updateViewConstraints() {
        super.updateViewConstraints()
        
        tableView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }

}

extension BaseTableViewController: UITableViewDelegate, UITableViewDataSource {
    open func numberOfSections(in tableView: UITableView) -> Int { 1 }
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { fatalError("numberOfRowsInSection should be override") }
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { fatalError("heightForRowAt should be override") }
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { fatalError("cellForRowAt should be override") }
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { tableView.deselectRow(at: indexPath, animated: true) }
    open func scrollViewDidScroll(_ scrollView: UIScrollView) {}
}

extension BaseTableViewController {
    /// 子类覆盖
    @objc open func refreshData() {}
    /// 子类覆盖
    @objc open func loadMoreData() {}
    
    /// 结束下拉刷新和上拉加载更多
    /// - Parameter hasMore: 是否还有更多数据
    public func endRefreshing(_ hasMore: Bool) {
        tableView.mj_header?.endRefreshing()
        if hasMore {
            tableView.mj_footer?.endRefreshing()
        } else {
            tableView.mj_footer?.endRefreshingWithNoMoreData()
        }
    }
}
