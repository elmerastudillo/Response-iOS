//
//  CauseTableViewCell.swift
//  Response
//
//  Created by Elmer Astudillo on 2/24/18.
//  Copyright © 2018 Keivan Shahida. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

protocol CauseDelegate {
    func respond(cause: Cause)
    func viewCauseOrganization(organization: Organization)
    func share(cause : Cause)
}

class CauseCell : UITableViewCell {

    // MARK: - INITIALIZATION

    var causeDelegate : CauseDelegate!

    private var longPressGestureRecognizer: UILongPressGestureRecognizer? = nil
    private var isPressed: Bool = false
    
    var cause: Cause?
    var organization : Organization?
    var response: Response?
    
    var titleLabel = UILabel()
    var locationLabel = UILabel()
    var subtitleLabel = UILabel()
    var categoryLabel = UILabel()
    var dateStartedLabel = UILabel()
    
    var responseButton = UIButton()
    var charityButton = UIButton()
    var shareButton = UIButton()
    
    var cellCard: UIImageView!
    
    var detailStackView: UIStackView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.contentView.backgroundColor = .responseBlack
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LAYOUT
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        cellCard = UIImageView()
        cellCard.layer.cornerRadius = 15
        cellCard.clipsToBounds = true
        cellCard.image = cause?.image
        cellCard.contentMode = .scaleAspectFill
        cellCard.isUserInteractionEnabled = true
        self.contentView.addSubview(cellCard)
    
        let cellRect = cellCard.bounds
        let coverView = UIView(frame: cellRect)
        coverView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        cellCard.addSubview(coverView)
        
        titleLabel = UILabel(frame: .zero)
        titleLabel.clipsToBounds = false
        titleLabel.textColor = .white
        titleLabel.text = cause?.title
        titleLabel.textAlignment = .left
        titleLabel.font = ._22ProximaBold
        
        locationLabel = UILabel(frame: .zero)
        locationLabel.clipsToBounds = false
        locationLabel.textColor = .white
        locationLabel.text = cause?.location.uppercased()
        locationLabel.textAlignment = .left
        locationLabel.font = ._12ProximaRegular
        locationLabel.alpha = 0.80
    
        categoryLabel = UILabel(frame: .zero)
        categoryLabel.clipsToBounds = false
        categoryLabel.textColor = .responseBlue
        categoryLabel.text = cause?.category.first?.key.uppercased()
        categoryLabel.textAlignment = .left
        categoryLabel.font = ._12ProximaRegular
        
        dateStartedLabel = UILabel(frame: .zero)
        dateStartedLabel.clipsToBounds = false
        dateStartedLabel.textColor = .white
        dateStartedLabel.text = cause?.dateStarted.timeAgoDisplay()
        dateStartedLabel.textAlignment = .left
        dateStartedLabel.font = ._12ProximaRegular
        dateStartedLabel.alpha = 0.90
        
        detailStackView = UIStackView(arrangedSubviews: [categoryLabel, dateStartedLabel])
        detailStackView.axis = UILayoutConstraintAxis.horizontal
        detailStackView.distribution = UIStackViewDistribution.equalSpacing
        detailStackView.alignment = UIStackViewAlignment.center
        detailStackView.translatesAutoresizingMaskIntoConstraints = false
        detailStackView.spacing = 5
        
        responseButton = ResponseButton(frame: .zero, backgroundColor: .responseRed, title: "2.2K", image: #imageLiteral(resourceName: "responseLogo"), inset: 5)
        responseButton.addTarget(self, action: #selector(respond), for: .touchUpInside)
        responseButton.isUserInteractionEnabled = true
        
        charityButton = OrganizationButton(frame: .zero, organizationImage: UIImage(named:Organization.organizations[0].logoImageURL)!)
        charityButton.addTarget(self, action: #selector(CauseCell.viewCauseOrganization), for: .touchUpInside)
        charityButton.isUserInteractionEnabled = true
        
        shareButton = UIButton(type: .custom)
        let shareImage = UIImage(named: "Share")
        shareButton.setBackgroundImage(shareImage, for: .normal)
        shareButton.addTarget(self, action: #selector(share), for: .touchUpInside)
        shareButton.isUserInteractionEnabled = true
    
        cellCard.addSubview(titleLabel)
        cellCard.addSubview(locationLabel)
        cellCard.addSubview(responseButton)
        cellCard.addSubview(charityButton)
        cellCard.addSubview(detailStackView)
        cellCard.addSubview(shareButton)
        setConstraints()
    }
    
    // MARK: - CONSTRAINTS
    func setConstraints() {
        cellCard.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        
        detailStackView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(17)
            make.left.equalToSuperview().offset(16)
        }
        
        titleLabel.snp.makeConstraints{ (make) -> Void in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-61)
            make.top.equalTo(detailStackView.snp.bottom).offset(5)
        }
        
        locationLabel.snp.makeConstraints{ (make) -> Void in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
        }
        
        responseButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-15)
            make.height.equalTo(35)
            make.width.equalTo(70)
        }
        
        charityButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-15)
            make.width.equalTo(35)
            make.height.equalTo(35)
        }
        
        shareButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(30)
            make.width.equalTo(33)
        }
        
        configureGestureRecognizer()
    }
    
    // MARK: - CAUSE DELEGATE
    @objc func respond() {
        guard let cause = self.cause else { return }
        causeDelegate.respond(cause: cause)
    }
    
    @objc func viewCauseOrganization() {
        guard let organization = self.organization else { return }
        causeDelegate.viewCauseOrganization(organization: organization)
    }
    
    @objc func share() {
        guard let cause = self.cause else { return }
        causeDelegate.share(cause: cause)
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
