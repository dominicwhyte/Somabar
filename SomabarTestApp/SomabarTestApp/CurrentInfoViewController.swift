//
//  CurrentInfoViewController.swift
//  SomabarTestApp
//
//  Created by Dominic Whyte on 05/09/16.
//  Copyright © 2016 relayr. All rights reserved.
//

import UIKit

class CurrentInfoViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pingsLabel.text = "Pings sent: \(String(pings))  Pongs received: \(String(pongs))"
    }
    
    var contents : [String] = ["", "", "", "", "","",""]
    
    
    
    @IBAction func podInfoButtonClicked(sender: UIButton) {
        let id : Int = Int(sender.titleLabel!.text!)!
        demoEnteredAlert(self, Title: "Info for Pod with ID \(id)",
                         TitleColor: UIColor(red: 216/256, green: 220/256, blue: 221/255, alpha: 1),
                         Message: contents[id],
                         MessageColor: UIColor(red: 216/256, green: 220/256, blue: 221/255, alpha: 1),
                         BackgroundColor: UIColor(red: 103/256, green: 118/256, blue: 122/255, alpha: 1),
                         BorderColor: UIColor.blackColor(),
                         ButtonColor: UIColor(red: 216/256, green: 220/256, blue: 221/255, alpha: 1))
        
        
        
    }
    
    func updatePod(id : Int, text : String) {
        self.contents[id - 1] = text
    }
    
    func demoEnteredAlert(View: UIViewController, Title: String, TitleColor: UIColor, Message: String, MessageColor: UIColor, BackgroundColor: UIColor, BorderColor: UIColor, ButtonColor: UIColor) {
        
        let TitleString = NSAttributedString(string: Title, attributes: [NSFontAttributeName : UIFont.systemFontOfSize(15), NSForegroundColorAttributeName : TitleColor])
        let MessageString = NSAttributedString(string: Message, attributes: [NSFontAttributeName : UIFont.systemFontOfSize(15), NSForegroundColorAttributeName : MessageColor])
        
        let alertController = UIAlertController(title: Title, message: Message, preferredStyle: .Alert)
        
        alertController.setValue(TitleString, forKey: "attributedTitle")
        alertController.setValue(MessageString, forKey: "attributedMessage")
        
        
        
        let cancelAction = UIAlertAction(title: "OK", style: .Cancel) { (_) in }
        
        alertController.addAction(cancelAction)
        
        
        let subview = alertController.view.subviews.first! as UIView
        let alertContentView = subview.subviews.first! as UIView
        alertContentView.backgroundColor = BackgroundColor
        alertContentView.layer.cornerRadius = 10
        alertContentView.alpha = 1
        alertContentView.layer.borderWidth = 1
        alertContentView.layer.borderColor = BorderColor.CGColor
        
        
        //alertContentView.tintColor = UIColor.whiteColor()
        alertController.view.tintColor = ButtonColor
        
        self.presentViewController(alertController, animated: true) {
            // ...
        }
    }

    @IBOutlet weak var pingsLabel: UILabel!
    
    var pings = 0
    var pongs = 0
    
    func updateLabelNewPing() {
        pings = pings + 1
        if (pingsLabel != nil) {
            pingsLabel.text = "Pings sent: \(String(pings))  Pongs received: \(String(pongs))"
        }
        
    }
    
    func updateLabelNewPong() {
        pongs = pongs + 1
        if (pingsLabel != nil) {
           pingsLabel.text = "Pings sent: \(String(pings))  Pongs received: \(String(pongs))"
        }
        
    }
    
}
