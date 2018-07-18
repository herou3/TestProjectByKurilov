//
//  DetailRecipeView.swift
//  TestProjectSpaceoByKurilov
//

import LBTAComponents
import SnapKit

class DetailRecipeView: UIView {
// MARK: - Property
    var scrollSize: Int = 0
    var imageViewRect: CGRect = CGRect()
    var pageControl = UIPageControl()
    var sizeView: CGFloat = 0
    var recipeImagesArray: [String]?
    
    // MARK: - Init View
    override init(frame: CGRect) {
        super.init(frame: frame)
        if recipeImagesArray != nil {
            scrollSize = (recipeImagesArray!.count)
        }
        setupViews()
        self.scrollViewForImages.contentSize = CGSize(width: self.bounds.size.width,
                                                      height: self.bounds.size.height / 4)
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPageIndicatorTintColor = UIColor.darkGreen
        viewForPageControl.addSubview(pageControl)
    }
    
// MARK: - Methods
    private func setupRecipeImage(recipeImages: [String]?) {
        if let recipeImageViewURL = recipeImages {
            guard let imagesArray = recipeImages else { return }
            for value in 0..<imagesArray.count {
                if value < Constant.maxImagesCount {
                    let imageView = CachedImageView()
                    let indentationX = self.scrollViewForImages.frame.size.width * CGFloat(value)
                    imageView.frame = CGRect(x: indentationX, y: 0,
                                             width: self.scrollViewForImages.frame.width,
                                             height: self.scrollViewForImages.frame.height)
                    imageView.contentMode = .scaleAspectFit
                    imageView.loadImage(urlString: recipeImageViewURL[value])
                        self.scrollViewForImages.contentSize.width = self.scrollViewForImages.frame.size.width *
                        CGFloat(value + 1)
                    if imageView.image == nil {
                        imageView.image = #imageLiteral(resourceName: "image-not-found")
                    }
                      self.scrollViewForImages.addSubview(imageView)
                }
            }
        }
    }
    
    private func setupDifficultyStatus(difficultyValue: Int?) {
        guard let difficulty = difficultyValue else {
            return
        }
        for index in 0...(difficulty - 1) {
            guard let obj = difficultyStackView.arrangedSubviews[index] as?  UIImageView else { return }
            obj.image = UIImage(named: "star-icon")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        }
    }
    
// MARK: - Create UIElements
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
        imageView.image = #imageLiteral(resourceName: "image-not-found")
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
    private let nameRecipeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.darkGreen
        label.numberOfLines = 5
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
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = true
        textView.textColor = UIColor.descriptionText
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.isScrollEnabled = false
        return textView
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
        textView.translatesAutoresizingMaskIntoConstraints = false
                textView.isScrollEnabled = false
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
    
    // MARK: - Configurate DetailRecipeView
   private  func addScrollViewForImages() {
        addSubview(scrollViewForImages)
        scrollViewForImages.snp.makeConstraints { (make) in
            make.height.equalTo(200)
            make.top.left.equalTo(self).offset(16)
            make.right.equalTo(self).offset(-16)
        }
    }
    
    private func addViewForPageControl() {
        addSubview(viewForPageControl)
        viewForPageControl.snp.makeConstraints { (make) in
            make.top.equalTo(scrollViewForImages.snp.bottom).offset(8)
            make.left.equalTo(self).offset(16)
            make.right.equalTo(self).offset(-16)
        }
    }
    
