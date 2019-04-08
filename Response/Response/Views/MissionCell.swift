//
//  MissionTableViewCell.swift
//  Response
//
//  Created by Elmer Astudillo on 2/15/18.
//  Copyright © 2018 Keivan Shahida. All rights reserved.
//

import Alamofire
import AlamofireImage
import UIKit

protocol MissionDelegate {
    func respond(mission: Mission)
    func share(mission : Mission)
    func viewMissionOrganization(organization: Organization)
}

class MissionCell: UITableViewCell {
    
    // MARK: - INITIALIZATION
    var missionDelegate : MissionDelegate!
    
    private var longPressGestureRecognizer: UILongPressGestureRecognizer? = nil
    private var isPressed: Bool = false
    
    var mission : Mission?
    var organization : Organization?
    
    var titleLabel = UILabel()
    var locationLabel = UILabel()
    var descriptionLabel = UILabel()
    var categoryLabel = UILabel()
    var dateStartedLabel = UILabel()
    
    var orgOneButton = UIButton()
    var orgTwoButton = UIButton()
    var orgThreeButton = UIButton()
    var responsesButton = ResponseButton(frame: .zero, backgroundColor: .responseRed, title: "2.2K")
    var shareButton = UIButton()
    
    var detailsStackView = UIStackView()
    var orgButtonsStackView = UIStackView()
    
    var cellCard = UIImageView()
    
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
        
        cellCard = UIImageView(frame:(CGRect(x: 0, y: 0, width:0, height: 470)))
        cellCard.layer.cornerRadius = 15
        cellCard.clipsToBounds = true
        cellCard.contentMode = .scaleAspectFill
        //      guard let logoURL = URL(string: mission?.logoImageURL ?? "Empty") else { return }
        let url = URL(string: "https://donate.unicef.org/sites/default/files/styles/1200x800/public/donation-campaign/donate/Hurricane-Matthew_form3_0.jpeg?itok=FE-EddfY")
//        Alamofire.request(url!).responseImage { response in
//            if let image = response.result.value {
//                print("image downloaded: \(image)")
//                self.cellCard.image = image
//            }
//        }
        print(mission?.thumbnailImageURL)
        
        cellCard.image = UIImage(named: (mission?.thumbnailImageURL)!)
        cellCard.isUserInteractionEnabled = true
        self.contentView.addSubview(cellCard)
        
        let cellRect = cellCard.bounds
        let coverView = UIView(frame: cellRect)
        coverView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        cellCard.addSubview(coverView)
        
        titleLabel = UILabel(frame: .zero)
        titleLabel.clipsToBounds = false
        titleLabel.textColor = .white
        titleLabel.attributedText = AttributedStringHelper.attributedStringWithLineSpacing(text: (mission?.name.uppercased())!, lineSpacing: 0.0, lineHeightMultiple: 0.8)
        titleLabel.textAlignment = .left
        titleLabel.font = ._48ProximaBold
        //        titleLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        titleLabel.numberOfLines = 0
        //        titleLabel.line
        
        descriptionLabel = UILabel(frame: .zero)
        descriptionLabel.clipsToBounds = false
        descriptionLabel.textColor = .white
        descriptionLabel.text = mission?.mission
        descriptionLabel.textAlignment = .left
        descriptionLabel.font = ._12ProximaRegular
        
        locationLabel = UILabel(frame: .zero)
        locationLabel.clipsToBounds = false
        locationLabel.textColor = .white
        locationLabel.text = mission?.location.uppercased()
        locationLabel.textAlignment = .left
        locationLabel.font = ._12ProximaRegular
        locationLabel.alpha = 0.80
        
        categoryLabel = UILabel(frame: .zero)
        categoryLabel.clipsToBounds = false
        categoryLabel.textColor = .responseBlue
        categoryLabel.text = mission?.category.first?.key.uppercased()
        categoryLabel.textAlignment = .left
        categoryLabel.font = ._12ProximaBold
        
        dateStartedLabel = UILabel(frame: .zero)
        dateStartedLabel.clipsToBounds = false
        dateStartedLabel.textColor = .white
        dateStartedLabel.text = mission?.date.timeAgoDisplay()
        dateStartedLabel.textAlignment = .left
        dateStartedLabel.font = ._12ProximaRegular
        dateStartedLabel.alpha = 0.80
        
