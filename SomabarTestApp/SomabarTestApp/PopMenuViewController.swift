//
//  PopMenuViewController.swift
//  SomabarTestApp
//
//  Created by Dominic Whyte on 04/09/16.
//  Copyright © 2016 relayr. All rights reserved.
//

import UIKit

internal let commands : [String] = ["Connect to Device", "Obtain Current Device Status", "Mix A Drink", "Write Pod Tag", "Read Pod Tag", "Set WiFi Credentials", "Perform A Rinse", "Set LED State", "Set Valve State", "Set Master Pump Enable", "Set Pump State"]


class PopMenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func buttonTapped(sender: AnyObject) {
        let button = sender as! UIButton
        let step : String = button.currentTitle!
        self.dismissViewControllerAnimated(true) { 
            NSNotificationCenter.defaultCenter().postNotificationName(step, object: nil, userInfo: nil)
        }
    }

}
