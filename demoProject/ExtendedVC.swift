//
//  ExtendedVC.swift
//  demoProject
//
//  Created by eugene golovanov on 5/12/16.
//  Copyright © 2016 eugene golovanov. All rights reserved.
//

import UIKit

class ExtendedVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


    @IBAction func startAnimationAction(sender: UIButton) {
        self.hartSpinnerStartAnimating()
    }
    
    @IBAction func stopAnimationAction(sender: UIButton) {
        self.hartSpinnerStopAnimating()
    }
    
    
    
}
