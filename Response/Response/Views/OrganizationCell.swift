//
//  OrganizationCell.swift
//  Response
//
//  Created by Elmer Astudillo on 3/6/18.
//  Copyright © 2018 Keivan Shahida. All rights reserved.
//

import UIKit

protocol OrganizationDelegate {
    func respond(organization: Organization)
    func viewFollowers()
}

class OrganizationCell: UITableViewCell {
    
    // MARK: - INITIALIZATION
    var organizationDelegate: OrganizationDelegate!
    var organization: Organization?
    
    private var longPressGestureRecognizer: UILongPressGestureRecognizer? = nil
    private var isPressed: Bool = false
    
    var titleLabel = UILabel()
    var descriptionLabel = UILabel()
    
    var organizationImage : UIImageView!
    var cellCard: UIImageView!
    
    var responseButton = ResponseButton(frame: .zero, backgroundColor: .responseRed, title: "2.2K")
    var followersButton = UIButton()
    
    var buttonsStackView = UIStackView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.contentView.backgroundColor = UIColor.responseBlack
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LAYOUT
    override func layoutSubviews() {
        super.layoutSubviews()
        guard let organization = self.organization else { return }
        cellCard = UIImageView()
        cellCard.layer.cornerRadius = 15
        cellCard.clipsToBounds = true
//        cellCard.image = UIImage(named: organization.thumbnailImageURL)
        cellCard.image = UIImage(named: organization.thumbnailImageURL)
        cellCard.contentMode = .scaleAspectFill
        cellCard.isUserInteractionEnabled = true
        self.contentView.addSubview(cellCard)
        
        let cellRect = cellCard.bounds
        let coverView = UIView(frame: cellRect)
        coverView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        cellCard.addSubview(coverView)
        
        titleLabel = UILabel(frame: .zero)
        titleLabel.clipsToBounds = false
        titleLabel.textColor = .white
        titleLabel.text = organization.name.uppercased()
        titleLabel.textAlignment = .center
        titleLabel.font = ._18ProximaBold
        
        descriptionLabel = UILabel(frame: .zero)
        descriptionLabel.clipsToBounds = false
        descriptionLabel.textColor = .white
        descriptionLabel.text = organization.mission
        descriptionLabel.textAlignment = .center
        descriptionLabel.font = ._12ProximaBold
        descriptionLabel.alpha = 0.80
        descriptionLabel.numberOfLines = 0
        descriptionLabel.sizeToFit()
        
        organizationImage = UIImageView(frame:CGRect(x: 0, y: 0, width: 50, height: 50))
        organizationImage.image = UIImage(named:"unicef-logo-square")
        organizationImage.layer.cornerRadius = self.organizationImage.frame.size.width / 2
        organizationImage.clipsToBounds = true
        organizationImage.contentMode = .scaleAspectFit
        
        responseButton = ResponseButton(frame: .zero, backgroundColor: .responseRed, title: "45.2K", image: #imageLiteral(resourceName: "responseLogo"), inset: 5)
        responseButton.isUserInteractionEnabled = true
        responseButton.addTarget(self, action: #selector(respond), for: .touchUpInside)
        
        followersButton = ResponseButton(frame: .zero, backgroundColor: .responseBlue, title: "45.2K", image: #imageLiteral(resourceName: "responseLogo"), inset: 5)
        followersButton.isUserInteractionEnabled = true
        followersButton.addTarget(self, action: #selector(viewFollowers), for: .touchUpInside)
        
        buttonsStackView = UIStackView(arrangedSubviews: [responseButton, followersButton])
        buttonsStackView.axis = UILayoutConstraintAxis.horizontal
        buttonsStackView.distribution = UIStackViewDistribution.equalSpacing
        buttonsStackView.alignment = UIStackViewAlignment.center
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonsStackView.spacing = 10
        
        cellCard.addSubview(titleLabel)
        cellCard.addSubview(descriptionLabel)
        cellCard.addSubview(organizationImage)
        cellCard.addSubview(buttonsStackView)
        
        setUpConstraints()
    }
    
    // MARK: - CONSTRAINTS
    func setUpConstraints() {
        cellCard.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        
        organizationImage.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20)
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
           make.top.equalTo(organizationImage.snp.bottom).offset(5)
        }
        
        descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
        }
        
        buttonsStackView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
        }
        
        responseButton.snp.makeConstraints { (make) in
            make.height.equalTo(35)
            make.width.equalTo(80)
        }

        followersButton.snp.makeConstraints { (make) in
            make.height.equalTo(35)
            make.width.equalTo(80)
        }
        
        configureGestureRecognizer()
    }
    
    // MARK: - OrganizationDelegate
    @objc func respond() {
        guard let organization = self.organization else { return }
        organizationDelegate.respond(organization: organization)
    }
    
    @objc func viewFollowers() {
        //TODO: Need to pass object
        organizationDelegate.viewFollowers()
    }
    
    // MARK: - Gesture Recognizer
    private func configureGestureRecognizer() {
        // Long Press Gesture Recognizer
        longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGesture(gestureRecognizer:)))
        longPressGestureRecognizer?.minimumPressDuration = 0.15
        addGestureRecognizer(longPressGestureRecognizer!)
    }
    
    @objc internal func handleLongPressGesture(gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            handleLongPressBegan()
        } else if gestureRecognizer.state == .ended || gestureRecognizer.state == .cancelled {
            handleLongPressEnded()
        }
    }
    
    private func handleLongPressBegan() {
        guard !isPressed else {
            return
        }
        
        isPressed = true
        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0.2,
                       options: .beginFromCurrentState,
                       animations: {
                        self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }, completion: nil)
    }
    
    private func handleLongPressEnded() {
        guard isPressed else {
            return
        }
        
        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       usingSpringWithDamping: 0.4,
                       initialSpringVelocity: 0.2,
                       options: .beginFromCurrentState,
                       animations: {
                        self.transform = CGAffineTransform.identity
        }) { (finished) in
            self.isPressed = false
        }
    }
}
