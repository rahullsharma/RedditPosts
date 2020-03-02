//
//  WebViewController.swift
//  RedditListings
//
//  Created by Rahul Sharma on 2/29/20.
//  Copyright © 2020 Rahul Sharma. All rights reserved.
//


import Foundation
import SnapKit
import WebKit

class WebViewController: UIViewController {
    
    private let webView = WKWebView(frame: .zero)
    private var urlString = ""
    
    init(urlString: String) {
        self.urlString = urlString
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        view.addSubview(webView)
        webView.snp.makeConstraints() { make in
            make.edges.equalToSuperview()
        }
        if let url = URL.init(string: urlString) {
            let request = URLRequest(url: url)
            self.webView.load(request)
        }
    }
}
