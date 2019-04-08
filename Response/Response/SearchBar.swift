//
//  SearchBar.swift
//  Response
//
//  Created by Elmer Astudillo on 2/2/18.
//  Copyright © 2018 Keivan Shahida. All rights reserved.
//

import Foundation
import UIKit

struct SearchBar
{
    static func createSearchBar() -> UISearchBar
    {
        let searchBar = UISearchBar()
        searchBar.showsCancelButton = false
        searchBar.placeholder = "Search"
        let searchbarColor = UIColor(red: 216, green: 216, blue: 216, alpha: 0.05)
        searchBar.changeSearchBarColor(textFieldColor: searchbarColor)
        
        
        let tfInSearchbar = searchBar.value(forKey: "searchField") as? UITextField
        tfInSearchbar?.textColor = UIColor.white
        tfInSearchbar?.font = ._16ProximaRegular
//        searchBar.setImage(UIImage(named:"Home"), for: UISearchBarIcon.bookmark, state: .normal)
        return searchBar
    }
}

extension UISearchBar {
    // Change color of textfield by iterating through subviews
    func changeSearchBarColor(textFieldColor : UIColor) {
        for subView in self.subviews {
            for subSubView in subView.subviews {
                if let _ = subSubView as? UITextInputTraits {
                    let textField = subSubView as! UITextField
                    textField.backgroundColor = textFieldColor
                    break
                }
                
            }
        }
    }
}
