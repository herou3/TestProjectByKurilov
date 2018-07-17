//
//  DetailRecipeView.swift
//  TestProjectSpaceoByKurilov
//
//  Created by Pavel Kurilov on 17.05.2018.
//  Copyright © 2018 Pavel Kurilov. All rights reserved.
//

import LBTAComponents

class DetailRecipeView: UIView {
// MARK: - Property
    var scrollSize: Int = 0
    var imageViewRect: CGRect = CGRect()
    var pageControl = UIPageControl()
    
    var recipe: Recipe? {
        didSet {
            nameRecipeLabel.text = recipe?.name
            if recipe?.images != nil {
                imageViewRect = self.scrollViewForImages.bounds
                setupRecipeImage()
                guard let imagesCount = recipe?.images?.count else {
                    return
                }
                if imagesCount != 0 && imagesCount != 1 {
                    pageControl.numberOfPages = imagesCount
                }
            } else {
                recipeImageView.image = UIImage(named: "deffualt")
            }
            if recipe?.description == nil || recipe?.description == "" {
                descriptionTextLabel.text = "No description"
            } else {
                descriptionTextLabel.text = recipe?.description
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
        self.scrollViewForImages.contentSize = CGSize(width: self.bounds.size.width,
                                                      height: self.bounds.size.height / 4)
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPageIndicatorTintColor = UIColor.darkGreen
        viewForPageControl.addSubview(pageControl)
    }
    
// MARK: - Methods
    private func setupRecipeImage() {
        if let recipeImageViewURL = recipe?.images {
            for value in 0..<recipeImageViewURL.count {
                let imageView = CachedImageView()
                let indentationX = self.scrollViewForImages.frame.size.width * CGFloat(value)
                imageView.frame = CGRect(x: indentationX, y: 0,
                                         width: self.scrollViewForImages.frame.width - Constant.marginLeftAndRight,
                                         height: self.scrollViewForImages.frame.height)
                imageView.contentMode = .scaleAspectFit
                imageView.loadImage(urlString: recipeImageViewURL[value])
                    self.scrollViewForImages.contentSize.width = self.scrollViewForImages.frame.size.width *
                    CGFloat(value + 1)
                if imageView.image == nil {
                    imageView.image = #imageLiteral(resourceName: "deffualt")
                }
                  self.scrollViewForImages.addSubview(imageView)
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
        guard let difficulty = recipe?.difficulty else {
            return
        }
        for index in 0...(difficulty - 1) {
            guard let obj = difficultyStackView.arrangedSubviews[index] as?  UIImageView else { return }
            obj.image = UIImage(named: "star-icon")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        }
    }
// MARK: - Create UIView
    private let scrollViewForImages: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.frame = CGRect(x: 0,
                                  y: 0,
                                  width: UIScreen.main.bounds.width - Constant.marginLeftAndRight,
                                  height: UIScreen.main.bounds.height / 3)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    private let recipeImageView: CachedImageView = {
        let imageView = CachedImageView()
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
    private let nameRecipeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.darkGreen
        label.numberOfLines = 3
        return label
    }()
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.darkGreen
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
        textLabel.textColor = UIColor.descriptionText
        textLabel.font = UIFont.systemFont(ofSize: 14)
        textLabel.numberOfLines = 3
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
        textView.textColor = UIColor.descriptionText
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
        addSubview(scrollViewForImages)
        addSubview(viewForPageControl)
        addSubview(nameRecipeLabel)
        addSubview(dateLabel)
        addSubview(helpDifficultyLabel)
        addSubview(difficultyStackView)
        addSubview(helpDescriptionLabel)
        addSubview(descriptionTextLabel)
        addSubview(helpInstructionLabel)
        addSubview(instructionTextView)
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
        scrollViewForImages.anchor(self.topAnchor,
                                   left: self.leftAnchor,
                                   bottom: nil,
                                   right: self.rightAnchor,
                                   topConstant: 16,
                                   leftConstant: 16,
                                   bottomConstant: 0,
                                   rightConstant: 16,
                                   widthConstant: 0,
                                   heightConstant: UIScreen.main.bounds.height / 3)
        viewForPageControl.anchor(scrollViewForImages.bottomAnchor,
                                  left: self.leftAnchor,
                                  bottom: nil,
                                  right: self.rightAnchor,
                                  topConstant: 16,
                                  leftConstant: 0,
                                  bottomConstant: 0,
                                  rightConstant: 0,
                                  widthConstant: 0,
                                  heightConstant: 4)
        nameRecipeLabel.anchor(viewForPageControl.bottomAnchor,
                               left: self.leftAnchor,
                               bottom: nil,
                               right: nil,
                               topConstant: 8,
                               leftConstant: 16,
                               bottomConstant: 0,
                               rightConstant: 0,
                               widthConstant: 190,
                               heightConstant: 62)
        dateLabel.anchor(nameRecipeLabel.topAnchor,
                         left: nameRecipeLabel.rightAnchor,
                         bottom: nil,
                         right: self.rightAnchor,
                         topConstant: 0,
                         leftConstant: 8,
                         bottomConstant: 0,
                         rightConstant: 16,
                         widthConstant: 0,
                         heightConstant: 62)
        helpDifficultyLabel.anchor(nameRecipeLabel.bottomAnchor,
                                   left: nameRecipeLabel.leftAnchor,
                                   bottom: nil,
                                   right: dateLabel.rightAnchor,
                                   topConstant: 8,
                                   leftConstant: 0,
                                   bottomConstant: 0,
                                   rightConstant: 0,
                                   widthConstant: 0,
                                   heightConstant: 12)
        difficultyStackView.anchor(helpDifficultyLabel.bottomAnchor,
                                   left: helpDifficultyLabel.leftAnchor,
                                   bottom: nil,
                                   right: dateLabel.rightAnchor,
                                   topConstant: 8,
                                   leftConstant: 0,
                                   bottomConstant: 0,
                                   rightConstant: 0,
                                   widthConstant: 0,
                                   heightConstant: 50)
        helpDescriptionLabel.anchor(difficultyStackView.bottomAnchor,
                                    left: difficultyStackView.leftAnchor,
                                    bottom: nil,
                                    right: self.rightAnchor,
                                    topConstant: 8,
                                    leftConstant: 0,
                                    bottomConstant: 0,
                                    rightConstant: 16,
                                    widthConstant: 0,
                                    heightConstant: 12)
        descriptionTextLabel.anchor(helpDescriptionLabel.bottomAnchor,
                                    left: helpDescriptionLabel.leftAnchor,
                                    bottom: nil,
                                    right: self.rightAnchor,
                                    topConstant: 4,
                                    leftConstant: 0,
                                    bottomConstant: 0,
                                    rightConstant: 16,
                                    widthConstant: 0,
                                    heightConstant: 40)
        helpInstructionLabel.anchor(descriptionTextLabel.bottomAnchor,
                                    left: descriptionTextLabel.leftAnchor,
                                    bottom: nil,
                                    right: self.rightAnchor,
                                    topConstant: 4,
                                    leftConstant: 0,
                                    bottomConstant: 0,
                                    rightConstant: 16,
                                    widthConstant: 0,
                                    heightConstant: 12)
        instructionTextView.anchor(helpInstructionLabel.bottomAnchor,
                                   left: descriptionTextLabel.leftAnchor,
                                   bottom: self.bottomAnchor,
                                   right: self.rightAnchor,
                                   topConstant: 4,
                                   leftConstant: 0,
                                   bottomConstant: 4,
                                   rightConstant: 16,
                                   widthConstant: 0,
                                   heightConstant: 0)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("Init(coder!) has not been implemented")
    }
}

// MARK: - DELEGATE
extension DetailRecipeView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = currentPageIndex()
    }
    
    private func currentPageIndex() -> Int {
        guard self.scrollViewForImages.bounds.size.width > 0 else {
            return 0
        }
        return Int(round(self.scrollViewForImages.contentOffset.x / self.scrollViewForImages.bounds.size.width))
    }
}
