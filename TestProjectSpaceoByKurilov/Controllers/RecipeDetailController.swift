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
        let details = DetailRecipeView(frame: CGRect(x: view.bounds.minX,
                                                     y: view.bounds.minY,
                                                     width: view.bounds.width,
                                                     height: view.bounds.height))
        details.recipe = recipe
        scrollView = UIScrollView(frame: CGRect())
        scrollView.contentSize = CGSize(width: self.view.bounds.size.width,
                                        height: self.view.frame.size.height)
        self.view.addSubview(scrollView)
        scrollView.anchor(self.view.topAnchor,
                          left: self.view.leftAnchor,
                          bottom: self.view.bottomAnchor,
                          right: self.view.rightAnchor,
                          topConstant: 0,
                          leftConstant: 0,
                          bottomConstant: 0,
                          rightConstant: 0,
                          widthConstant: 0,
                          heightConstant: 0)
        self.scrollView.addSubview(details)
        details.anchor(self.scrollView.topAnchor,
                       left: self.view.leftAnchor,
                       bottom: self.view.bottomAnchor,
                       right: self.view.rightAnchor,
                       topConstant: 0,
                       leftConstant: 0,
                       bottomConstant: 0,
                       rightConstant: 0,
                       widthConstant: 0,
                       heightConstant: 0)
        details.recipe = recipe
    }
}
