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
        self.view.addSubview(details!)
        
     //   details?.recipe = recipe
        
        print("la la lal la ")
    }
    
    func dismissViewControllers() {
        
        guard let vc = self.presentingViewController else { return }
        
        while (vc.presentingViewController != nil) {
            vc.dismiss(animated: true, completion: nil)
        }
    }
    
}