        let responseButtonFrame = CGRect(x: 0, y: 0, width: 35, height: 35)
        orgOneButton = OrganizationButton(frame: responseButtonFrame, organizationImage: UIImage(named:Organization.organizations[0].logoImageURL)!)
        orgOneButton.addTarget(self, action: #selector(MissionCell.viewMissionOrganization), for: .touchUpInside)
        orgTwoButton = OrganizationButton(frame: responseButtonFrame, organizationImage: UIImage(named:Organization.organizations[0].logoImageURL)!)
        orgTwoButton.addTarget(self, action: #selector(MissionCell.viewMissionOrganization), for: .touchUpInside)
        orgThreeButton = OrganizationButton(frame: responseButtonFrame, organizationImage: UIImage(named:Organization.organizations[0].logoImageURL)!)
        orgThreeButton.addTarget(self, action: #selector(MissionCell.viewMissionOrganization), for: .touchUpInside)
        
        responsesButton = ResponseButton(frame: CGRect(x: 0, y: 0, width: 140.0, height: 35.0), backgroundColor: .responseRed, title: "\(mission?.responses ?? 100) RESPONSES", image: #imageLiteral(resourceName: "responseLogo"), inset: 10)
        responsesButton.addTarget(self, action: #selector(respond), for: .touchUpInside)
        
        shareButton = UIButton(type: .custom)
        let shareImage = UIImage(named: "Share")
        shareButton.setBackgroundImage(shareImage, for: .normal)
        shareButton.addTarget(self, action: #selector(share), for: .touchUpInside)
        
        detailsStackView = UIStackView(arrangedSubviews: [categoryLabel, dateStartedLabel])
        detailsStackView.axis = UILayoutConstraintAxis.horizontal
        detailsStackView.distribution = UIStackViewDistribution.equalSpacing
        detailsStackView.alignment = UIStackViewAlignment.center
        detailsStackView.translatesAutoresizingMaskIntoConstraints = false
        detailsStackView.spacing = 5
        
        orgButtonsStackView = UIStackView(arrangedSubviews: [orgOneButton, orgTwoButton, orgThreeButton])
        orgButtonsStackView.axis = UILayoutConstraintAxis.horizontal
        orgButtonsStackView.distribution = UIStackViewDistribution.equalSpacing
        orgButtonsStackView.alignment = UIStackViewAlignment.center
        orgButtonsStackView.translatesAutoresizingMaskIntoConstraints = false
        orgButtonsStackView.spacing = 5
        
        cellCard.addSubview(titleLabel)
        cellCard.addSubview(descriptionLabel)
        cellCard.addSubview(locationLabel)
        cellCard.addSubview(shareButton)
        cellCard.addSubview(detailsStackView)
        cellCard.addSubview(orgButtonsStackView)
        cellCard.addSubview(responsesButton)
        
        setUpContstraints()
    }
    
    // MARK: - CONSTRAINTS
    func setUpContstraints(){
        cellCard.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        
        detailsStackView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(30)
            make.left.equalToSuperview().offset(20)
        }
        
        orgButtonsStackView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-15)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(detailsStackView.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(20)
            make.width.equalTo(213)
        }
        
        locationLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(-5)
            make.left.equalToSuperview().offset(20)
        }
        
        descriptionLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(20)
            make.bottom.equalTo(orgButtonsStackView.snp.top).offset(-28)
        }
        
        responsesButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-15)
            make.width.equalTo(140)
            make.height.equalTo(35)
        }
        
        shareButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.width.equalTo(33)
            make.height.equalTo(30)
        }
        
        orgOneButton.snp.makeConstraints { (make) in
            make.width.equalTo(35)
            make.height.equalTo(35)
        }
        
        orgTwoButton.snp.makeConstraints { (make) in
            make.width.equalTo(35)
            make.height.equalTo(35)
        }
        
        orgThreeButton.snp.makeConstraints { (make) in
            make.width.equalTo(35)
            make.height.equalTo(35)
        }
        
        configureGestureRecognizer()
    }
    
    // MARK: - MISSION DELEGATE
    @objc func respond() {
        guard let mission = self.mission else { return }
        missionDelegate.respond(mission: mission)
    }
    
    @objc func share() {
        guard let mission = self.mission else { return }
        missionDelegate.share(mission: mission)
    }
    
    @objc func viewMissionOrganization() {
        print("button was pressed")
        guard let organization = self.organization else { return }
        missionDelegate.viewMissionOrganization(organization: organization)
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
