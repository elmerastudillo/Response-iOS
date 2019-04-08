//
//  OnboardNotificationsViewController.swift
//  Response
//
//  Created by Keivan Shahida on 4/5/18.
//  Copyright © 2018 Keivan Shahida. All rights reserved.
//

import UIKit
import UserNotifications

protocol OnboardNotificationsDelegate {
    func notificationsNextPage()
}

class OnboardNotificationsViewController: UIViewController {
    
    // MARK: - INITIALIZATION
    var onboardNotificationsDelegate: OnboardNotificationsDelegate!
    
    var doneButton: RoundedRectangleButton!
    
    var titleLabel: UILabel!
    
    var crisisTitleLabel: UILabel!
    var crisisSubtitleLabel: UILabel!
    var crisisSwitch: UISwitch!
    var updatesTitleLabel: UILabel!
    var updatesSubtitleLabel: UILabel!
    var updatesSwitch: UISwitch!
    var newTitleLabel: UILabel!
    var newSubtitleLabel: UILabel!
    var newSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .responseBlack
        layoutSubviews()
        setConstraints()
    }
    
    // MARK: - LAYOUT
    func layoutSubviews(){
        doneButton = RoundedRectangleButton(frame: .zero, text: "Done", backgroundColor: .responseBlue, textColor: .white)
        doneButton.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(doneButton)
        
        titleLabel = UILabel(frame: .zero)
        titleLabel.font = ._24ProximaSemibold
        titleLabel.text = "When should we reach out?"
        titleLabel.textColor = .white
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        crisisTitleLabel = UILabel(frame: .zero)
        crisisTitleLabel.font = ._18ProximaBold
        crisisTitleLabel.text = "Crisis alerts."
        crisisTitleLabel.textColor = .white
        crisisTitleLabel.textAlignment = NSTextAlignment.left
        crisisTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(crisisTitleLabel)
        
        crisisSubtitleLabel = UILabel(frame: .zero)
        crisisSubtitleLabel.font = ._12ProximaRegular
        crisisSubtitleLabel.text = "Rare. We’ll only buzz your phone if there’s been a major event that needs your response."
        crisisSubtitleLabel.textColor = .white
        crisisSubtitleLabel.textAlignment = NSTextAlignment.left
        crisisSubtitleLabel.numberOfLines = 0
        crisisSubtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(crisisSubtitleLabel)
        
        crisisSwitch = UISwitch(frame: .zero)
        crisisSwitch.onTintColor = .responseBlue
        crisisSwitch.isOn = true
        view.addSubview(crisisSwitch)
        
        updatesTitleLabel = UILabel(frame: .zero)
        updatesTitleLabel.font = ._18ProximaBold
        updatesTitleLabel.text = "Updates on your causes."
        updatesTitleLabel.textColor = .white
        updatesTitleLabel.textAlignment = NSTextAlignment.left
        updatesTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(updatesTitleLabel)
        
        updatesSubtitleLabel = UILabel(frame: .zero)
        updatesSubtitleLabel.font = ._12ProximaRegular
        updatesSubtitleLabel.text = "Once or twice a week. We’ll show you exactly how your donations are being used."
        updatesSubtitleLabel.textColor = .white
        updatesSubtitleLabel.textAlignment = NSTextAlignment.left
        updatesSubtitleLabel.numberOfLines = 0
        updatesSubtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(updatesSubtitleLabel)
        
        updatesSwitch = UISwitch(frame: .zero)
        updatesSwitch.onTintColor = .responseBlue
        updatesSwitch.isOn = true
        view.addSubview(updatesSwitch)
        
        newTitleLabel = UILabel(frame: .zero)
        newTitleLabel.font = ._18ProximaBold
        newTitleLabel.text = "New and interesting."
        newTitleLabel.textColor = .white
        newTitleLabel.textAlignment = NSTextAlignment.left
        newTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(newTitleLabel)
        
        newSubtitleLabel = UILabel(frame: .zero)
        newSubtitleLabel.font = ._12ProximaRegular
        newSubtitleLabel.text = "A few times a week. We’ll try to spread awareness about causes you may care about."
        newSubtitleLabel.textColor = .white
        newSubtitleLabel.textAlignment = NSTextAlignment.left
        newSubtitleLabel.numberOfLines = 0
        newSubtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(newSubtitleLabel)
        
        newSwitch = UISwitch(frame: .zero)
        newSwitch.onTintColor = .responseBlue
        newSwitch.isOn = true
        view.addSubview(newSwitch)
    }
    
    // MARK: - CONSTRAINTS
    func setConstraints(){
        doneButton.snp.makeConstraints{ (make) -> Void in
            make.height.equalTo(60)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            if #available(iOS 11.0, *) {
                make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            } else {
                make.bottom.equalTo(bottomLayoutGuide.snp.top).offset(-20)
            }
        }
        
        titleLabel.snp.makeConstraints{ (make) -> Void in
            if #available(iOS 11.0, *) {
                make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(50)
            } else {
                make.top.equalTo(topLayoutGuide.snp.bottom).offset(50)
            }
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(29)
        }
        
        crisisTitleLabel.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-40)
            make.height.equalTo(22)
        }
        
        crisisSubtitleLabel.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(crisisTitleLabel.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(40)
            make.right.equalTo(crisisSwitch.snp.left)
            make.height.equalTo(30)
        }
        
        crisisSwitch.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(crisisTitleLabel.snp.top)
            make.left.equalTo(crisisSubtitleLabel.snp.right)
            make.right.equalToSuperview().offset(-40)
            make.height.equalTo(31)
            make.width.equalTo(51)
        }
        
        updatesTitleLabel.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(crisisSubtitleLabel.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-40)
            make.height.equalTo(22)
        }
        
        updatesSubtitleLabel.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(updatesTitleLabel.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(40)
            make.right.equalTo(updatesSwitch.snp.left)
            make.height.equalTo(30)
        }
        
        updatesSwitch.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(updatesTitleLabel.snp.top)
            make.left.equalTo(updatesSubtitleLabel.snp.right)
            make.right.equalToSuperview().offset(-40)
            make.height.equalTo(31)
            make.width.equalTo(51)
        }
        
        newTitleLabel.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(updatesSubtitleLabel.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-40)
            make.height.equalTo(22)
        }
        
        newSubtitleLabel.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(newTitleLabel.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(40)
            make.right.equalTo(newSwitch.snp.left)
            make.height.equalTo(30)
        }
        
        newSwitch.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(newTitleLabel.snp.top)
            make.left.equalTo(newSubtitleLabel.snp.right)
            make.right.equalToSuperview().offset(-40)
            make.height.equalTo(31)
            make.width.equalTo(51)
        }
    }
    
    // MARK: - NEXT
    @objc func nextPage(){
        if #available(iOS 10.0, *), (crisisSwitch.isOn || updatesSwitch.isOn || newSwitch.isOn) {
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options: [.badge, .alert, .sound]) { (granted, error) in
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
        onboardNotificationsDelegate.notificationsNextPage()
    }
}
