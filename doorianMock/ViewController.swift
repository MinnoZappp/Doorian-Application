//
//  ViewController.swift
//  doorianMock
//
//  Created by Warunya on 28/3/2566 BE.
//

import UIKit
import SwiftUI


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBSegueAction func embedSwiftUIView(_ coder: NSCoder) -> UIViewController? {
        return UIHostingController(coder: coder, rootView: AuthView())
    }
    
    
}

