//
//  RecipeDetailController.swift
//  TestProjectSpaceoByKurilov
//
//  Created by Pavel Kurilov on 29.05.2018.
//  Copyright © 2018 Pavel Kurilov. All rights reserved.
//

import LBTAComponents
import SnapKit

class RecipeDetailController: UIViewController {
// MARK: - Property
    var recipe: Recipe
    private var scrollView: UIScrollView = UIScrollView()
    let detailView = DetailRecipeView()
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = recipe.name
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.white
        return label
    }()
    
// MARK: - Init
    init(recipe: Recipe) {
        self.recipe = recipe
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = titleLabel
        configurateNavigationBar()
        guard let recipeLastUpdated = recipe.lastUpdated else { return }
        detailView.configureDataForDetailView(recipeName: recipe.name,
                              recipeImages: recipe.images,
                              recipeDescription: recipe.description,
                              recipeDifficulty: recipe.difficulty,
                              recipeInstructions: recipe.instructions?.replacingOccurrences(of: "<br>", with: "\n"),
                              recipeLastUpdatedСonverted: convertUnixTime(timeInterval: Double(recipeLastUpdated)))
        configurateController()
        print("test")
    }
    
    // MARK: - Configurate RecipeDetailController
    private func addScrollView() {
        self.scrollView.backgroundColor = .white
        self.view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.top.right.bottom.left.equalToSuperview()
        }
    }
    
    private func addDetailView() {
        self.scrollView.addSubview(detailView)
        detailView.snp.makeConstraints { (make) in
            make.top.equalTo(scrollView.snp.top)
            make.left.equalTo(scrollView.snp.left)
            make.bottom.equalTo(scrollView.snp.bottom)
            make.right.equalTo(scrollView.snp.right)
            make.width.equalTo(self.view)
        }
    }
    
    private func configurateController() {
        addScrollView()
        addDetailView()
    }
    
    private func configurateNavigationBar() {
        navigationController?.navigationBar.barTintColor = UIColor.appPrimary
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .white
        navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "recipe"))
    }
    
    // MARK: - Segues
    private func convertUnixTime(timeInterval: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timeInterval)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: date)
    }
}
