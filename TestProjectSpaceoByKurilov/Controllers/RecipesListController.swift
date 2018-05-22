//
//  ViewController.swift
//  TestProjectSpaceoByKurilov
//
//  Created by Pavel Kurilov on 15.05.2018.
//  Copyright © 2018 Pavel Kurilov. All rights reserved.
//

import UIKit

class RecipesListController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    //MARK: - Property
    private var recipes: [Recipe]?
    private var deffualtArrayRecipe: [Recipe]?
    var recipe: Recipe?
    lazy var sortingLauncher: SortingLauncher = {
        let sorted = SortingLauncher()
        sorted.recipesListController = self
        return sorted
    }()
    private let cellCollectionViewID = "cellId"
    var recipeDetail:  RecipeDetailController?
    
    struct RecipesStruct: Decodable {
        
        let recipes: [RecipeStruct]
    }
    
    //MARK: - Work API
    private func fetchRecipes() {
        let url = URL(string: "https://test.space-o.ru/recipes")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            self.determiningФvailabilityOfInternet()
            
            if error != nil {
                print(error ?? "Error")
                return
            }
            do {
                let recipes = try JSONDecoder().decode(RecipesStruct.self, from: data!)
                self.recipes = [Recipe]()
                
                for obj in recipes.recipes {
                    let recipe = Recipe()
                    recipe.uuid = obj.uuid
                    recipe.lastUpdated = obj.lastUpdated
                    recipe.instructions = obj.instructions
                    recipe.name = obj.name
                    recipe.images = obj.images
                    recipe.descriptionDetail = obj.description
                    recipe.difficulty = obj.difficulty
                    self.recipes?.append(recipe)
                }
                self.deffualtArrayRecipe = self.recipes
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                }
            }
            catch let jsonError {
                print(jsonError)
            }
            
        }.resume()
    }
    
    //MARK: - DetectedInternetConnection
    func determiningФvailabilityOfInternet() {
        if ReachabilityConnect.isConnectedToNetwork() {
        } else {
            let alert = UIAlertController(title: "Oops, you have problem", message: "The Internet connection appears to be offline", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Okay...", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    //MARK: - Instructions
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchRecipes()
        navigationController?.navigationBar.isTranslucent = true
        
        
        let titleLabel = UILabel()
        titleLabel.text = "Recipes List"
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.textColor = UIColor.white
        navigationItem.titleView = titleLabel
        
        collectionView?.backgroundColor = UIColor.white
        collectionView!.register(RecipeCell.self, forCellWithReuseIdentifier: cellCollectionViewID)
//        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
//        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
        
        configureView()
    }

    //MARK: - Configurate Views
    private func configureView() {
//        addSortedMenuBar()
        addNavBarButtons()
    }
    
    private func addNavBarButtons() {
        let searchImage = UIImage(named: "search-icon")?.withRenderingMode(.alwaysOriginal)
        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        
        let sortButton = UIBarButtonItem(image: UIImage(named: "sort-icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleSort))
        
        navigationItem.rightBarButtonItems = [searchBarButtonItem, sortButton]
    }
    
    private func addSortedMenuBar() {
        let menuBar: SortedMenuBar = {
            let mb = SortedMenuBar()
            mb.translatesAutoresizingMaskIntoConstraints = true
            return mb
        }()
        view.addSubview(menuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(format: "V:|[v0(50)]", views: menuBar)
    }

    //MARK: - Selectors
    @objc private func handleSort() {
        
        sortingLauncher.showSortingVariation()
    }

    @objc private func handleSearch() {
        print("HO HO HO")
    }
    
    
    //MARK: - ShowControllers
    func showControllesForSorted(sorted: Sorting) {
        
        if sorted.name == .deffault {
            recipes = self.deffualtArrayRecipe
            self.collectionView?.reloadData()
        } else if sorted.name == .date {
            let test = recipes?.sorted(by: { (recipe1, recipe2) -> Bool in
                return recipe1.lastUpdated! < recipe2.lastUpdated!
            })
            recipes = test
            self.collectionView?.reloadData()
        } else {
            let test = recipes?.sorted(by: { (recipe1, recipe2) -> Bool in
                return recipe1.name! < recipe2.name!
            })
            recipes = test
            self.collectionView?.reloadData()
        }
    }
    
    func showDetailForRecipe(_ recipe: Recipe) {
        
        recipeDetail = RecipeDetailController()
        recipeDetail!.recipe = recipe

        self.navigationController?.pushViewController(recipeDetail!, animated: true)
    }
    
    
    //MARK: - DELEGATE
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipes?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellCollectionViewID, for: indexPath) as! RecipeCell
        
        cell.recipe = recipes?[indexPath.item]

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.width - 16 - 16) * 9 / 16
        return CGSize(width: self.view.frame.width, height: height + 16 + 68)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.recipe = self.recipes![indexPath.item]
        
        showDetailForRecipe(self.recipe!)
        
        print("selected \(indexPath.item)")
    }
}
