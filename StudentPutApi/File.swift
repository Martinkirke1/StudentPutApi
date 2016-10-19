//
//  File.swift
//  StudentPutApi
//
//  Created by Martin Kirke on 10/19/16.
//  Copyright © 2016 Ghost. All rights reserved.
//

import Foundation

struct Student {
    
    
    // properties
    
    let name: String
    static let nameKey = "name"
    
    var dictionaryRepresentation: [String : AnyObject] {
        
        // name value --> ["name"}
        return [Student.nameKey: name as Any as AnyObject]
        
        var jsonData: Data? {
            
            return try? JSONSerialization.data(withJSONObject: dictionaryRepresentation, options: .prettyPrinted)
        }
    }
}

extension Student {
    
    init?(dictionary: [String : String]) {
        
        guard let name = dictionary[Student.nameKey] else { return nil }
        
        self.init(name: name)
        
    }
    
}
