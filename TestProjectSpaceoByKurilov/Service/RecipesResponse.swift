//
//  RecipeDataSource.swift
//  TestProjectSpaceoByKurilov
//
//  Created by Pavel Kurilov on 02.07.2018.
//  Copyright © 2018 Pavel Kurilov. All rights reserved.
//

import LBTAComponents
import SwiftyJSON
import TRON

struct RecipesResponse: JSONDecodable {
    // MARK: - Property
    let recipes: [Recipe]
    
    init(json: JSON) throws {
        print(json)
        guard let userJsonArray = json["recipes"].array else {
                throw NSError(domain: "ru.test.space-o",
                              code: 1,
                              userInfo: [NSLocalizedDescriptionKey: "Parsing JSON is not valid"])
        }
        self.recipes = userJsonArray.map({Recipe(json: $0)})
    }
}
