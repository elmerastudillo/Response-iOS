//
//  RespondViewController.swift
//  Response
//
//  Created by Elmer Astudillo on 4/4/18.
//  Copyright © 2018 Keivan Shahida. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import Stripe

class RespondViewController: UIViewController {
    
    // MARK: - INITIALIZATION
    var cause: Cause?
    
    var organizationImage = UIImageView()
    var titleLabel = UILabel()
    var descriptionLabel = UILabel()
    var selectAmount = UILabel()
    var orLabel = UILabel()
    var responsesLabel = UILabel()
    var dollarAmountTextField = DollarAmountTextField(frame: CGRect(x: 0, y: 0, width: 315, height: 45))
    
    var donateOnceButton = RoundedRectangleButton(frame: CGRect(x: 0, y: 0, width: 315, height: 50), text: "Donate Once", backgroundColor: .responseRed, textColor: .white)
    var donateMonthlyButton = RoundedRectangleButton(frame: CGRect(x: 0, y: 0, width: 315, height: 45), text: "Donate Monthly", backgroundColor: .responseRed, textColor: .white)
    
    var detailStackView = UIStackView()
    var categoryLabel = UILabel()
    var dateStartedLabel = UILabel()
    
    var firstRowButtons = UIStackView()
    var fiveAmountButton = AmountButton(amount: "5", frame: CGRect(x: 0, y: 0, width: 100, height: 45))
    var tenAmountButton = AmountButton(amount: "10", frame: CGRect(x: 0, y: 0, width: 100, height: 45))
    var twentyFiveAmountButton = AmountButton(amount: "25", frame: CGRect(x: 0, y: 0, width: 100, height: 45))
    
    var secondRowButtons = UIStackView()
    var fiftyAmountButton = AmountButton(amount: "50", frame: CGRect(x: 0, y: 0, width: 100, height: 45))
    var hundredAmountButton = AmountButton(amount: "100", frame: CGRect(x: 0, y: 0, width: 100, height: 45))
    var twoHundredFiftyAmountButton = AmountButton(amount: "250", frame: CGRect(x: 0, y: 0, width: 100, height: 45))
    
    // Stripe
    var customerContext = STPCustomerContext()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .responseBlack
        
        let randomNum = arc4random_uniform(3)
        cause = Cause.causes[Int(randomNum)]
        
