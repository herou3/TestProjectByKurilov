//
//  ViewController.swift
//  TestProjectSpaceoByKurilov
//
//  Created by Pavel Kurilov on 15.05.2018.
//  Copyright © 2018 Pavel Kurilov. All rights reserved.
//

import UIKit

class RecipesListController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var recipes: [Recipe] = {
       var sushiRecipe = Recipe()
        sushiRecipe.name = "Суши филадельфия"
        sushiRecipe.image = "sushi-minsk"
        sushiRecipe.descriptionDetail = "Суши обернутые лососем, внутри - рис, творожный сыр, огурец и авакадо. Подаются прохладными. Являются востребованным блюдом во всех японских ресторанах"
        sushiRecipe.difficult = 5
        sushiRecipe.uuid = "14j124k214kj"
        sushiRecipe.images = ["214124124jkj", "kjnj2nk34k2"]
        sushiRecipe.lastUpdated = 863003
        sushiRecipe.instructions = "sdgsdgjlglsjdgjlskdg"
        
        var pizzaRecipe = Recipe()
        pizzaRecipe.name = "Итальянская пицца"
        pizzaRecipe.image = "pizza"
        pizzaRecipe.descriptionDetail = "Итальянская пицца содержащия в себе натуральный продукт"
        pizzaRecipe.difficult = 3
        pizzaRecipe.uuid = "4583958juhg8"
        pizzaRecipe.images = ["214124124jkj", "kjnj2nk34k2"]
        pizzaRecipe.lastUpdated = 863003
        pizzaRecipe.instructions = "sdgsdgjlglsjdgjlskdg"
        
        
        return [sushiRecipe, pizzaRecipe]
    }()
    
    private let cellCollectionViewID = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Recipes List"
        navigationController?.navigationBar.isTranslucent = false
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "Recipes List"
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.textColor = UIColor.white
        navigationItem.titleView = titleLabel
        
        collectionView?.backgroundColor = UIColor.white
        collectionView!.register(RecipeCell.self, forCellWithReuseIdentifier: cellCollectionViewID)
        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
        
        configureView()
    }

    //MARK: - Configurate Views
    private func configureView() {
        addSortedMenuBar()
        addNavBarButtons()
    }
    
    private func addNavBarButtons() {
        let searchImage = UIImage(named: "search-icon")?.withRenderingMode(.alwaysOriginal)
        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        navigationItem.rightBarButtonItem = searchBarButtonItem
    }
    
    private func addSortedMenuBar() {
        let menuBar: SortedMenuBar = {
            let mb = SortedMenuBar()
            mb.translatesAutoresizingMaskIntoConstraints = false
            return mb
        }()
        view.addSubview(menuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(format: "V:|[v0(50)]", views: menuBar)
    }
    
    //MARK: - Selectors
    @objc private func handleSearch() {
        print("HO HO HO")
    }
    
    
    //MARK: - DELEGATE
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellCollectionViewID, for: indexPath) as! RecipeCell
        
        cell.recipe = recipes[indexPath.item]

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.width - 16 - 16) * 9 / 16
        return CGSize(width: self.view.frame.width, height: height + 16 + 68)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}











