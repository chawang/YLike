//
//  Filters.swift
//  YLike
//
//  Created by Charles Wang on 10/26/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import Foundation

enum FilterIDs:Int {
    case sortBy, category
    
    func simpleDescription() -> String {
        switch self {
        case .sortBy:
            return "Sort By"
        case .category:
            return "Categories"
        }
    }
}

class Filters {
    var sections = [FilterIDs:[Any]]()
    
    init() {
        sections[.sortBy] = [YelpSortMode.bestMatched]
        sections[.category] = [String]()
    }
    
}
