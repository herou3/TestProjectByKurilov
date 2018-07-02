//
//  RecipeDetailController.swift
//  TestProjectSpaceoByKurilov
//
//  Created by Pavel Kurilov on 29.05.2018.
//  Copyright © 2018 Pavel Kurilov. All rights reserved.
//

import LBTAComponents

class RecipeDetailController: UIViewController {
// MARK: - Property
    public var recipe: Recipe
    private var scrollView: UIScrollView = UIScrollView()
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
        let titleLabel = UILabel()
        titleLabel.text = recipe.name
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.textColor = UIColor.white
        navigationItem.titleView = titleLabel
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = .white
        let details = DetailRecipeView(frame: CGRect(x: self.view.bounds.minX,
                                                     y: self.view.bounds.minY,
                                                     width: view.bounds.width,
                                                     height: view.bounds.height))
        details.recipe = recipe
        scrollView = UIScrollView(frame: CGRect(x: self.scrollView.bounds.minX,
                                                y: self.scrollView.bounds.minY,
                                                width: view.bounds.width,
                                                height: view.bounds.height))
        scrollView.contentSize = CGSize(width: self.view.bounds.size.width,
                                        height: self.view.frame.size.height)

        self.view.addSubview(scrollView)
        self.scrollView.addSubview(details)
        scrollView.addConstraint(NSLayoutConstraint(item: scrollView,
                                                    attribute: .width,
                                                    relatedBy: .equal,
                                                    toItem: scrollView,
                                                    attribute: .width,
                                                    multiplier: 1,
                                                    constant: 0))
        details.recipe = recipe
    }
}
