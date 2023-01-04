//
//  Product.swift
//  Pick and Pack
//
//  Created by BERRADA on 24/11/2021.
//

import Foundation

struct Product: Identifiable, Hashable, Comparable {
    static func < (lhs: Product, rhs: Product) -> Bool {
        lhs.name < rhs.name
    }
    
    var id: String
    var name: String
}
