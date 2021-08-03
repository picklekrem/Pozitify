//
//  CustomPageViewController.swift
//  Pozitify
//
//  Created by Onur Başdaş on 3.08.2021.
//

import UIKit

protocol customPageViewControllerDelegate: AnyObject {
    func numberOfPage(numberOfPage: Int)
    func pageChangedTo(index: Int)
}

class CustomPageViewController: UIPageViewController {
    
    weak var customDelegate : customPageViewControllerDelegate?
    var individualPageViewControllerList = [UIViewController]()
    
    var currentPageIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        individualPageViewControllerList = [
            DemoPageViewController.getInstance(image: "Walkthrough1"),
            DemoPageViewController.getInstance(image: "Walkthrough2"),
            DemoPageViewController.getInstance(image: "Walkthrough3")
        ]
        
        dataSource = self
        delegate = self
        
        customDelegate?.numberOfPage(numberOfPage: individualPageViewControllerList.count)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setViewControllers([individualPageViewControllerList[0]], direction: .forward, animated: true, completion: nil)
    }
    
    func goToPage(index: Int) {
        let currentViewController = viewControllers!.first!
        let currentViewControllerIndex = individualPageViewControllerList.firstIndex(of: currentViewController)!
        let direction: NavigationDirection = index > currentViewControllerIndex ? .forward : .reverse
        setViewControllers([individualPageViewControllerList[index]], direction: direction, animated: true, completion: nil)
    }
    
}

extension CustomPageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let indexOfCurrentPageViewController = individualPageViewControllerList.firstIndex(of: viewController)!
        if indexOfCurrentPageViewController == 0 {
            return nil
        } else {
            return individualPageViewControllerList[indexOfCurrentPageViewController - 1]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let indexOfCurrentPageViewController = individualPageViewControllerList.firstIndex(of: viewController)!
        if indexOfCurrentPageViewController == individualPageViewControllerList.count - 1 {
            return nil
        } else {
            return individualPageViewControllerList[indexOfCurrentPageViewController + 1]
        }
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let currentPageViewController = pageViewController.viewControllers?.first {
            let index = individualPageViewControllerList.firstIndex(of: currentPageViewController)!
            customDelegate?.pageChangedTo(index: index)
        }
    }
}
