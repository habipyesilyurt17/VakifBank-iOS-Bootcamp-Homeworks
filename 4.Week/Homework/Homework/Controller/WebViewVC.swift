//
//  WebViewVC.swift
//  Homework
//
//  Created by Habip Yesilyurt on 27.11.2022.
//

import UIKit
import WebKit

class WebViewVC: UIViewController, WKNavigationDelegate {
    @IBOutlet weak var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let urlString = "https://www.imdb.com/title/tt0903747/?ref_=nv_sr_srsg_0"
        if let url = URL(string: urlString) {
            webView.navigationDelegate = self
            webView.load(URLRequest(url: url))
        }
    }
}