        prepareSwipes()
        layoutSubviews()
    }
    
    // MARK: - LAYOUT
    func layoutSubviews(){
        
        let imageFrame = CGRect(x: 0, y: 0, width: 50, height: 50)
        organizationImage = UIImageView(frame: imageFrame)
        organizationImage.contentMode = .scaleAspectFill
        organizationImage.image = UIImage(named: "unicef-logo-square")
        organizationImage.layer.cornerRadius = organizationImage.frame.width / 2
        organizationImage.layer.masksToBounds = false
        organizationImage.clipsToBounds = true
        organizationImage.backgroundColor = UIColor.responseBlack
        
        categoryLabel = UILabel(frame: .zero)
        categoryLabel.clipsToBounds = false
        categoryLabel.textColor = .responseBlue
        categoryLabel.text = cause?.category.first?.key.uppercased()
        categoryLabel.textAlignment = .left
        categoryLabel.font = UIFont(name: "ProximaNova-Regular", size: 12.0)
        categoryLabel.alpha = 0.90
        
        dateStartedLabel = UILabel(frame: .zero)
        dateStartedLabel.clipsToBounds = false
        dateStartedLabel.textColor = .white
        dateStartedLabel.text = cause?.dateStarted.timeAgoDisplay()
        dateStartedLabel.textAlignment = .left
        dateStartedLabel.font = UIFont(name: "ProximaNova-Regular", size: 12.0)
        dateStartedLabel.alpha = 0.90
        
        detailStackView = UIStackView(arrangedSubviews: [categoryLabel, dateStartedLabel])
        detailStackView.axis = UILayoutConstraintAxis.horizontal
        detailStackView.distribution = UIStackViewDistribution.equalSpacing
        detailStackView.alignment = UIStackViewAlignment.center
        detailStackView.translatesAutoresizingMaskIntoConstraints = false
        detailStackView.spacing = 5
        
        titleLabel = UILabel(frame: .zero)
        titleLabel.clipsToBounds = false
        titleLabel.textColor = .white
        titleLabel.text = cause?.title
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont(name: "ProximaNova-Bold", size: 18.0)
        
        responsesLabel = UILabel(frame: .zero)
        responsesLabel.clipsToBounds = false
        responsesLabel.textColor = .white
        // TODO: Set to grab data from Cause
        responsesLabel.text = "1,700,351 RESPONSES"
        responsesLabel.textAlignment = .center
        responsesLabel.font = UIFont(name: "ProximaNova-Bold", size: 10.0)
        responsesLabel.alpha = 0.80
        
        descriptionLabel = UILabel(frame: .zero)
        descriptionLabel.clipsToBounds = false
        descriptionLabel.textColor = .white
        descriptionLabel.text = cause?.description
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.numberOfLines = 0
        descriptionLabel.sizeToFit()
        descriptionLabel.alpha = 0.90
        descriptionLabel.font = UIFont(name: "ProximaNova-Regular", size: 12.0)
        
        selectAmount = UILabel(frame: .zero)
        selectAmount.clipsToBounds = false
        selectAmount.textColor = .white
        selectAmount.text = "Select Amount"
        selectAmount.textAlignment = .center
        selectAmount.font = UIFont(name: "ProximaNova-Bold", size: 18.0)
        
        orLabel = UILabel(frame: .zero)
        orLabel.clipsToBounds = false
        orLabel.textColor = .responseBlue
        orLabel.text = "OR"
        orLabel.textAlignment = .left
        orLabel.font = UIFont(name: "ProximaNova-Bold", size: 12.0)
        
        firstRowButtons = UIStackView(arrangedSubviews: [fiveAmountButton, tenAmountButton, twentyFiveAmountButton])
        firstRowButtons.axis = UILayoutConstraintAxis.horizontal
        firstRowButtons.distribution = UIStackViewDistribution.equalSpacing
        firstRowButtons.alignment = UIStackViewAlignment.center
        firstRowButtons.translatesAutoresizingMaskIntoConstraints = false
        firstRowButtons.spacing = 10
        
        secondRowButtons = UIStackView(arrangedSubviews: [fiftyAmountButton, hundredAmountButton, twoHundredFiftyAmountButton])
        secondRowButtons.axis = UILayoutConstraintAxis.horizontal
        secondRowButtons.distribution = UIStackViewDistribution.equalSpacing
        secondRowButtons.alignment = UIStackViewAlignment.center
        secondRowButtons.translatesAutoresizingMaskIntoConstraints = false
        secondRowButtons.spacing = 10
        
        donateOnceButton.addTarget(self, action: #selector(payments), for: .touchUpInside)
        donateMonthlyButton.addTarget(self, action: #selector(payments), for: .touchUpInside)
        
        view.addSubview(organizationImage)
        view.addSubview(detailStackView)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(selectAmount)
        view.addSubview(firstRowButtons)
        view.addSubview(secondRowButtons)
        view.addSubview(orLabel)
        view.addSubview(dollarAmountTextField)
        view.addSubview(donateOnceButton)
        view.addSubview(donateMonthlyButton)
        view.addSubview(responsesLabel)
        setConstaints()
    }
    
    @objc func payments() {
        if let text = dollarAmountTextField.text, !text.isEmpty {
            //do something if it's not empty
            let paymentContext = STPPaymentContext(customerContext: customerContext)
//            paymentContext.delegate = self
            paymentContext.hostViewController = self
            paymentContext.paymentAmount = Int(text)!
            
            let addCardViewController = STPAddCardViewController()
            addCardViewController.delegate = self
            let navigationController = UINavigationController(rootViewController: addCardViewController)
            navigationController.navigationBar.barTintColor = UIColor.white
            present(navigationController, animated: true, completion: nil)
//            paymentContext.presentPaymentMethodsViewController()
        }
        else {
            let alertController = UIAlertController(title: "Message", message: "Please select a dollar amount", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    // MARK: CONSTRAINTS
    func setConstaints() {        
        organizationImage.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(30)
            if #available(iOS 11.0, *) {
                make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
            } else {
                make.top.equalTo(topLayoutGuide.snp.bottom).offset(40)
            }
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        
        detailStackView.snp.makeConstraints { (make) in
            make.left.equalTo(organizationImage.snp.right).offset(10)
            if #available(iOS 11.0, *) {
                make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
            } else {
                make.top.equalTo(topLayoutGuide.snp.bottom).offset(40)
            }
            make.height.equalTo(15)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(organizationImage.snp.right).offset(10)
            make.top.equalTo(detailStackView.snp.bottom).offset(5)
            make.height.equalTo(22)
        }
        
        descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(organizationImage.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
        }
        
        selectAmount.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            // TODO: Need to fix spacing
            make.bottom.equalTo(firstRowButtons.snp.top).offset(-10)
            make.height.equalTo(60)
        }
        
        firstRowButtons.snp.makeConstraints { (make) in
            make.bottom.equalTo(secondRowButtons.snp.top).offset(-10)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            
        }
        
        secondRowButtons.snp.makeConstraints { (make) in
            make.bottom.equalTo(orLabel.snp.top).offset(-10)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
        }
        
        tenAmountButton.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.height.equalTo(45)
        }
        
        fiveAmountButton.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.height.equalTo(45)
        }
        
        twentyFiveAmountButton.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.height.equalTo(45)
        }
        
        fiftyAmountButton.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.height.equalTo(45)
        }
        
        hundredAmountButton.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.height.equalTo(45)
        }
        
        twoHundredFiftyAmountButton.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.height.equalTo(45)
        }
        
        orLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(dollarAmountTextField.snp.top).offset(-10)
            make.centerX.equalToSuperview()
        }
        
        dollarAmountTextField.snp.makeConstraints { (make) in
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.height.equalTo(45)
            make.bottom.equalTo(donateOnceButton.snp.top).offset(-30)
        }
        
        donateOnceButton.snp.makeConstraints { (make) in
            make.height.equalTo(50)
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.bottom.equalTo(donateMonthlyButton.snp.top).offset(-10)
        }
        
        donateMonthlyButton.snp.makeConstraints { (make) in
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.height.equalTo(50)
            make.bottom.equalTo(responsesLabel.snp.top).offset(-10)
        }
        
        responsesLabel.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-20)
            make.centerX.equalToSuperview()
        }
    }

    // MARK: - HELPERS
    
    func prepareSwipes() {
        let swipefromBottom = UISwipeGestureRecognizer(target: self, action: #selector(RespondViewController.downSwiping(_:)))
        swipefromBottom.direction = .down
        self.view.addGestureRecognizer(swipefromBottom)
    }
    
    @objc func downSwiping(_ gesture:UIGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension RespondViewController : STPAddCardViewControllerDelegate {
    func addCardViewControllerDidCancel(_ addCardViewController: STPAddCardViewController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
