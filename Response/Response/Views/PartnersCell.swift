//
//  PartnersTableViewCell.swift
//  Response
//
//  Created by Elmer Astudillo on 2/27/18.
//  Copyright © 2018 Keivan Shahida. All rights reserved.
//

import Foundation
import UIKit

class PartnersCell: UITableViewCell, UICollectionViewDataSource {
    
    //MARK: - INITIALIZATION
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.contentView.backgroundColor = UIColor.responseBlack
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LAYOUT
    override func layoutSubviews() {
        let collectionView = UICollectionView(frame: self.contentView.frame, collectionViewLayout: createLayout())
        collectionView.backgroundColor = .responseBlack
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        self.contentView.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.register(OrganizationIconCell.self, forCellWithReuseIdentifier: "OrganizationRoundCell")
    }
    
    //MARK: - HELPERS
    func createLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 80, height: 80)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 15
        return layout
    }
    
    // MARK: - CELLS
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OrganizationRoundCell", for: indexPath) as! OrganizationIconCell
        /*
         It's called doge.jpeg since I added an image of Shiba Inu in the project assets folder. You would import some information from a REST API or similar
         */
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //You would get something like "model.count" here. It would depend on your data source
        return 5
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
}
