//
//  SecondaryPageViewController.swift
//  SomabarTestApp
//
//  Created by Dominic Whyte on 04/09/16.
//  Copyright © 2016 relayr. All rights reserved.
//

import UIKit

class SecondaryPageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    var pages = [UIViewController]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.dataSource = self
        
        let page1: UIViewController! = storyboard?.instantiateViewControllerWithIdentifier("log") as UIViewController!
        let page2: UIViewController! = storyboard?.instantiateViewControllerWithIdentifier("receivedInfo") as UIViewController!
        pages.append(page1)
        pages.append(page2)
        
        setViewControllers([page1], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
    }
    
    //Swiping code
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let currentIndex = pages.indexOf(viewController)!
        let previousIndex = abs((currentIndex - 1) % pages.count)
        if(currentIndex == 0)
        {
            return nil;
        }
        return pages[previousIndex]
    }
    
    func updatePod(id : Int, text : String) {
        if (pages.count != 0) {
            if let viewController = pages[1] as? CurrentInfoViewController {
                viewController.updatePod(id, text : text)
            }
        }
        else {
            print("Error passing down MQTT info")
        }
    }
    
    func updateLabelNewPing() {
        if (pages.count != 0) {
            if let viewController = pages[1] as? CurrentInfoViewController {
                viewController.updateLabelNewPing()            }
        }
        else {
            print("Error passing down MQTT info")
        }
    }
    
    func updateLabelNewPong() {
        if (pages.count != 0) {
            if let viewController = pages[1] as? CurrentInfoViewController {
                viewController.updateLabelNewPong()            }
        }
        else {
            print("Error passing down MQTT info")
        }
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let currentIndex = pages.indexOf(viewController)!
        let nextIndex = abs((currentIndex + 1) % pages.count)
        if(currentIndex == (pages.count-1))
        {
            return nil;
        }
        return pages[nextIndex]
    }
    
    func writeTextToLog(text : String, additionalNewLineNeeded : Bool) {
        if (pages.count != 0) {
            if let viewController = pages[0] as? LogViewController {
                viewController.writeTexttoLog(text, additionalNewLineNeeded: additionalNewLineNeeded)
            }
        }
        else {
            print("Error passing down MQTT info")
        }
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
}