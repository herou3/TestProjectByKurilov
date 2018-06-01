//
//  SearchingLauncher.swift
//  TestProjectSpaceoByKurilov
//
//  Created by Pavel Kurilov on 30.05.2018.
//  Copyright © 2018 Pavel Kurilov. All rights reserved.
//

import UIKit

class SearchingLauncher: NSObject {
    
    override init() {
        super.init()
        searchBar.delegate = self
    }
    
    //MARK: - Property
    var searchBar: UISearchBar = {
       var sb = UISearchBar(frame: .zero)
        sb.setStyleColor(UIColor.rgb(65,155,65))
        return sb
    }()
    var changeData = {() -> () in }
    var searchingText: String? = ""  {
        didSet {
            changeData()
        }
    }
    
    //MARK: - Method
    func showSearchingBar() {
         if let window = UIApplication.shared.keyWindow {
            window.addSubview(searchBar)
            
            let height: CGFloat = 64
            searchBar.frame = CGRect(x: 0, y: 0, width: window.frame.width, height: height)
            
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                self.searchBar.frame = CGRect(x: 0, y: height, width: self.searchBar.frame.width, height: height)
            }, completion: nil)
        }
    }
}

//MARK: - DELEGATE
extension SearchingLauncher: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchingText = searchText
        print(searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}
