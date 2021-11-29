//
//  ResourceViewer.swift
//  Final Project App
//
//  Created by user203874 on 11/28/21.
//

import Foundation
import WebKit

class ResourceViewer: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    var link:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: link!)
        let request = URLRequest(url: url!)
        webView.load(request)
    }
}

