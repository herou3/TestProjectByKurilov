//
//  RecipeStruct.swift
//  TestProjectSpaceoByKurilov
//
//  Created by Pavel Kurilov on 29.05.2018.
//  Copyright © 2018 Pavel Kurilov. All rights reserved.
//

import UIKit
import SwiftyJSON
import TRON

struct Recipe: Codable {
    var uuid: String?
    var name: String?
    var images: [String]?
    var lastUpdated: Int?
    var description: String?
    var instructions: String?
    var difficulty: Int?
    init(json: JSON) {
        self.name = json["name"].stringValue
        self.uuid = json["uuid"].stringValue
        self.images = json["images"].arrayObject as? [String]
        self.lastUpdated = json["lastUpdated"].intValue
        self.description = json["description"].stringValue
        self.instructions = json["instructions"].stringValue
        self.difficulty = json["difficulty"].intValue
    }
    init() { }
}
