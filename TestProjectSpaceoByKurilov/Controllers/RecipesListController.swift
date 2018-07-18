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

enum SortingType: String {
    case defaultSort, name, date
    
    var description: String {
            switch self {
            case .defaultSort:
                return "Sort by default"
            case .name:
                return "Sort by name"
            case .date:
                return "Sort by date"
        }
    }
}

class RecipesListController: UITableViewController {
    // MARK: - Property
    private var recipes: [Recipe]? {
        didSet {
            self.tableView.reloadData()
        }
    }
    private var defaultArrayRecipes: [Recipe]?
    private let recipeCellReuseIdentifier = "cellId"
    private let searchController = UISearchController(searchResultsController: nil)
    private var currentArray: [Recipe]? = []
    private var isSearhing: Bool = false
    private var navigationTitleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Recipes List"
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.textColor = UIColor.white
        return titleLabel
    }()
    private var networkService: NetworkService
    lazy var refreshDataControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self,
                                 action: #selector(refreshWeatherData(_:)),
                                 for: .valueChanged)
        refreshControl.tintColor = UIColor.appPrimary
        return refreshControl
    }()
    
    // MARK: - Determining Error Of Internet
    func determiningErrorOfInternet(error: Error) {
        let alert = UIAlertController(title: "Oops, you have problem",
                                      message: error.localizedDescription,
                                      preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Okay...",
                                      style: UIAlertActionStyle.default,
                                      handler: nil))
        self.present(alert,
                     animated: true,
                     completion: nil)
    }
    
    // MARK: - Init
    init(networkService: NetworkService) {
        self.networkService = networkService
        super.init(style: .plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurateSearchBar()
        loadAndRefreshRecipesData()
        navigationController?.navigationBar.isTranslucent = true
        configurateTablleView()
        configurateNavigationBar()
        configureView()
    }
    
    // MARK: - Configurate
    private func configurateTablleView() {
        tableView?.backgroundColor = UIColor.white
        tableView!.register(RecipeCell.self,
                            forCellReuseIdentifier: recipeCellReuseIdentifier)
        tableView.showsHorizontalScrollIndicator = false
        tableView.addSubview(refreshDataControl)
    }
    
    private func configurateSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        searchController.searchBar.barTintColor = UIColor.white
        searchController.searchBar.tintColor = UIColor.appPrimary
        searchController.searchBar.setBackgroundImage(#imageLiteral(resourceName: "greenKitchen-image"), for: .any, barMetrics: .default)
        searchController.searchBar.backgroundColor = .appPrimary
        tableView.tableHeaderView = searchController.searchBar
    }
    
    private func configurateNavigationBar() {
        navigationController?.navigationBar.barTintColor = UIColor.appPrimary
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .white
        if #available(iOS 11.0, *) {
            navigationItem.titleView = self.navigationTitleLabel
        } else {
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
            navigationItem.title = "Recipes List"
        }
    }
    
    private func configureView() {
        addNavBarButtons()
    }
    
    private func addNavBarButtons() {
        let sortButtonItem = UIBarButtonItem(image: UIImage(named: "sort-icon")?.withRenderingMode(.alwaysOriginal),
                                         style: .plain,
                                         target: self,
                                         action: #selector(handleSort))
        navigationItem.rightBarButtonItems = [sortButtonItem]
        let refreshButtonItem = UIBarButtonItem(image: UIImage(named: "refresh-icon")?.withRenderingMode(.alwaysOriginal),
                                            style: .plain,
                                            target: self,
                                            action: #selector(refreshTableView))
        navigationItem.leftBarButtonItems = [refreshButtonItem]
    }
    
    private func loadAndRefreshRecipesData() {
        networkService.featchHomeFeed { (recipeDataSource, err) in
            if let err = err {
                print("Home Hold", err)
                if let apiError = err as? APIError<NetworkService.JSONError> {
                    if apiError.response?.statusCode != 200 {
                        print("Status code not was 200")
                        self.determiningErrorOfInternet(error: err)
                    }
                }
                return
            }
            self.recipes = recipeDataSource?.recipes
            self.currentArray = self.recipes
            self.defaultArrayRecipes = self.recipes
        }
    }
    
    // MARK: - Selectors
    @objc private func handleSort() {
        let alertController = UIAlertController(title: nil,
                                                message: nil,
                                                preferredStyle: .actionSheet)
        let sortByDefault = UIAlertAction(title: SortingType.defaultSort.description,
                                          style: .default) { _ in
            self.sorterRecipeList(by: .defaultSort)
        }
        let sortByDate = UIAlertAction(title: SortingType.date.description,
                                       style: .default) { _ in
            self.sorterRecipeList(by: .date)
        }
        let sortByName = UIAlertAction(title: SortingType.name.description,
                                       style: .default) { _ in
            self.sorterRecipeList(by: .name)
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
        loadAndRefreshRecipesData()
    }
    
    @objc private func refreshWeatherData(_ sender: Any) {
        loadAndRefreshRecipesData()
        self.tableView.reloadData()
        self.refreshDataControl.endRefreshing()
    }
    
    // MARK: - Segues
    private func sorterRecipeList(by sortedType: SortingType) {
        switch sortedType.description {
        case "Sort by default":
            print("default")
            recipes = self.defaultArrayRecipes
            self.currentArray = self.defaultArrayRecipes
            self.tableView.reloadData()
        case "Sort by name":
            let sortedByName = recipes?.sorted(by: { (recipe1, recipe2) -> Bool in
                return recipe1.name! < recipe2.name!
            })
            self.currentArray = recipes?.sorted(by: { (recipe1, recipe2) -> Bool in
                return recipe1.name! < recipe2.name!
            })
            recipes = sortedByName
            self.tableView?.reloadData()
        case "Sort by date":
            print("destructive")
            let sortedByDate = recipes?.sorted(by: { (recipe1, recipe2) -> Bool in
                return recipe1.lastUpdated! < recipe2.lastUpdated!
            })
            self.currentArray = recipes?.sorted(by: { (recipe1, recipe2) -> Bool in
                return recipe1.lastUpdated! < recipe2.lastUpdated!
            })
            recipes = sortedByDate
        default:
            print("Example")
        }
    }
    
    private func searhBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        recipes = currentArray?.filter({ recipe -> Bool in
            guard let isNameContains = recipe.name?.lowercased().contains(find: searchText.lowercased()) else { return false }
            guard let isDescriptionContains = recipe.description?.lowercased().contains(find: searchText.lowercased())
                else { return false }
            guard let isInstructionsContains = recipe.instructions?.lowercased().contains(find: searchText.lowercased())
                else { return false }
            return  isNameContains ||
                    isDescriptionContains ||
                    isInstructionsContains
        })
        self.tableView.reloadData()
    }
    
    private func isFiltering() -> Bool {
        return searchController.isActive && !searhBarIsEmpty()
    }
    
    // MARK: - ShowControllers
    private func showDetailForRecipe(_ recipe: Recipe) {
        let recipeDetail = RecipeDetailController(recipe: recipe)
        recipeDetail.recipe = recipe
        self.navigationController?.pushViewController(recipeDetail, animated: true)
    }
}

// MARK: - extension DELEGATE and DataSource
extension RecipesListController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes?.count ?? 0
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: recipeCellReuseIdentifier,
                                                       for: indexPath)
            as? RecipeCell else { return UITableViewCell(style: .default,
                                                         reuseIdentifier: recipeCellReuseIdentifier)}
        cell.configureCell(recipeName: recipes?[indexPath.item].name,
                           recipeImages: recipes?[indexPath.item].images,
                           recipeDescription: recipes?[indexPath.item].description,
                           recipeDifficulty: recipes?[indexPath.item].difficulty)
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return Constant.cellHeight
    }
    
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        let recipe = self.recipes![indexPath.item]
        showDetailForRecipe(recipe)
    }
    
    override func tableView(_ tableView: UITableView,
                            willDeselectRowAt indexPath: IndexPath) -> IndexPath? {
       tableView.deselectRow(at: indexPath, animated: true)
        return indexPath
    }
}

// MARK: - extension UISearchResultsUpdating
extension RecipesListController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        if !searhBarIsEmpty() {
            filterContentForSearchText(searchController.searchBar.text!)
        } else {
            recipes = currentArray
        }
    }
}

// MARK: - extension UISearchBarDelegate
extension RecipesListController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        recipes = currentArray
        self.tableView.reloadData()
    }
}
