//
//  RecipeCell.swift
//  TestProjectSpaceoByKurilov
//
//  Created by Pavel Kurilov on 15.05.2018.
//  Copyright © 2018 Pavel Kurilov. All rights reserved.
//

import Foundation
import UIKit

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Init(coder!) has not been implemented")
    }
}

class RecipeCell: BaseCell {
    
    var recipe: Recipe? {
        didSet {
            nameLabel.text = recipe?.name
            recipeImageView.image = UIImage(named: (recipe?.image)!)
            descriptionTextView.text = recipe?.descriptionDetail
            difficultyLabel.text = String("\(recipe?.difficult ?? 0)")
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    let recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "sushi-minsk")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(143,188,143)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let difficultyLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(red: 34/255, green: 139/255, blue: 34/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "4"
        label.textColor = UIColor.white
        label.textAlignment = NSTextAlignment.center
        label.layer.cornerRadius = 22
        label.layer.masksToBounds = true
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 0, green: 100/255, blue: 0, alpha: 1)
        label.text = "Суши филадельфия"
        return label
    }()
    
    let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text? = "Суши обернутые лососем, внутри - рис, творожный сыр, огурец и авакадо. Подаются прохладными. Являются востребованным блюдом во всех японских ресторанах"
        textView.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0)
        textView.textColor = UIColor(red: 60/255, green: 179/255, blue: 113/255, alpha: 1)
        textView.isEditable = false
        return textView
    }()
    
    override func setupViews() {
        addSubview(recipeImageView)
        addSubview(lineView)
        addSubview(difficultyLabel)
        addSubview(nameLabel)
        addSubview(descriptionTextView)
        
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: recipeImageView)
        addConstraintsWithFormat(format: "H:|-16-[v0(44)]", views: difficultyLabel)
        addConstraintsWithFormat(format: "H:|[v0]|", views: lineView)
        
        //Vertical constraint
        addConstraintsWithFormat(format: "V:|-16-[v0]-8-[v1(44)]-16-[v2(1)]|", views: recipeImageView, difficultyLabel, lineView)
        //Top constraint
        addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .top, relatedBy: .equal, toItem: recipeImageView, attribute: .bottom, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: descriptionTextView, attribute: .top, relatedBy: .equal, toItem: nameLabel, attribute: .bottom, multiplier: 1, constant: 4))
        //Left constraint
        addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .left, relatedBy: .equal, toItem: difficultyLabel, attribute: .right, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: descriptionTextView, attribute: .left, relatedBy: .equal, toItem: difficultyLabel, attribute: .right, multiplier: 1, constant: 8))
        //Right constraint
        addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .right, relatedBy: .equal, toItem: recipeImageView, attribute: .right, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: descriptionTextView, attribute: .right, relatedBy: .equal, toItem: recipeImageView, attribute: .right, multiplier: 1, constant: 0))
        //Height constraint
        addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
        addConstraint(NSLayoutConstraint(item: descriptionTextView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Init(coder!) has not been implemented")
    }
    
}
