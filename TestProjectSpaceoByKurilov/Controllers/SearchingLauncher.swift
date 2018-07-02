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
// MARK: - Property
    var searchBar: UISearchBar = {
        var search = UISearchBar(frame: .zero)
        search.setStyleColor(UIColor.searchBar)
        return search
    }()
    var changeSearchRequest = { () -> () in }
    var searchingText: String? = "" {
        didSet {
            changeSearchRequest()
        }
    }
// MARK: - Method
    func showSearchingBar() {
         if let window = UIApplication.shared.keyWindow {
            window.addSubview(searchBar)
            let height: CGFloat = 64
            searchBar.frame = CGRect(x: window.frame.minX,
                                     y: window.frame.minY,
                                     width: window.frame.width,
                                     height: height)
            UIView.animate(withDuration: 0.15,
                           delay: 0,
                           usingSpringWithDamping: window.frame.minX,
                           initialSpringVelocity: window.frame.minY,
                           options: .curveEaseOut,
                           animations: {
                self.searchBar.frame = CGRect(x: window.frame.minX,
                                              y: height,
                                              width: self.searchBar.frame.width,
                                              height: height)
            }, completion: nil)
        }
    }
}
// MARK: - DELEGATE
extension SearchingLauncher: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar,
                   textDidChange searchText: String) {
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
