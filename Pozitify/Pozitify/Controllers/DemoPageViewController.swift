//
//  DemoPageViewController.swift
//  Pozitify
//
//  Created by Onur Başdaş on 3.08.2021.
//

import UIKit

class DemoPageViewController: UIViewController {
    
    static func getInstance(image: String) -> DemoPageViewController {
        let vc = UIStoryboard(name: "Walkthrough", bundle: nil).instantiateViewController(identifier: "DemoPageViewController") as! DemoPageViewController
        vc.imageName = image
        return vc
      }

    @IBOutlet var walkthroughView: UIImageView!
    
    var imageName = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        walkthroughView.image = UIImage(named: imageName)
    }
    
   
}
