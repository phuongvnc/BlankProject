//
//  PullTableView.swift
//  Blank Project
//
//  Created by framgia on 6/5/17.
//  Copyright © 2017 Vo Nguyen Chi Phuong. All rights reserved.
//

import UIKit

class PullTableView: UITableView {

    var startRefresh: ((UIRefreshControl) -> Void)?
    var endRefresh: ((UIRefreshControl) -> ())?
    var setupRefresh: ((UIRefreshControl) -> ())?

    var refreshControlView: UIRefreshControl!
    var isRefresh: Bool = false

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        refreshControlView = UIRefreshControl()
        refreshControlView.addTarget(self, action: #selector(startRefreshing), for: .valueChanged)
        setupRefresh?(refreshControlView)
    }

    func startRefreshing() {
        refreshControlView.beginRefreshing()
        startRefresh?(refreshControlView)
        isRefresh = true
    }

    func endRefreshing() {
        refreshControlView.endRefreshing()
        endRefresh?(refreshControlView)
        isRefresh = false
    }
}
