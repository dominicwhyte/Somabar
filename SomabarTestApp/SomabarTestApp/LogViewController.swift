//
//  LogViewController.swift
//  SomabarTestApp
//
//  Created by Dominic Whyte on 05/09/16.
//  Copyright © 2016 relayr. All rights reserved.
//

import UIKit

class LogViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.logTextView.layoutManager.allowsNonContiguousLayout = false

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var logTextView: UITextView!
    
    func writeTexttoLog(text : String, additionalNewLineNeeded : Bool) {
        if (additionalNewLineNeeded) {
            logTextView.text = logTextView.text.stringByAppendingString("\n")
        }
        logTextView.text = logTextView.text.stringByAppendingString("\n")
        logTextView.text = logTextView.text.stringByAppendingString(text)
        let stringLength:Int = self.logTextView.text.characters.count
        self.logTextView.scrollRangeToVisible(NSMakeRange(stringLength-1, 0))
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
