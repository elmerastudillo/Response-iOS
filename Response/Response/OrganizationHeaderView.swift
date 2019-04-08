//
//  OrgProfileHeaderView.swift
//  Response
//
//  Created by Elmer Astudillo on 12/10/17.
//  Copyright © 2017 Keivan Shahida. All rights reserved.
//

import UIKit

protocol OrganizationProfileDelegate {
    func follow()
    func donate(organization: Organization)
    func back()
    func share()
}

class OrganizationHeaderView: UIView, UIScrollViewDelegate {
    
    var organizationProfileDelegate: OrganizationProfileDelegate!
    var organization: Organization!
    
    var containerView: UIImageView!
    var coverView: UIView!
    
    var titleLabel: UILabel!
    var missionLabel: UILabel!
    var descriptionLabel: UILabel!
    
    var organizationImageView: UIImageView!
    
    var causesLabel: UILabel!
    var responsesLabel: UILabel!
    var categoryLabel: UILabel!
    var followersTotalLabel: UILabel!
    var responsesTotalLabel: UILabel!
    
    var followButton: ResponseButton!
    var donateButton: ResponseButton!
    
    var backButton: UIButton!
    var shareButton: UIButton!
    
    var scrollView: UIScrollView!
    var pageControl: UIPageControl!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .responseBlack
        layoutNewSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LAYOUT
    func layoutNewSubviews() {
        
        let screenSize = UIScreen.main.bounds
        let containerViewFrame = CGRect(x: 0, y: 0, width: screenSize.width, height: 420)
        containerView = UIImageView(frame: containerViewFrame)
        containerView.clipsToBounds = true
        containerView.contentMode = .scaleAspectFill
        containerView.isUserInteractionEnabled = true
        
        coverView = UIView(frame: containerViewFrame)
        coverView.isUserInteractionEnabled = true
        
        titleLabel = UILabel(frame: CGRect(x: 20, y: 130, width: 180, height: 29))
        titleLabel.text = "UNICEF"
        titleLabel.textColor = .white
        titleLabel.font = UIFont(name: "ProximaNova-Bold", size: 24.0)
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 0
        titleLabel.sizeToFit()
        
        missionLabel = UILabel(frame: CGRect(x: 20, y: 130, width: 180, height: 29))
        missionLabel.text = "Provide food, shelter, and safety for refugees around the world."
        missionLabel.textColor = .white
        missionLabel.font = UIFont(name: "ProximaNova-Regular", size: 14.0)
        missionLabel.textAlignment = NSTextAlignment.center
        missionLabel.translatesAutoresizingMaskIntoConstraints = false
        missionLabel.alpha = 0.75
        missionLabel.numberOfLines = 0
        missionLabel.sizeToFit()
        
        descriptionLabel = UILabel(frame: CGRect(x: 20, y: 130, width: 180, height: 29))
        descriptionLabel.text = "Provide food, shelter, and safety for refugees around the world. Provide food, shelter, and safety for refugees around the world. Provide food, shelter, and safety for refugees around the world. Provide food, shelter, and safety for refugees around the world. Provide food, shelter, and safety for refugees around the world."
        descriptionLabel.textColor = .white
        descriptionLabel.font = UIFont(name: "ProximaNova-Regular", size: 12.0)
        descriptionLabel.textAlignment = NSTextAlignment.left
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.numberOfLines = 0
        descriptionLabel.sizeToFit()
        
        organizationImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 75.0, height: 75.0))
        organizationImageView.image = UIImage(named: "unicef-logo-square")
        organizationImageView.layer.cornerRadius = organizationImageView.frame.width / 2
        organizationImageView.layer.masksToBounds = true
        
        causesLabel = UILabel(frame: CGRect(x: 20, y: 130, width: 180, height: 29))
        causesLabel.text = "12 CAUSES"
        causesLabel.textColor = .white
        causesLabel.font = ._18ProximaBold
        causesLabel.textAlignment = NSTextAlignment.center
        causesLabel.translatesAutoresizingMaskIntoConstraints = false
        
        responsesLabel = UILabel(frame: CGRect(x: 20, y: 130, width: 180, height: 29))
        responsesLabel.text = "12,341,075 RESPONSES"
        responsesLabel.textColor = .white
        responsesLabel.font = ._18ProximaBold
        responsesLabel.textAlignment = NSTextAlignment.center
        responsesLabel.translatesAutoresizingMaskIntoConstraints = false
        
        categoryLabel = UILabel(frame: CGRect(x: 20, y: 130, width: 180, height: 29))
        categoryLabel.text = "DEVELOPMENT"
        categoryLabel.textColor = .responseBlue
        categoryLabel.font = ._12ProximaBold
        categoryLabel.textAlignment = NSTextAlignment.center
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        followersTotalLabel = UILabel(frame: CGRect(x: 20, y: 130, width: 180, height: 29))
        followersTotalLabel.text = "1,700,351 FOLLOWERS"
        followersTotalLabel.textColor = .white
        followersTotalLabel.font = ._10ProximaBold
        followersTotalLabel.textAlignment = NSTextAlignment.center
        followersTotalLabel.translatesAutoresizingMaskIntoConstraints = false
        followersTotalLabel.alpha = 0.80
        
        responsesTotalLabel = UILabel(frame: CGRect(x: 20, y: 130, width: 180, height: 29))
        responsesTotalLabel.text = "1,700,351 RESPONSES"
        responsesTotalLabel.textColor = .white
        responsesTotalLabel.font = ._10ProximaBold
        responsesTotalLabel.textAlignment = NSTextAlignment.center
        responsesTotalLabel.translatesAutoresizingMaskIntoConstraints = false
        responsesTotalLabel.alpha = 0.80
        
        followButton = ResponseButton(frame: CGRect(x: 0, y: 0, width: 120.0, height: 35.0), backgroundColor: .responseBlue, title: "FOLLOW")
        followButton.addTarget(self, action: #selector(follow), for: .touchUpInside)
        
        donateButton = ResponseButton(frame: CGRect(x: 0, y: 0, width: 120.0, height: 35.0), backgroundColor: .responseRed, title: "DONATE")
        donateButton.addTarget(self, action: #selector(donate), for: .touchUpInside)
        
        backButton = UIButton(type: .custom)
        let backImage = UIImage(named: "Back")
        backButton.setBackgroundImage(backImage, for: .normal)
        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        
        shareButton = UIButton(type: .custom)
        let shareImage = UIImage(named: "Share")
        shareButton.setBackgroundImage(shareImage, for: .normal)
        shareButton.addTarget(self, action: #selector(share), for: .touchUpInside)
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: 300.0, height: 500.0))
        scrollView.contentSize = CGSize(width: (scrollView.frame.width * 3), height: 300)
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        
        pageControl = UIPageControl(frame: CGRect(x: 0, y: 0, width: 300, height: 10))
        pageControl.numberOfPages = 3
        pageControl.currentPage = 0
        
        containerView.addSubview(coverView)
        containerView.addSubview(pageControl)
        containerView.addSubview(scrollView)
        containerView.addSubview(followButton)
        containerView.addSubview(donateButton)
        containerView.addSubview(followersTotalLabel)
        containerView.addSubview(responsesTotalLabel)
        containerView.addSubview(backButton)
        containerView.addSubview(shareButton)
        self.addSubview(containerView)
        setContstraints()
        setGradient()
        setUpPageControl()
    }
    
    // MARK: - CONSTRAINTS
    func setContstraints(){
        containerView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(420)
        }
        
        coverView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalTo(containerView)
            make.width.equalTo(300)
            make.height.equalTo(300)
        }
        
        shareButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(50)
            make.right.equalToSuperview().offset(-20)
        }
        
        pageControl.snp.makeConstraints { (make) in
            make.top.equalTo(scrollView.snp.bottom).offset(10)
            make.centerX.equalTo(scrollView)
        }
        
        followButton.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-20)
            make.left.equalToSuperview().offset(60)
            make.width.equalTo(120)
            make.height.equalTo(35)
        }
        
        donateButton.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-20)
            make.right.equalToSuperview().offset(-60)
            make.width.equalTo(120)
            make.height.equalTo(35)
        }
        
        followersTotalLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(followButton)
            make.top.equalTo(followButton.snp.bottom).offset(10)
        }
        
        responsesTotalLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(donateButton)
            make.top.equalTo(donateButton.snp.bottom).offset(10)
        }
        
        backButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(50)
        }
    }
    
    // MARK: - PAGE CONTROL
    
    func setUpPageControl() {
        for i in 0...2 {
            let imgView = UIImageView.init()
            imgView.frame = CGRect(x: scrollView.frame.width * CGFloat (i), y: 0, width: 300.0, height: 300.0)
            // imgView.backgroundColor = UIColor.clear
            
            switch(i){
            case 0:
                imgView.addSubview(causesLabel)
                imgView.addSubview(responsesLabel)
                imgView.addSubview(categoryLabel)
                imgView.backgroundColor = UIColor.clear
                causesLabel.snp.makeConstraints({ (make) in
                    make.centerX.equalToSuperview()
                    make.centerY.equalToSuperview()
                })
                responsesLabel.snp.makeConstraints({ (make) in
                    make.centerX.equalToSuperview()
                    make.top.equalTo(causesLabel).offset(25)
                })
                
                categoryLabel.snp.makeConstraints({ (make) in
                    make.centerX.equalToSuperview()
                    make.top.equalTo(responsesLabel).offset(25)
                    
                })
            case 1:
                imgView.backgroundColor = UIColor.clear
                imgView.addSubview(titleLabel)
                imgView.addSubview(missionLabel)
                imgView.addSubview(organizationImageView)
                organizationImageView.snp.makeConstraints({ (make) in
                    make.centerX.equalToSuperview()
                    make.top.equalToSuperview().offset(100)
                    make.width.equalTo(75)
                    make.height.equalTo(75)
                })
                titleLabel.snp.makeConstraints({ (make) in
                    make.centerX.equalToSuperview()
                    make.top.equalTo(organizationImageView.snp.bottom).offset(10)
                    make.width.equalTo(180)
                })
                missionLabel.snp.makeConstraints({ (make) in
                    make.top.equalTo(titleLabel.snp.bottom).offset(10)
                    make.centerX.equalToSuperview()
                    make.width.equalTo(200)
                })
            case 2:
                imgView.backgroundColor = UIColor.clear
                imgView.addSubview(descriptionLabel)
                descriptionLabel.snp.makeConstraints({ (make) in
                    make.centerX.equalToSuperview()
                    make.centerY.equalToSuperview()
                    make.width.equalTo(250)
                })
            default:
                print("default")
            }
            scrollView.addSubview(imgView)
        }
        pageControl.addTarget(self, action: #selector(changePage), for: UIControlEvents.valueChanged)
        scrollView.scrollRectToVisible(CGRect(x: 300, y: 0, width: 300, height: 300), animated: false)
        pageControl.currentPage = 1
    }
    
    @objc func changePage() {
        scrollView.scrollRectToVisible(CGRect(x: 300 * CGFloat(pageControl.currentPage), y: 0, width: 300, height: 300), animated: true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }
    
    func gradientLayer(frame: CGRect) -> CAGradientLayer {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = frame
        gradient.colors = [UIColor.clear.cgColor, UIColor.responseBlack.cgColor]
        gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        return gradient
    }
    
    func setGradient() {
        let layer = gradientLayer(frame: self.containerView.bounds)
        coverView.layer.insertSublayer(layer, at: 0)
    }
    
    // MARK: - OrganizationProfileDelegate
    @objc func follow() {
        organizationProfileDelegate.follow()
    }
    
    @objc func donate() {
        guard let organization = self.organization else { return }
        organizationProfileDelegate.donate(organization: organization)
    }
    
    @objc func back() {
        organizationProfileDelegate.back()
    }
    
    @objc func share() {
        organizationProfileDelegate.share()
    }
}
