//
//  SortingLauncher.swift
//  TestProjectSpaceoByKurilov
//
//  Created by Pavel Kurilov on 29.05.2018.
//  Copyright © 2018 Pavel Kurilov. All rights reserved.
//

import UIKit

class Sorting: NSObject {
    let name: SortingName
    let imageView: String
    init(name: SortingName, imageView: String) {
        self.name = name
        self.imageView = imageView
    }
}

enum SortingName: String {
    case deffault = "Sort by deffault"
    case name = "Sort by name"
    case date = "Sort by date"
}

class SortingLauncher: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    override init() {
        super.init()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(SortingCell.self, forCellWithReuseIdentifier: cellID)
    }
    
    //MARK: - Property
    private let shadowView = UIView()
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    private let cellID = "cellID"
    private let sortings: [Sorting] = {
        return [ Sorting(name: .deffault, imageView: "default-icon"), Sorting(name: .name, imageView: "nameSorted-icon"), Sorting(name: .date, imageView: "dateSorted-icon")]
    }()
    var recipesListController: RecipesListController?
    
    //MARK: - Methods
    func showSortingVariation() {
        
        if let window = UIApplication.shared.keyWindow {
            shadowView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            
            shadowView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDissMiss)))
            
            window.addSubview(shadowView)
            window.addSubview(collectionView)
            
            let height: CGFloat = 150.0
            let y = window.frame.height - height
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            
            shadowView.frame = CGRect(x: 0, y: 0, width: window.frame.width, height: window.frame.height)
            shadowView.alpha = 0
            collectionView.alpha = 1
            
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.shadowView.alpha = 1
                
                self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: height)
            }, completion: nil)
        }
    }
    
    //MARK: - selectors
    @objc private func handleDissMiss() {
        UIView.animate(withDuration: 1) {
            self.shadowView.alpha = 0
            
            if let window = UIApplication.shared.keyWindow {
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height,
                                                   width: window.frame.width,
                                                   height: window.frame.height)
            }
            self.collectionView.alpha = 0
        }
    }
    
    //MARK: - DELEGATES And DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sortings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! SortingCell
        
        let sortByDeffualt = sortings[indexPath.item]
        cell.sorting = sortByDeffualt
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.shadowView.alpha = 0
            
            if let window = UIApplication.shared.keyWindow {
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height,
                                                   width: window.frame.width,
                                                   height: window.frame.height)
            }
            self.collectionView.alpha = 0
        }) { (completed: Bool) in
            
            let sortred = self.sortings[indexPath.item]
            self.recipesListController?.showControllesForSorted(sorted: sortred)
        }
    }
}
