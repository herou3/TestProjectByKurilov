//
//  Recipe.swift
//  TestProjectSpaceoByKurilov
//
//  Created by Pavel Kurilov on 29.05.2018.
//  Copyright © 2018 Pavel Kurilov. All rights reserved.
//

import UIKit

class Recipe: NSObject {
    var uuid: String?
    var name: String?
    var images: [String]?
    var lastUpdated: Int?
    var descriptionDetail: String?
    var instructions: String?
    var difficulty: Int?
    override init() {
    }
    init(uuid: String,
         name: String,
         images: [String],
         lastUpdated: Int,
         descriptionDetail: String,
         instructions: String,
         difficulty: Int) {
        super.init()
        self.uuid = uuid
        self.name = name
        self.images = images
        self.lastUpdated = lastUpdated
        self.descriptionDetail = descriptionDetail
        self.instructions = instructions
        self.difficulty = difficulty
    }
}