    private func addNameRecipeLabel() {
        addSubview(nameRecipeLabel)
        nameRecipeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(viewForPageControl.snp.bottom).offset(8)
            make.left.equalTo(self).offset(16)
            make.right.equalToSuperview().dividedBy(2)
        }
    }
    
    private func addDateLabel() {
        addSubview(dateLabel)
        dateLabel.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-16)
            make.left.equalTo(nameRecipeLabel.snp.left)
            make.top.equalTo(viewForPageControl.snp.bottom).offset(8)
        }
    }
    
    private func addHelpDifficultyLabel() {
        addSubview(helpDifficultyLabel)
        helpDifficultyLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameRecipeLabel.snp.bottom).offset(8)
            make.left.equalTo(self).offset(16)
            make.right.equalTo(self).offset(-16)
        }
    }
    
    private func addDifficultyStackView() {
        addSubview(difficultyStackView)
        difficultyStackView.snp.makeConstraints { (make) in
            make.top.equalTo(helpDifficultyLabel.snp.bottom).offset(-24)
            make.left.equalTo(self).offset(16)
            make.right.equalTo(self).offset(-16)
        }
    }
    
    private func addHelpDescriptionLabel() {
        addSubview(helpDescriptionLabel)
        helpDescriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(difficultyStackView.snp.bottom).offset(-24)
            make.left.equalTo(self).offset(16)
            make.right.equalTo(self).offset(-16)
        }
    }
    
    private func addDescriptionTextView() {
         addSubview(descriptionTextView)
        descriptionTextView.snp.makeConstraints { (make) in
            make.top.equalTo(helpDescriptionLabel.snp.bottom).offset(4)
            make.left.equalTo(self).offset(16)
            make.right.equalTo(self).offset(-16)
        }
    }
    
    private func addHelpInstructionLabel() {
         addSubview(helpInstructionLabel)
        helpInstructionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(descriptionTextView.snp.bottom).offset(4)
            make.left.equalTo(self).offset(16)
            make.right.equalTo(self).offset(-16)
        }
    }
    
    private func addInstructionTextView() {
        addSubview(instructionTextView)
        instructionTextView.snp.makeConstraints { (make) in
            make.top.equalTo(helpInstructionLabel.snp.bottom).offset(4)
            make.left.equalTo(self).offset(16)
            make.right.equalTo(self).offset(-16)
            make.bottom.equalTo(self).offset(-16)
        }
    }
    
    func configurateStarsCount() {
        let starCount: Int = 5
        for _ in 1...starCount {
            let starImage: UIImageView = {
                let imageView = UIImageView()
                imageView.image = UIImage(named: "startDefault-icon")?.withRenderingMode(.alwaysOriginal)
                imageView.contentMode = .scaleAspectFit
                return imageView
            }()
            addSubview(starImage)
            difficultyStackView.addArrangedSubview(starImage)
        }
    }
    
    func setupViews() {
        scrollViewForImages.delegate = self
        addScrollViewForImages()
        addViewForPageControl()
        addNameRecipeLabel()
        addDateLabel()
        addHelpDifficultyLabel()
        addDifficultyStackView()
        addHelpDescriptionLabel()
        addDescriptionTextView()
        addHelpInstructionLabel()
        addInstructionTextView()
        configurateStarsCount()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Init(coder!) has not been implemented")
    }
    
    func configureDataForDetailView(recipeName: String?,
                                    recipeImages: [String]?,
                                    recipeDescription: String?,
                                    recipeDifficulty: Int?,
                                    recipeInstructions: String?,
                                    recipeLastUpdatedСonverted: String) {
        nameRecipeLabel.text = recipeName
        if recipeImages != nil {
            imageViewRect = self.scrollViewForImages.bounds
            setupRecipeImage(recipeImages: recipeImages)
            guard let imagesCount = recipeImages?.count else {
                return
            }
            if imagesCount != 0 && imagesCount != 1 {
                pageControl.numberOfPages = imagesCount
                if imagesCount > Constant.maxImagesCount {
                    pageControl.numberOfPages = Constant.maxImagesCount
                }
            }
        } else {
            recipeImageView.image = UIImage(named: "deffualt")
        }
        if recipeDescription == nil || recipeDescription == "" {
            descriptionTextView.text = "No description"
        } else {
            descriptionTextView.text = recipeDescription
        }
        if recipeDifficulty != nil {
            setupDifficultyStatus(difficultyValue: recipeDifficulty)
        }
        instructionTextView.text = recipeInstructions
        dateLabel.text = recipeLastUpdatedСonverted
        self.recipeImagesArray = recipeImages
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
