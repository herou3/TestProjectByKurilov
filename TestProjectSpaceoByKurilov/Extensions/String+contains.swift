//
//  String.swift
//  TestProjectSpaceoByKurilov
//

import Foundation

extension String {
    
    func contains(find: String) -> Bool {
        return self.range(of: find) != nil
    }
}
