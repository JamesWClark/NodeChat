//
//  ViewController.swift
//  iOSLocalWebViewClient
//
//  Created by J.W. Clark on 10/18/16.
//  Copyright © 2016 J.W. Clark. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let page = Bundle.main.path(forResource: "site/index", ofType: "html")!
        var content: String?
        do {
            content = try String(contentsOfFile: page, encoding: String.Encoding.utf8)
        } catch let error as NSError {
            print("error: \(error)")
        }
        
        let base = Bundle.main.path(forResource: "site/main", ofType: "css")!
        let baseUrl = URL(fileURLWithPath: base)
        webView.loadHTMLString(content!, baseURL: baseUrl)
    }
}

