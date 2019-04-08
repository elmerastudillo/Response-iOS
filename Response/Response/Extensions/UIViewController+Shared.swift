//
//  UIViewController+Shared.swift
//  Response
//
//  Created by Elmer Astudillo on 4/4/18.
//  Copyright © 2018 Keivan Shahida. All rights reserved.
//

import UIKit

protocol PannableViewControllerDelegate {
    // TODO: Need to figure out how to pass in View Controller
    func pannableViewController()
}

fileprivate extension UIViewController {
    
    // TODO: Need to pass in view controller
    @objc func panGestureAction(_ panGesture: UIPanGestureRecognizer) {
        
        guard let pannableViewControllerDelegate = self as? PannableViewControllerDelegate else {
            return
        }
        print("THis is the view \(view)")
        print(panGesture)
        var originalPosition: CGPoint?
        var currentPositionTouched: CGPoint?
        let translation = panGesture.translation(in: view)
        print("This is the state of the pan gesture \(panGesture.state.rawValue)")
        
        originalPosition = view.center
        
        if panGesture.state == .began {
            print("pan gesture began")
            originalPosition = view.center
            currentPositionTouched = panGesture.location(in: view)
        } else if panGesture.state == .changed {
            print("pan gesture changed")
            view.frame.origin = CGPoint(
                x: translation.x,
                y: translation.y > 0 ? translation.y : 0
            )
        } else if panGesture.state == .ended {
            print("pan gesture ended")
            let velocity = panGesture.velocity(in: view)
            
            if velocity.y >= 1500 {
                UIView.animate(withDuration: 0.2
                    , animations: {
                        self.view.frame.origin = CGPoint(
                            x: self.view.frame.origin.x,
                            y: self.view.frame.size.height
                        )
                }, completion: { (isCompleted) in
                    if isCompleted {
                        self.dismiss(animated: false, completion: nil)
                    }
                })
            } else if velocity.y <= -1500{
                UIView.animate(withDuration: 0.2
                    , animations: {
                        self.view.frame.origin = CGPoint(
                            x: 0,
                            y: 0
                        )
                }, completion: { (isCompleted) in
                    if isCompleted {
                        // TODO: Need to set up to pass view controller
                        let respondViewController = RespondViewController()
                        self.present(respondViewController, animated: true, completion: nil)
                    }
                })
            } else {
                UIView.animate(withDuration: 0.2, animations: {
                    print(originalPosition)
                    self.view.center = originalPosition!
                })
            }
        }
        pannableViewControllerDelegate.pannableViewController()
    }
}

extension PannableViewControllerDelegate where Self: UIViewController {
    func addPannableGesture() {
        let pannableGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureAction))
        self.view.addGestureRecognizer(pannableGesture)
    }
}
