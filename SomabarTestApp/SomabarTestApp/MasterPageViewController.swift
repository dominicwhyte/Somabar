//
//  MasterPageViewController.swift
//  SomabarTestApp
//
//  Created by Dominic Whyte on 04/09/16.
//  Copyright © 2016 relayr. All rights reserved.
//

import UIKit

class MasterPageViewController: UIPageViewController, UIPageViewControllerDelegate {
    var pages = [UIViewController]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        var i = 0
        while (i < 11) {
            pages.append(storyboard?.instantiateViewControllerWithIdentifier(String(i)) as UIViewController!)
            i = i + 1
        }
        
        setViewControllers([pages[0]], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
    }
    
    //Swiping code
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let currentIndex = pages.indexOf(viewController)!
        var previousIndex = abs((currentIndex - 1) % pages.count)
        if (currentIndex == 0) {
            previousIndex = pages.count - 1;
        }
        return pages[previousIndex]
    }
    
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let currentIndex = pages.indexOf(viewController)!
        let nextIndex = abs((currentIndex + 1) % pages.count)
        return pages[nextIndex]
    }
    
    func switchToPage(toIndex : Int) {
            setViewControllers([pages[toIndex]], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
    }
}