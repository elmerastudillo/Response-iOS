//
//  OnboardCausesViewController.swift
//  Response
//
//  Created by Keivan Shahida on 4/5/18.
//  Copyright © 2018 Keivan Shahida. All rights reserved.
//

import UIKit

protocol OnboardCausesDelegate {
    func causesNextPage()
}

class OnboardCausesViewController: UIViewController {
    
    // MARK: - INITIALIZATION
    var onboardCausesDelegate: OnboardCausesDelegate!
    
    var nextButton: RoundedRectangleButton!
    
    var titleLabel: UILabel!
    var subtitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .responseBlack
        layoutSubviews()
        setConstraints()
    }
    
    // MARK: - LAYOUT
    func layoutSubviews(){
        nextButton = RoundedRectangleButton(frame: .zero, text: "Next", backgroundColor: .responseBlue, textColor: .white)
        nextButton.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nextButton)
        
        titleLabel = UILabel(frame: .zero)
        titleLabel.font = ._24ProximaSemibold
        titleLabel.text = "What do you care about?"
        titleLabel.textColor = .white
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        subtitleLabel = UILabel(frame: .zero)
        subtitleLabel.font = ._12ProximaRegular
        subtitleLabel.text = "Select 3 or more"
        subtitleLabel.textColor = .white
        subtitleLabel.textAlignment = NSTextAlignment.center
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(subtitleLabel)
    }
    
    // MARK: - CONSTRAINTS
    func setConstraints(){
        nextButton.snp.makeConstraints{ (make) -> Void in
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
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-40)
            make.height.equalTo(29)
        }
        
        subtitleLabel.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(15)
        }
        
    }
    
    // MARK: - NEXT
    @objc func nextPage(){
        onboardCausesDelegate.causesNextPage()
    }
}
