//
//  ViewController.swift
//  Pozitify
//
//  Created by Ekrem Özkaraca on 1.06.2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let array = ["horse", "cow", "camel", "sheep", "goat"]

        let defaults = UserDefaults.standard
        //defaults.set(array, forKey: "SavedStringArray")
        
        let myarray = defaults.stringArray(forKey: "SavedStringArray") ?? [String]()
        print(myarray)
    }


}

