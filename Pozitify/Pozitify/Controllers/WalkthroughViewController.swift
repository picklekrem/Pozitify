//
//  WalkthroughViewController.swift
//  Pozitify
//
//  Created by Onur Başdaş on 3.08.2021.
//

import UIKit

class WalkthroughViewController: UIViewController, customPageViewControllerDelegate {
 

    @IBOutlet var loginButton: UIButton!
    @IBOutlet var getStarted: UIButton!
    @IBOutlet var containerView: UIView!
    @IBOutlet var pageControl: UIPageControl!
    
    var myCustomPageViewController: CustomPageViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let desinationViewController = segue.destination as? CustomPageViewController {
            myCustomPageViewController = desinationViewController
            myCustomPageViewController.customDelegate = self
        }
    }
    
    func numberOfPage(numberOfPage: Int) {
        pageControl.numberOfPages = numberOfPage
    }
    
    func pageChangedTo(index: Int) {
        pageControl.currentPage = index
    }
        
    @IBAction func loginClicked(_ sender: Any) {
        loadScreen(name: "Auth", identifier: "loginVC")
    }
    
    @IBAction func getStartedClicked(_ sender: Any) {
        loadScreen(name: "Auth", identifier: "signUpVC")
    }
    
    @IBAction func pageControlChange(_ sender: Any) {
        let currentPageIndex = pageControl.currentPage
        myCustomPageViewController.goToPage(index: currentPageIndex)
    }
    
}
