//
//  RecipeStruct.swift
//  TestProjectSpaceoByKurilov
//
//  Created by Pavel Kurilov on 29.05.2018.
//  Copyright © 2018 Pavel Kurilov. All rights reserved.
//

import Foundation

struct RecipeStruct: Codable {
    var uuid: String?
    var name: String?
    var images: [String]?
    var lastUpdated: Int?
    var description: String?
    var instructions: String?
    var difficulty: Int? // Можно было сделать Enum, но я принял решение оставить так
}
