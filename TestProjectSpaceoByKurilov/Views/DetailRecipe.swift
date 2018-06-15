//
//  DetailRecipe.swift
//  TestProjectSpaceoByKurilov
//
//  Created by Pavel Kurilov on 17.05.2018.
//  Copyright © 2018 Pavel Kurilov. All rights reserved.
//

import UIKit

class DetailRecipe: UIView {
// MARK: - Property
    var scrollSize: Int = 0
    var imageViewRect: CGRect = CGRect()
    var pageControl = UIPageControl()
    var recipe: Recipe? {
        didSet {
            nameLabel.text = recipe?.name
            if recipe?.images != nil {
                imageViewRect = self.scrollViewForImages.bounds
                setupRecipeImage()
                if recipe?.images?.count != 0 && recipe?.images?.count != 1 {
                    pageControl.numberOfPages = (recipe?.images?.count)!
                }
            } else {
                recipeImageView.image = UIImage(named: "deffualt")
            }
            if recipe?.descriptionDetail == nil || recipe?.descriptionDetail == "" {
                descriptionTextLabel.text = "No description"
            } else {
                descriptionTextLabel.text = recipe?.descriptionDetail
            }
            if recipe?.difficulty != nil {
                setupDifficultyStatus()
            }
            instructionTextView.text = recipe?.instructions?.replacingOccurrences(of: "<br>", with: "\n")
            if recipe?.lastUpdated != 0 {
                dateLabel.text = convertUnixTime(timeInterval: Double((recipe?.lastUpdated)!))
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        if recipe?.images != nil {
            scrollSize = (recipe?.images?.count)!
        }
        setupViews()
        self.scrollViewForImages.contentSize = CGSize(width: self.bounds.size.width, height: self.bounds.size.height / 4)
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPageIndicatorTintColor = UIColor.rgb(0, 100, 0)
        viewForPageControl.addSubview(pageControl)
    }
// MARK: - Methods
    private func setupRecipeImage() {
        if let recipeImageViewURL = recipe?.images {
           // var i = 0
            for value in 0..<recipeImageViewURL.count {
                let url = URL(string: recipeImageViewURL[value])
                URLSession.shared.dataTask(with: url!) { (data, _, error) in
                    if error != nil {
                        print(error ?? "Error")
                    }
                    DispatchQueue.main.async {
                        let imageView = UIImageView()
                        let indentationX = self.scrollViewForImages.frame.size.width * CGFloat(value)
                        imageView.frame = CGRect(x: indentationX, y: 0, width: self.scrollViewForImages.frame.width, height: self.scrollViewForImages.frame.height)
                        imageView.contentMode = .scaleAspectFit
                        if data != nil {
                            imageView.image = UIImage(data: data!)
                        } else {
                            imageView.image = UIImage(named: "deffualt")
                        }
                        self.scrollViewForImages.contentSize.width = self.scrollViewForImages.frame.size.width * CGFloat(value + 1)
                        self.scrollViewForImages.addSubview(imageView)
                    }
                }.resume()
            }
        }
    }
    private func convertUnixTime(timeInterval: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timeInterval)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: date)
    }
    private func setupDifficultyStatus() {
        for index in 0...(recipe!.difficulty! - 1) {
            guard let obj = difficultyStackView.arrangedSubviews[index] as?  UIImageView else { return }
            obj.image = UIImage(named: "star-icon")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        }
    }
// MARK: - Create UIView for cell
    private let scrollViewForImages: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    private let recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "image-not-found")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    private let viewForPageControl: UIView = {
        let viewForPage = UIView()
        viewForPage.backgroundColor = .white
        return viewForPage
    }()
    private let pageController: UIPageControl = {
        let pageController = UIPageControl()
        return pageController
    }()
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.rgb(0, 100, 0)
        label.numberOfLines = 3
        return label
    }()
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.rgb(115, 153, 87)
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
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let descriptionTextLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
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
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let instructionTextView: UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = true
        textView.isEditable = false
        textView.font = UIFont.systemFont(ofSize: 12)
        textView.textColor = UIColor.rgb(60, 179, 113)
        textView.translatesAutoresizingMaskIntoConstraints = true
        return textView
    }()
    private let helpDifficultyLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "Difficulty"
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let difficultyStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis  = UILayoutConstraintAxis.horizontal
        stackView.alignment = UIStackViewAlignment.center
        stackView.distribution = UIStackViewDistribution.fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    func setupViews() {
        addSubview(instructionTextView)
        addSubview(scrollViewForImages)
        addSubview(viewForPageControl)
        addSubview(nameLabel)
        addSubview(dateLabel)
        addSubview(helpDescriptionLabel)
        addSubview(descriptionTextLabel)
        addSubview(helpInstructionLabel)
        addSubview(helpDifficultyLabel)
        addSubview(difficultyStackView)
        scrollViewForImages.delegate = self
        let intY: Int = 5
        for _ in 1...intY {
            let gubaButton: UIImageView = {
                let imageView = UIImageView()
                imageView.image = UIImage(named: "startDefault-icon")?.withRenderingMode(.alwaysOriginal)
                imageView.contentMode = .scaleAspectFit
                return imageView
            }()
            addSubview(gubaButton)
            difficultyStackView.addArrangedSubview(gubaButton)
        }
        // Constraints V
        addConstraintsWithFormat(format: "V:|-8-[v0(256)]-16-[v1(4)]-4-[v2(62)]-4-[v3(12)]-6-[v4(50)]-6-[v5(12)]-0-[v6(40)]-6-[v7(12)]-0-[v8]-6-|", views: scrollViewForImages, viewForPageControl, nameLabel, helpDifficultyLabel, difficultyStackView,  helpDescriptionLabel,  descriptionTextLabel, helpInstructionLabel, instructionTextView)
        // Constraints H
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: scrollViewForImages)
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: viewForPageControl)
        addConstraintsWithFormat(format: "H:|-16-[v0]-8-[v1(100)]-16-|", views: nameLabel, dateLabel)
        addConstraintsWithFormat(format: "H:|-16-[v0]|", views: helpDescriptionLabel)
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: descriptionTextLabel)
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: helpInstructionLabel)
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: instructionTextView)
        addConstraintsWithFormat(format: "H:|-16-[v0]|", views: helpDifficultyLabel)
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: difficultyStackView)
        addConstraint(NSLayoutConstraint(item: scrollViewForImages, attribute: .height, relatedBy: .equal, toItem: scrollViewForImages, attribute: .height, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: scrollViewForImages, attribute: .width, relatedBy: .equal, toItem: scrollViewForImages, attribute: .width, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: dateLabel, attribute: .centerY, relatedBy: .equal, toItem: nameLabel, attribute: .centerY, multiplier: 1, constant: 0))
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("Init(coder!) has not been implemented")
    }
}
// MARK: - DELEGATE
extension DetailRecipe: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.y)
        pageControl.currentPage = currentPageIndex()
    }
    private func currentPageIndex() -> Int {
        guard self.scrollViewForImages.bounds.size.width > 0 else {
            return 0
        }
        return Int(round(self.scrollViewForImages.contentOffset.x / self.scrollViewForImages.bounds.size.width))
    }
}
