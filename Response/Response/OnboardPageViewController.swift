//
//  OnboardPageViewController.swift
//  Response
//
//  Created by Keivan Shahida on 4/5/18.
//  Copyright © 2018 Keivan Shahida. All rights reserved.
//

import UIKit

class OnboardPageViewController: UIPageViewController {
    
    // MARK: - INITIALIZATION
    
    var pages = [UIViewController]()
    let pageControl = UIPageControl()
    var currentPage = Int()
    
    var nextButton: RoundedRectangleButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let page1 = OnboardLoginViewController()
        page1.onboardLoginDelegate = self
        
        let page2 = OnboardCausesViewController()
        page2.onboardCausesDelegate = self
        
        let page3 = OnboardNotificationsViewController()
        page3.onboardNotificationsDelegate = self
        
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        setViewControllers([pages[0]], direction: .forward, animated: true, completion: nil)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if let viewControllerIndex = self.pages.index(of: viewController) {
            if viewControllerIndex < self.pages.count - 1 {
                currentPage = viewControllerIndex + 1
                return pages[currentPage]
            } else {
                currentPage = 0
                return pages.first
            }
        }
        return nil
    }
}

extension OnboardPageViewController: OnboardLoginDelegate {
    func loginNextPage() {
        guard let currentViewController = viewControllers?.first else { return }
        guard let nextViewController = pageViewController(self, viewControllerAfter: currentViewController) else { return }
        setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
    }
}

extension OnboardPageViewController: OnboardCausesDelegate {
    func causesNextPage() {
        guard let currentViewController = viewControllers?.first else { return }
        guard let nextViewController = pageViewController(self, viewControllerAfter: currentViewController) else { return }
        setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
    }
}

extension OnboardPageViewController: OnboardNotificationsDelegate {
    func notificationsNextPage() {
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "OnboardComplete")
        
        var topVC = UIApplication.shared.keyWindow?.rootViewController
        while((topVC!.presentedViewController) != nil){
            topVC = topVC!.presentedViewController
        }
        
        let transition = CATransition()
        transition.duration = 0.3
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionFade
        transition.subtype = kCATransitionFromTop
        topVC?.view.window!.layer.add(transition, forKey: nil)
        self.dismiss(animated: false, completion: nil)
    }
}
