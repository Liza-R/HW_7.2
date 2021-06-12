//
//  StructureForTable.swift
//  HW_7.2
//
//  Created by Elizaveta Rogozhina on 06.06.2021.
//

import Foundation

class AllPersons{
    struct All_Info: Decodable{
        var results: [Results?]
    }
    struct Results: Decodable{
        var id: Int,
        name: String,
        status: String,
        species: String,
        location: Location?,
        image: String
    }
    struct Location: Decodable{
        var name: String
    }
}
