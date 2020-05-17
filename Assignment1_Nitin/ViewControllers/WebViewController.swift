//
//  WebViewController.swift
//  Assignment1_Nitin
//
//  Created by Xcode User on 2020-02-03.
//  Copyright © 2020 Xcode User. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
    
    
    @IBOutlet var webView : WKWebView!
    @IBOutlet var activity : UIActivityIndicatorView!
    
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activity.isHidden = false
        activity.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activity.isHidden = true
        activity.stopAnimating()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let urlAddress = URL(string: "https://www.sheridancollege.ca")
        
        let url = URLRequest(url : urlAddress!)
        
        webView.load(url)
        webView.navigationDelegate = self
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
