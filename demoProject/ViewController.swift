//
//  ViewController.swift
//  demoProject
//
//  Created by eugene golovanov on 5/2/16.
//  Copyright © 2016 eugene golovanov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //--------------------------------------------------------------------------------
    //MARK: - Properties

    
    
    @IBOutlet weak var hartView: HartSpinnerView!
    
    
    
    
    
    //--------------------------------------------------------------------------------
    //MARK: - View Lifecycle

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.hartView.hartBeat = true

    }

    
    
    
    
    
    //--------------------------------------------------------------------------------
    //MARK: - Actions
    
    @IBAction func beatSwitched(sender: UISwitch) {
        if sender.on {
            self.hartView.hartBeat = true
        } else {
            self.hartView.hartBeat = false
        }

    }
    
    
    
    @IBAction func startAnimation(sender: UIButton) {
        self.hartView.animating = true
    }

    
    @IBAction func stopAnimAction(sender: UIButton) {
        self.hartView.animating = false
    }
    

}

