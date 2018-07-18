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

private struct Keys {
    static let name: String = "name"
    static let uuid: String = "uuid"
    static let images: String = "images"
    static let lastUpdated: String = "lastUpdated"
    static let description: String = "description"
    static let instructions: String = "instructions"
    static let difficulty: String = "difficulty"
}

struct Recipe: Codable {
    var uuid: String?
    var name: String?
    var images: [String]?
    var lastUpdated: Int?
    var description: String?
    var instructions: String?
    var difficulty: Int?
    
    init(json: JSON) {
        self.name = json[Keys.name].stringValue
        self.uuid = json[Keys.uuid].stringValue
        self.images = json[Keys.images].arrayObject as? [String]
        self.lastUpdated = json[Keys.lastUpdated].intValue
        self.description = json[Keys.description].stringValue
        self.instructions = json[Keys.instructions].stringValue
        self.difficulty = json[Keys.difficulty].intValue
    }
    
    init() { }
}
