//
//  RecipeCell.swift
//  TestProjectSpaceoByKurilov
//
//  Created by Pavel Kurilov on 29.05.2018.
//  Copyright © 2018 Pavel Kurilov. All rights reserved.
//

import LBTAComponents
import SnapKit

class DefaultCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "recipeCellReuseIdentifier")
        setupViews()
    }
    
    func setupViews() {
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class RecipeCell: DefaultCell {
    
    // MARK: - Init RecipeCell
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Init(coder!) has not been implemented")
    }
    
// MARK: - Methods
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
    private let recipeImageView: CachedImageView = {
        let imageView = CachedImageView()
        imageView.image = #imageLiteral(resourceName: "image-not-found")
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
        label.numberOfLines = 2
        return label
    }()
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textColor = UIColor.descriptionText
        textView.font = UIFont.systemFont(ofSize: 12)
        textView.isEditable = false
        return textView
    }()
    
    // MARK: - Configurate RecipeCell
    private func addRecipeImageView() {
        addSubview(recipeImageView)
        recipeImageView.snp.makeConstraints { (make) in
            make.top.left.equalTo(self).offset(16)
            make.height.equalTo(Constant.cellHeight / 2)
            make.right.equalTo(self).offset(-16)
        }
    }
    
    private func addDifficultyLabel() {
        addSubview(difficultyLabel)
        difficultyLabel.snp.makeConstraints { (make) in
            make.top.equalTo(recipeImageView)
            make.left.equalTo(self).offset(16)
            make.width.height.equalTo(40)
        }
    }
    
    private func addNameLabel() {
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(recipeImageView.snp.bottom).offset(16)
            make.left.equalTo(self).offset(16)
            make.right.equalTo(self).offset(-16)
        }
    }
    
    private func addDescriptionTextLabel() {
        addSubview(descriptionTextView)
        descriptionTextView.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.left.equalTo(self).offset(16)
            make.right.equalTo(self).offset(-16)
        }
    }
    
    private func addLineView() {
        addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.top.equalTo(descriptionTextView.snp.bottom).offset(8)
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.height.equalTo(2)
            make.bottom.equalTo(self)
        }
    }
    
    override func setupViews() {
        addRecipeImageView()
        addDifficultyLabel()
        addNameLabel()
        addDescriptionTextLabel()
        addLineView()
    }
    
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
        if recipeDescription != nil && recipeDescription != "" {
            descriptionTextView.text = recipeDescription
        } else {
            descriptionTextView.text = "No description"
        }
        if recipeDifficulty != nil {
            setupDifficultyStatus(recipeDifficulty: recipeDifficulty)
        } else {
            difficultyLabel.text = "0"
        }
    }
}
