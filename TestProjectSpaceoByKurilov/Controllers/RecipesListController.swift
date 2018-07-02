//
//  ViewController.swift
//  TestProjectSpaceoByKurilov
//
//  Created by Pavel Kurilov on 29.05.2018.
//  Copyright © 2018 Pavel Kurilov. All rights reserved.
//

import LBTAComponents
import SwiftyJSON
import TRON

enum SortingName: String {
    case defaultSort = "Sort by default"
    case name = "Sort by name"
    case date = "Sort by date"
}

class RecipesListController: UITableViewController {
    // MARK: - Property
    private var recipes: [Recipe]?
    private var deffualtArrayRecipe: [Recipe]?
    private var currentArray: [Recipe]? = []
    private var searchingArray: [Recipe]? = []
    var recipe: Recipe?
    private let cellCollectionViewID = "cellId"
    lazy var searchingLauncher: SearchingLauncher = {
        let searching = SearchingLauncher()
        return searching
    }()
    private var isSearhing: Bool = false
    private var isFilterDate: Bool = false
    private var isFilterName: Bool = false
    private var isFilterDefault: Bool = true
    // MARK: - DetectedInternetConnection
    func determiningAvailabilityOfInternet() {
        if ReachabilityConnect.isConnectedToNetwork() {
        } else {
            let alert = UIAlertController(title: "Oops, you have problem",
                                          message: "The Internet connection appears to be offline",
                                          preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Okay...",
                                          style: UIAlertActionStyle.default,
                                          handler: nil))
            self.present(alert,
                         animated: true,
                         completion: nil)
        }
    }
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        Service.sharedInstance.featchHomeFeed { (recipeDataSource, err) in
            if let err = err {
                print("Home Hold", err)
                if let apiError = err as? APIError<Service.JSONError> {
                    if apiError.response?.statusCode != 200 {
                        print("Status code not was 200")
                        self.determiningAvailabilityOfInternet()
                    }
                }
                return
            }
            self.recipes = recipeDataSource?.recipes
            self.currentArray = self.recipes
            self.deffualtArrayRecipe = self.recipes
            self.tableView.reloadData()
        }
        navigationController?.navigationBar.isTranslucent = true
        let titleLabel = UILabel()
        titleLabel.text = "Recipes List"
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.textColor = UIColor.white
        navigationItem.titleView = titleLabel
        tableView?.backgroundColor = UIColor.white
        tableView!.register(RecipeCell.self, forCellReuseIdentifier: cellCollectionViewID)
        searchingLauncher.changeSearchRequest = { [weak self] in
            self?.showSearchingResult()
        }
        configureView()
    }
    // MARK: - Configurate Views
    private func configureView() {
        addNavBarButtons()
    }
    private func addNavBarButtons() {
        let searchImage = UIImage(named: "search-icon")?.withRenderingMode(.alwaysOriginal)
        let searchBarButtonItem = UIBarButtonItem(image: searchImage,
                                                  style: .plain,
                                                  target: self,
                                                  action: #selector(handleSearch))
        let sortButton = UIBarButtonItem(image: UIImage(named: "sort-icon")?.withRenderingMode(.alwaysOriginal),
                                         style: .plain,
                                         target: self,
                                         action: #selector(handleSort))
        navigationItem.rightBarButtonItems = [searchBarButtonItem, sortButton]
        let refreshButton = UIBarButtonItem(image: UIImage(named: "refresh-icon")?.withRenderingMode(.alwaysOriginal),
                                            style: .plain,
                                            target: self,
                                            action: #selector(refreshTableView))
        navigationItem.leftBarButtonItems = [refreshButton]
    }
    // MARK: - Selectors
    @objc private func handleSort() {
        if isSearhing {
            self.searchingLauncher.searchBar.alpha = 0
            self.searchingLauncher.searchBar.endEditing(true)
            self.tableView?.contentInset = UIEdgeInsetsMake(Constant.navBarFrame.minY,
                                                            Constant.navBarFrame.minX,
                                                            Constant.navBarFrame.minX,
                                                            Constant.navBarFrame.minY)
            self.tableView?.scrollIndicatorInsets = UIEdgeInsetsMake(Constant.navBarFrame.minY,
                                                                     Constant.navBarFrame.minX,
                                                                     Constant.navBarFrame.minX,
                                                                     Constant.navBarFrame.minY)
            isSearhing = false
        }
        let alertController = UIAlertController(title: nil,
                                                message: nil,
                                                preferredStyle: .actionSheet)
        let sortByDefault = UIAlertAction(title: SortingName.defaultSort.rawValue,
                                          style: .default) {
                                            (action) in
            self.sorterRicepiList(withUse: .defaultSort)
        }
        let sortByDate = UIAlertAction(title: SortingName.date.rawValue,
                                       style: .default) {
                                        (action) in
            self.sorterRicepiList(withUse: .date)
        }
        let sortByName = UIAlertAction(title: SortingName.name.rawValue,
                                       style: .default) {
                                        (action) in
            self.sorterRicepiList(withUse: .name)
        }
        let cancelActionSheet = UIAlertAction(title: "Cancel",
                                              style: .cancel,
                                              handler: nil)
        alertController.addAction(sortByDefault)
        alertController.addAction(sortByName)
        alertController.addAction(sortByDate)
        alertController.addAction(cancelActionSheet)
        self.present(alertController,
                     animated: true,
                     completion: nil)
    }
    @objc private func refreshTableView() {
        Service.sharedInstance.featchHomeFeed { (recipeDataSource, err) in
            if let err = err {
                print("Home Hold", err)
                if let apiError = err as? APIError<Service.JSONError> {
                    if apiError.response?.statusCode != 200 {
                        print("Status code not was 200")
                        self.determiningAvailabilityOfInternet()
                        self.showAlertError(withMessage: err.localizedDescription,
                                            title: "Error",
                                            style: .default)
                    }
                }
                return
            }
            if self.isFilterDefault {
                self.recipes = recipeDataSource?.recipes
            } else if self.isFilterDate {
                self.sorterRicepiList(withUse: .date)
            } else {
                self.sorterRicepiList(withUse: .name)
            }
            self.currentArray = self.recipes
            self.deffualtArrayRecipe = self.recipes
            self.tableView.reloadData()
        }
    }
    @objc private func handleSearch() {
        if isSearhing == false {
            self.searchingLauncher.showSearchingBar()
            self.tableView?.contentInset = UIEdgeInsetsMake(Constant.navBarFrame.height,
                                                            Constant.navBarFrame.minX,
                                                            Constant.navBarFrame.minX,
                                                            Constant.navBarFrame.minY)
            self.tableView?.scrollIndicatorInsets = UIEdgeInsetsMake(Constant.navBarFrame.height,
                                                                     Constant.navBarFrame.minX,
                                                                     Constant.navBarFrame.minX,
                                                                     Constant.navBarFrame.minY)
            self.searchingLauncher.searchBar.alpha = 1
            isSearhing = true
        } else {
            self.searchingLauncher.searchBar.alpha = 0
            self.searchingLauncher.searchBar.text = ""
            self.searchingLauncher.searchingText = ""
            self.tableView?.contentInset = UIEdgeInsetsMake(Constant.navBarFrame.minY,
                                                            Constant.navBarFrame.minX,
                                                            Constant.navBarFrame.minX,
                                                            Constant.navBarFrame.minY)
            self.tableView?.scrollIndicatorInsets = UIEdgeInsetsMake(Constant.navBarFrame.minY,
                                                                     Constant.navBarFrame.minX,
                                                                     Constant.navBarFrame.minX,
                                                                     Constant.navBarFrame.minY)
            self.searchingLauncher.searchBar.endEditing(true)
            isSearhing = false
        }
    }
    // MARK: - ShowControllers
    func sorterRicepiList(withUse sortedType: SortingName) {
        switch sortedType.rawValue {
        case "Sort by default":
            print("default")
            recipes = self.deffualtArrayRecipe
            self.currentArray = self.deffualtArrayRecipe
            self.searchingLauncher.searchingText = ""
            self.searchingLauncher.searchBar.text = ""
            isFilterDefault = true
            isFilterDate = false
            isFilterName = false
            self.tableView.reloadData()
        case "Sort by name":
            let sortedByName = recipes?.sorted(by: { (recipe1, recipe2) -> Bool in
                isFilterDefault = false
                isFilterDate = false
                isFilterName = true
                return recipe1.name! < recipe2.name!
            })
            self.currentArray = currentArray?.sorted(by: { (recipe1, recipe2) -> Bool in
                return recipe1.name! < recipe2.name!
            })
            recipes = sortedByName
            self.tableView?.reloadData()
        case "Sort by date":
            print("destructive")
            let sortedByDate = recipes?.sorted(by: { (recipe1, recipe2) -> Bool in
                return recipe1.lastUpdated! < recipe2.lastUpdated!
            })
            self.currentArray = currentArray?.sorted(by: { (recipe1, recipe2) -> Bool in
                return recipe1.lastUpdated! < recipe2.lastUpdated!
            })
            isFilterDefault = false
            isFilterDate = true
            isFilterName = false
            recipes = sortedByDate
            self.tableView?.reloadData()
        default:
            self.tableView.reloadData()
        }
    }
    // I don't use caseInsensitiveCompare
    private func showSearchingResult() {
        if currentArray != nil {
//            for obj in currentArray {
//                
//            }
        }
//        if currentArray != nil {
//            for obj in currentArray! {
//                if (obj.name?.contains(find: self.searchingLauncher.searchingText!))! {
//                    if !(searchingArray?.contains()! {
//                        self.searchingArray?.append(obj)
//                        self.recipes = searchingArray
//                    }
//                }
//                if obj.description != nil
//                    && (obj.description?.contains(find: self.searchingLauncher.searchingText!))! {
//                        if !(searchingArray?.contains(obj))! {
//                            self.searchingArray?.append(obj)
//                            self.recipes = searchingArray
//                        }
//                    }
//                if obj.instructions != nil && (obj.instructions?.contains(find: self.searchingLauncher.searchingText!))! {
//                        if !(searchingArray?.contains(obj))! {
//                            self.searchingArray?.append(obj)
//                            self.recipes = searchingArray
//                        }
//                    }
//                }
//            self.tableView?.reloadData()
//            if self.searchingArray?.count == 0 {
//                self.recipes = currentArray
//                self.tableView?.reloadData()
//            }
//            self.searchingArray = []
//        }
//        if self.searchingLauncher.searchingText == "" {
//            self.recipes = currentArray
//        }
    }
    private func showDetailForRecipe(_ recipe: Recipe) {
        let recipeDetail = RecipeDetailController(recipe: recipe)
        recipeDetail.recipe = recipe
        self.searchingLauncher.searchBar.alpha = 0
        self.searchingLauncher.searchBar.endEditing(true)
        if isSearhing {
            self.tableView?.contentInset = UIEdgeInsetsMake(Constant.navBarFrame.minY,
                                                            Constant.navBarFrame.minX,
                                                            Constant.navBarFrame.minX,
                                                            Constant.navBarFrame.minY)
            self.tableView?.scrollIndicatorInsets = UIEdgeInsetsMake(Constant.navBarFrame.minY,
                                                                     Constant.navBarFrame.minX,
                                                                     Constant.navBarFrame.minX,
                                                                     Constant.navBarFrame.minY)
            self.tableView?.reloadData()
        }
        isSearhing = false
        self.navigationController?.pushViewController(recipeDetail, animated: true)
    }
    // MARK: - DELEGATE and DataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes?.count ?? 0
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellCollectionViewID,
                                                       for: indexPath)
            as? RecipeCell else { return UITableViewCell(style: .default,
                                                         reuseIdentifier: cellCollectionViewID)}
        cell.recipe = recipes?[indexPath.item]
        return cell
    }
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        self.recipe = self.recipes![indexPath.item]
        showDetailForRecipe(self.recipe!)
        print("selected \(indexPath.item)")
    }
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.searchingLauncher.searchBar.endEditing(true)
    }
}
