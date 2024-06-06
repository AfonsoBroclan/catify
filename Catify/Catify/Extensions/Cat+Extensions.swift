//
//  Cat+Extensions.swift
//  Catify
//
//  Created by Afonso Rosa on 05/06/2024.
//

import Foundation

extension Collection where Element == Cat {

    var noDuplicates: [Cat] {

        Set(self).map { $0 }
    }
}
