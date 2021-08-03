//
//  TermsViewController.swift
//  Pozitify
//
//  Created by Onur Başdaş on 3.08.2021.
//

import UIKit
import WebKit

class TermsViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet var termsView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        termsView.navigationDelegate = self
        let url = URL(string: Constants.termsLinkUrl)!
        termsView.load(URLRequest(url: url))
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
