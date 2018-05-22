//
//  RecipeDetailController.swift
//  TestProjectSpaceoByKurilov
//
//  Created by Pavel Kurilov on 17.05.2018.
//  Copyright © 2018 Pavel Kurilov. All rights reserved.
//

import UIKit

class RecipeDetailController: UIViewController {
    
    var recipesListController: RecipesListController?
    var recipe: Recipe?
    var details: DetailRecipe?
    var scrollView: UIScrollView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleLabel = UILabel()
        titleLabel.text = recipe?.name
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.textColor = UIColor.white
        navigationItem.titleView = titleLabel
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = .white
        
        if recipe != nil {
                print(recipe!)
        }
        
        details = DetailRecipe(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
        scrollView?.contentSize = CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height + 100)

        self.view.addSubview(scrollView!)
        self.scrollView?.addSubview(details!)
        
        scrollView?.addConstraint(NSLayoutConstraint(item: scrollView!, attribute: .width, relatedBy: .equal, toItem: scrollView, attribute: .width, multiplier: 1, constant: 0))
        details?.recipe = recipe
    }
    
    func dismissViewControllers() {
        
        guard let vc = self.presentingViewController else { return }
        
        while (vc.presentingViewController != nil) {
            vc.dismiss(animated: true, completion: nil)
        }
    }
    
}
