//
//  RecipeCell.swift
//  TestProjectSpaceoByKurilov
//
//  Created by Pavel Kurilov on 29.05.2018.
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
            if recipe?.images != nil {
                setupRecipeImage()
            } else {
                recipeImageView.image = UIImage(named: "deffualt")
            }
            descriptionTextLabel.text = recipe?.descriptionDetail
            if recipe?.difficulty != nil {
                setupDifficultyStatus()
            } else {
                difficultyLabel.text = "0"
            }
        }
    }
    //MARK: - Methods
    private func setupRecipeImage() {
        if let recipeImageViewURL = recipe?.images {
            //for imageURL in recipeImageViewURL {
                let url = URL(string: recipeImageViewURL[0])
                URLSession.shared.dataTask(with: url!) { (data, response, error) in
                    if error != nil {
                        print(error ?? "Error")
                        return
                    }
                    DispatchQueue.main.async {
                        self.recipeImageView.image = UIImage(data: data!)
                    }
                }.resume()
           // }
        }
    }
    
    private func setupDifficultyStatus() {
        switch recipe?.difficulty {
        case 1:
            difficultyLabel.text = "1"
            difficultyLabel.backgroundColor = UIColor.rgb(173, 255, 47)
        case 2:
            difficultyLabel.text = "2"
            difficultyLabel.backgroundColor = UIColor.rgb(124, 252, 0)
        case 3:
            difficultyLabel.text = "3"
            difficultyLabel.backgroundColor = UIColor.rgb(124, 252, 0)
        case 4:
            difficultyLabel.text = "4"
            difficultyLabel.backgroundColor = UIColor.rgb(60, 179, 113)
        case 5:
            difficultyLabel.text = "5"
            difficultyLabel.backgroundColor = UIColor.rgb(0, 100, 0)
        default:
            difficultyLabel.text = "0"
        }
    }
    
    //MARK: - Create UIView for cell
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    private let recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "image-not-found")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(143,188,143)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let difficultyLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.rgb(34, 139, 34)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "4"
        label.textColor = UIColor.white
        label.textAlignment = NSTextAlignment.center
        label.layer.cornerRadius = 22
        label.layer.masksToBounds = true
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.rgb(0, 100, 0)
        label.text = "Суши филадельфия"
        return label
    }()
    
    private let descriptionTextLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text? = "Суши обернутые лососем, внутри - рис, творожный сыр, огурец и авакадо. Подаются прохладными. Являются востребованным блюдом во всех японских ресторанах"
        //textView.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0)
        textLabel.textColor = UIColor.rgb(60, 179, 113)
        textLabel.font = UIFont.systemFont(ofSize: 12)
        textLabel.numberOfLines = 2
        //textView.isEditable = false
        return textLabel
    }()
    
    override func setupViews() {
        addSubview(recipeImageView)
        addSubview(lineView)
        addSubview(difficultyLabel)
        addSubview(nameLabel)
        addSubview(descriptionTextLabel)
        
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: recipeImageView)
        addConstraintsWithFormat(format: "H:|-16-[v0(44)]", views: difficultyLabel)
        addConstraintsWithFormat(format: "H:|[v0]|", views: lineView)
        
        //Vertical constraint
        addConstraintsWithFormat(format: "V:|-16-[v0]-8-[v1(44)]-16-[v2(1)]|", views: recipeImageView, difficultyLabel, lineView)
        //Top constraint
        addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .top, relatedBy: .equal, toItem: recipeImageView, attribute: .bottom, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: descriptionTextLabel, attribute: .top, relatedBy: .equal, toItem: nameLabel, attribute: .bottom, multiplier: 1, constant: 4))
        //Left constraint
        addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .left, relatedBy: .equal, toItem: difficultyLabel, attribute: .right, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: descriptionTextLabel, attribute: .left, relatedBy: .equal, toItem: difficultyLabel, attribute: .right, multiplier: 1, constant: 8))
        //Right constraint
        addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .right, relatedBy: .equal, toItem: recipeImageView, attribute: .right, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: descriptionTextLabel, attribute: .right, relatedBy: .equal, toItem: recipeImageView, attribute: .right, multiplier: 1, constant: 0))
        //Height constraint
        addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
        addConstraint(NSLayoutConstraint(item: descriptionTextLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Init(coder!) has not been implemented")
    }
}
