//
//  RecipeCell.swift
//  TestProjectSpaceoByKurilov
//
//  Created by Pavel Kurilov on 29.05.2018.
//  Copyright © 2018 Pavel Kurilov. All rights reserved.
//

import LBTAComponents

class DefaultCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "StelID")
        setupViews()
    }
    func setupViews() {
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class RecipeCell: DefaultCell {
// MARK: - Methods
    func configureCell(recipeName: String?,
                       recipeImages: [String]?,
                       recipeDescription: String?,
                       recipeDifficulty: Int?) {
        nameLabel.text = recipeName
        if recipeImages != nil && recipeImages != [] {
            recipeImageView.loadImage(urlString: (recipeImages?.first)!)
        } else {
            recipeImageView.image = UIImage(named: "deffualt")
        }
        descriptionTextLabel.text = recipeDescription
        if recipeDifficulty != nil {
            setupDifficultyStatus(recipeDifficulty: recipeDifficulty)
        } else {
            difficultyLabel.text = "0"
        }
    }
    
    private func setupDifficultyStatus(recipeDifficulty: Int?) {
        switch recipeDifficulty {
        case 1:
            difficultyLabel.text = "1"
            difficultyLabel.backgroundColor = UIColor.paleRaiting
        case 2:
            difficultyLabel.text = "2"
            difficultyLabel.backgroundColor = UIColor.paleRaiting
        case 3:
            difficultyLabel.text = "3"
            difficultyLabel.backgroundColor = UIColor.averageRaiting
        case 4:
            difficultyLabel.text = "4"
            difficultyLabel.backgroundColor = UIColor.murkyRating
        case 5:
            difficultyLabel.text = "5"
            difficultyLabel.backgroundColor = UIColor.darkGreen
        default:
            difficultyLabel.text = "0"
        }
    }
// MARK: - Create UIView for cell
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    private let recipeImageView: CachedImageView = {
        let imageView = CachedImageView()
        imageView.image = UIImage(named: "image-not-found")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.dividingLine
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let difficultyLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.appPrimary
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
        label.textColor = UIColor.darkGreen
        label.text = "Суши филадельфия"
        label.numberOfLines = 2
        return label
    }()
    private let descriptionTextLabel: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text? = "Суши обернутые лососем, внутри - рис, творожный сыр"
        textView.textColor = UIColor.descriptionText
        textView.font = UIFont.systemFont(ofSize: 12)
        textView.isEditable = false
        return textView
    }()
    
    override func setupViews() {
        addSubview(recipeImageView)
        addSubview(lineView)
        addSubview(difficultyLabel)
        addSubview(nameLabel)
        addSubview(descriptionTextLabel)
        recipeImageView.anchor(self.topAnchor,
                               left: self.leftAnchor,
                               bottom: self.bottomAnchor,
                               right: nil, topConstant: 16,
                               leftConstant: 16,
                               bottomConstant: 16,
                               rightConstant: 0,
                               widthConstant: 150,
                               heightConstant: 202)
        difficultyLabel.anchor(recipeImageView.topAnchor,
                               left: recipeImageView.leftAnchor,
                               bottom: nil,
                               right: nil,
                               topConstant: 0,
                               leftConstant: 0,
                               bottomConstant: 0,
                               rightConstant: 0,
                               widthConstant: 40,
                               heightConstant: 40)
        nameLabel.anchor(recipeImageView.topAnchor,
                         left: recipeImageView.rightAnchor,
                         bottom: nil,
                         right: self.rightAnchor,
                         topConstant: 0,
                         leftConstant: 8,
                         bottomConstant: 0,
                         rightConstant: 16,
                         widthConstant: 0,
                         heightConstant: 44)
        descriptionTextLabel.anchor(nameLabel.bottomAnchor,
                                    left: recipeImageView.rightAnchor,
                                    bottom: self.bottomAnchor,
                                    right: self.rightAnchor,
                                    topConstant: 8,
                                    leftConstant: 8,
                                    bottomConstant: 16,
                                    rightConstant: 16,
                                    widthConstant: 0,
                                    heightConstant: 0)
        lineView.anchor(nil,
                        left: self.leftAnchor,
                        bottom: self.bottomAnchor,
                        right: self.rightAnchor,
                        topConstant: 0,
                        leftConstant: 0,
                        bottomConstant: 0,
                        rightConstant: 0,
                        widthConstant: 0,
                        heightConstant: 2)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Init(coder!) has not been implemented")
    }
}
