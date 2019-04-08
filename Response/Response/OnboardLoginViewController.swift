//
//  OnboardLoginViewController.swift
//  Response
//
//  Created by Keivan Shahida on 4/5/18.
//  Copyright © 2018 Keivan Shahida. All rights reserved.
//

import Foundation
import UIKit
import AVKit
import AVFoundation

protocol OnboardLoginDelegate {
    func loginNextPage()
}

class OnboardLoginViewController: UIViewController {
    
    // MARK: - INITIALIZATION
    var onboardLoginDelegate: OnboardLoginDelegate!
    
    var backgroundView: AVPlayerLayer!
    var playerLooper: NSObject!
    var queuePlayer: AVQueuePlayer!
    
    var facebookLoginButton: RoundedRectangleButton!
    var emailLoginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .responseBlack
        
        layoutSubviews()
        setConstraints()
    }
    
    // MARK: - LAYOUT
    func layoutSubviews(){
        
        if #available(iOS 10.0, *) {
            guard let path = Bundle.main.path(forResource: "placeholder", ofType:"mp4") else { return }
            let playerItem = AVPlayerItem(url: URL(fileURLWithPath: path))
            queuePlayer = AVQueuePlayer(items: [playerItem])
            backgroundView = AVPlayerLayer(player: self.queuePlayer)
            playerLooper = AVPlayerLooper(player: self.queuePlayer!, templateItem: playerItem)
            
            backgroundView.videoGravity = AVLayerVideoGravity.resizeAspectFill
            backgroundView.player?.volume = 0
            backgroundView.player?.play()
            backgroundView.frame = view.layer.bounds
            view.layer.insertSublayer(backgroundView, at: 0)
        }
        
        facebookLoginButton = RoundedRectangleButton(frame: .zero, text: "Login with Facebook", backgroundColor: .white, textColor: .responseBlack)
        facebookLoginButton.addTarget(self, action: #selector(facebookLogin), for: .touchUpInside)
        facebookLoginButton.translatesAutoresizingMaskIntoConstraints = false
        
        facebookLoginButton.setImage(#imageLiteral(resourceName: "icon-facebook"), for: .normal)
        facebookLoginButton.titleEdgeInsets = UIEdgeInsetsMake(0, 50, 0, -25)
        facebookLoginButton.contentHorizontalAlignment = .center
        facebookLoginButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 95)
        
        view.addSubview(facebookLoginButton)
        
        emailLoginButton = UIButton(frame: .zero)
        emailLoginButton.backgroundColor = .clear
        emailLoginButton.setTitle("Login with Email instead", for: .normal)
        emailLoginButton.setTitleColor(.white, for: .normal)
        emailLoginButton.setTitleColor(.white, for: .highlighted)
        emailLoginButton.titleLabel?.font = ._14ProximaRegular
        
        let attr = NSMutableAttributedString(string: "Login with Email instead")
        attr.addAttribute(.font, value: UIFont._14ProximaBold!, range: NSMakeRange(11, 5))
        emailLoginButton.titleLabel?.attributedText = attr
        
        emailLoginButton.addTarget(self, action: #selector(emailLogin), for: .touchUpInside)
        emailLoginButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emailLoginButton)
    }
    
    // MARK: - CONSTRAINTS
    func setConstraints(){
        facebookLoginButton.snp.makeConstraints{ (make) -> Void in
            make.height.equalTo(60)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalTo(emailLoginButton.snp.top).offset(-20)
        }
        
        emailLoginButton.snp.makeConstraints{ (make) -> Void in
            make.height.equalTo(17)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            if #available(iOS 11.0, *) {
                make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            } else {
                make.bottom.equalTo(bottomLayoutGuide.snp.top).offset(-20)
            }
        }
    }
    
    // MARK: - LOGIN
    @objc func facebookLogin() {
        print("login to facebook")
        onboardLoginDelegate.loginNextPage()
    }
    
    @objc func emailLogin() {
        print("login to email")
        onboardLoginDelegate.loginNextPage()
    }
}
