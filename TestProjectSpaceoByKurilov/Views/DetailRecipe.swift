//
//  DetailRecipe.swift
//  TestProjectSpaceoByKurilov
//
//  Created by Pavel Kurilov on 17.05.2018.
//  Copyright © 2018 Pavel Kurilov. All rights reserved.
//

import UIKit

class DetailRecipe: UIView {
    
    var scrollSize: Int?
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
            }
        }
    }
    var pageControl = UIPageControl()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        scrollSize = recipe?.images?.count
        setupViews()
        self.scrollViewForImages.contentSize = CGSize(width: self.bounds.size.width * 5, height: self.bounds.size.height / 4)
        pageControl.numberOfPages = 30
        pageControl.currentPage = 4
        pageControl.pageIndicatorTintColor = .green
        pageControl.currentPageIndicatorTintColor = .black
        viewForPageController.addSubview(pageControl)

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
    }
    
    
    //MARK: - Create UIView for cell
    
    private let scrollViewForImages: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "sushi-minsk")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let viewForPageController: UIView = {
        let pc = UIView()
        pc.backgroundColor = .red
        return pc
    }()
    
    private let pageController: UIPageControl = {
        let pc = UIPageControl()
        return pc
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.rgb(0, 100, 0)
        label.text = "Суши филадельфия gsdg sdg skdhsd gksd gksdgksdgksdg vsdg"
        label.numberOfLines = 2
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.rgb(124, 252, 0)
        label.text = "12.06.2016"
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    private let helpDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "Description:"
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .gray
        return label
    }()
    
    private let descriptionTextLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text? = "Суши обернутые лососем, внутри - рис, творожный сыр, огурец и авакадо. Подаются прохладными. Являются востребованным блюдом во всех японских ресторанах"
        //textView.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0)
        textLabel.textColor = UIColor.rgb(60, 179, 113)
        textLabel.font = UIFont.systemFont(ofSize: 14)
        textLabel.numberOfLines = 3
        //textView.isEditable = false
        return textLabel
    }()
    
    private let helpInstructionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "Instruction:"
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .gray
        return label
    }()
    
    private let instructionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "Суши обернутые лососем, внутри - рис, творожный сыр, огурец и авакадо. Подаются прохладными. Являются востребованным блюдом во всех японских ресторанах"
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.font = UIFont.systemFont(ofSize: 12)
        textView.textColor = UIColor.rgb(60, 179, 113)
        return textView
    }()
    
    func setupViews() {
        
//        addSubview(recipeImageView)
//        addSubview(lineView)
//        addSubview(difficultyLabel)
//        addSubview(nameLabel)
//        addSubview(descriptionTextLabel)
        addSubview(scrollViewForImages)
        scrollViewForImages.addSubview(recipeImageView)
        addSubview(viewForPageController)
//        viewForPageController.addSubview(pageController)
        addSubview(nameLabel)
        addSubview(dateLabel)
        addSubview(helpDescriptionLabel)
        addSubview(descriptionTextLabel)
        addSubview(helpInstructionLabel)
        addSubview(instructionTextView)
        
        scrollViewForImages.delegate = self
        
        addConstraintsWithFormat(format: "V:|-64-[v0(256)]-12-[v1(0)]-4-[v2(50)]-4-[v3(12)]-0-[v4(40)]-4-[v5(12)]-0-[v6]-8-|", views: scrollViewForImages, viewForPageController, nameLabel, helpDescriptionLabel,  descriptionTextLabel, helpInstructionLabel, instructionTextView)
        
        addConstraintsWithFormat(format: "H:|-4-[v0]-4-|", views: scrollViewForImages)
        addConstraintsWithFormat(format: "H:|-8-[v0]-8-|", views: viewForPageController)
        addConstraintsWithFormat(format: "H:|-8-[v0]-8-[v1(80)]-8-|", views: nameLabel, dateLabel)
        addConstraintsWithFormat(format: "H:|-4-[v0]-4-|", views: descriptionTextLabel)
        addConstraintsWithFormat(format: "H:|-2-[v0]|", views: helpInstructionLabel)
        addConstraintsWithFormat(format: "H:|-2-[v0]|", views: helpDescriptionLabel)
        addConstraintsWithFormat(format: "H:|-4-[v0]-4-|", views: instructionTextView)
        
        
        addConstraint(NSLayoutConstraint(item: recipeImageView, attribute: .width, relatedBy: .equal, toItem: scrollViewForImages, attribute: .width, multiplier: 1, constant: 0))
  //     addConstraint(NSLayoutConstraint(item: pageController, attribute: .width, relatedBy: .equal, toItem: viewForPageController, attribute: .width, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: recipeImageView, attribute: .height, relatedBy: .equal, toItem: scrollViewForImages, attribute: .height, multiplier: 1, constant: 0))
  //      addConstraint(NSLayoutConstraint(item: pageController, attribute: .height, relatedBy: .equal, toItem: viewForPageController, attribute: .height, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: recipeImageView, attribute: .centerX, relatedBy: .equal, toItem: scrollViewForImages, attribute: .centerX, multiplier: 1, constant: 0))
 //       addConstraint(NSLayoutConstraint(item: pageController, attribute: .centerX, relatedBy: .equal, toItem: viewForPageController, attribute: .centerX, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: recipeImageView, attribute: .centerY, relatedBy: .equal, toItem: scrollViewForImages, attribute: .centerY, multiplier: 1, constant: 0))
  //      addConstraint(NSLayoutConstraint(item: pageController, attribute: .centerY, relatedBy: .equal, toItem: viewForPageController, attribute: .centerY, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: dateLabel, attribute: .centerY, relatedBy: .equal, toItem: nameLabel, attribute: .centerY, multiplier: 1, constant: 0))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Init(coder!) has not been implemented")
    }
    
    //MARK: - DELEGATE
}

extension DetailRecipe: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let p = "Начинается прокрутка"
        print(p)
        print(scrollView.contentOffset.y)
    }
    
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        let p = "Гарант"
        print(p)
        self.scrollViewForImages.alpha = 1.0
    }
    
    private func currentPageIndex() -> Int {
        guard self.scrollViewForImages.bounds.size.width > 0 else {
            return 0
        }
        return Int(round(self.scrollViewForImages.contentOffset.x / self.scrollViewForImages.bounds.size.width))
    }
    
}
