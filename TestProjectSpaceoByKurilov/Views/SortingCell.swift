//
//  SortingCell.swift
//  TestProjectSpaceoByKurilov
//
//  Created by Pavel Kurilov on 29.05.2018.
//  Copyright © 2018 Pavel Kurilov. All rights reserved.
//

import UIKit

class SortingCell: BaseCell {
    
    //MARK: - Focused
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor.white : UIColor.rgb(34, 139, 34)
            
            nameLabel.textColor = isHighlighted ? UIColor.rgb(34, 139, 34) : UIColor.white
            iconImageView.tintColor = isHighlighted ? UIColor.rgb(34, 139, 34) : UIColor.white
        }
    }
    
    //MARK: - SetupViews
    override func setupViews() {
        super.setupViews()
        
        backgroundColor = UIColor.rgb(34, 139, 34)
        
        addSubview(nameLabel)
        addSubview(iconImageView)
        
        addConstraintsWithFormat(format: "H:|-10-[v0(30)]-10-[v1]|", views: iconImageView, nameLabel)
        addConstraintsWithFormat(format: "V:|[v0]|", views: nameLabel)
        addConstraintsWithFormat(format: "V:|-10-[v0(30)]-10-|", views: iconImageView)
    }
    
    var sorting: Sorting? {
        didSet {
            nameLabel.text = (sorting?.name).map { $0.rawValue }
            iconImageView.image = UIImage(named: (sorting?.imageView)!)?.withRenderingMode(.alwaysTemplate)
            iconImageView.tintColor = UIColor.white
        }
    }
    
    //MARK: - UIElements
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "String"
        label.textColor = .white
        return label
    }()
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "default-icon")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
}
