//
//  Service.swift
//  TestProjectSpaceoByKurilov
//
//  Created by Pavel Kurilov on 02.07.2018.
//  Copyright © 2018 Pavel Kurilov. All rights reserved.
//

import Foundation
import TRON
import SwiftyJSON

struct Service {
    // MARK: - Propery
    let tron = TRON(baseURL: Constant.baseUrl)
    static let sharedInstance = Service()
    
    // MARK: - Action
    func featchHomeFeed(completion: @escaping (RecipeDataSource?, Error?) -> ()) {
        let request: APIRequest<RecipeDataSource, JSONError> = tron.swiftyJSON.request("recipes")
        request.perform(withSuccess: { (recipeDataSource) in
            completion(recipeDataSource, nil)
        }) { (err) in
            completion(nil, err)
        }
    }
    
    class JSONError: JSONDecodable {
        required init(json: JSON) throws {
            print("JSON Error")
        }
    }
}
