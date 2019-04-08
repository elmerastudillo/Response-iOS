//
//  ShareViewController.swift
//  Response
//
//  Created by Keivan Shahida on 4/8/18.
//  Copyright © 2018 Keivan Shahida. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class ShareViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView!
    
    var headerImageView: UIImageView!
    var headerLabel: UILabel!
    var backButton: UIButton!
    
    var shareTitle: String!
    var shareImage: UIImage!
    
    var items: [String] = ["Messages", "WhatsApp", "Messenger", "Twitter", "Copy Link", "More"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.backgroundColor = UIColor.responseBlack
        

        
        layoutViews()
        setConstraints()
    }
    
    // MARK: - LAYOUT
    func layoutViews() {
        
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.bounces = false
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .responseBlack
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ShareCell.self, forCellReuseIdentifier: "shareCell")
        view.addSubview(tableView)
        
        headerImageView = UIImageView()
        
        let url = URL(string: "https://donate.unicef.org/sites/default/files/styles/1200x800/public/donation-campaign/donate/Hurricane-Matthew_form3_0.jpeg?itok=FE-EddfY") //TEMP
        Alamofire.request(url!).responseImage { response in
            if let image = response.result.value {
                self.shareImage = image
                self.headerImageView.image = self.shareImage.applyBlurEffect()
            }
        }
        
        headerImageView.contentMode = .scaleAspectFill
        headerImageView.clipsToBounds = true
        view.addSubview(headerImageView)
        
        headerLabel = UILabel(frame: .zero)
        headerLabel.clipsToBounds = false
        headerLabel.textColor = .white
        headerLabel.text = "SHARE"
        headerLabel.textAlignment = .center
        headerLabel.font = ._36ProximaBold
        headerLabel.numberOfLines = 0
        view.addSubview(headerLabel)
        
        backButton = UIButton(type: .custom)
        let backImage = UIImage(named: "Back")
        backButton.setBackgroundImage(backImage, for: .normal)
        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        view.addSubview(backButton)
    }
    
    // MARK: - LAYOUT
    func setConstraints() {
        tableView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview().offset(200)
            make.bottom.equalToSuperview()
        }
        
        headerImageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(-50)
            make.right.equalToSuperview().offset(50)
            make.bottom.equalTo(tableView.snp.top)
            make.top.equalToSuperview()
        }
        
        headerLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(0)
            make.centerY.equalTo(headerImageView).offset(20)
        }
        
        backButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(50)
        }
    }
    
    // MARK: - CELLS
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shareCell", for: indexPath) as! ShareCell
        cell.title = items[indexPath.row]
        return cell
    }
    
    // MARK: - BACK
    
    @objc func back(){
        self.dismiss(animated: true, completion: nil)
    }
}
