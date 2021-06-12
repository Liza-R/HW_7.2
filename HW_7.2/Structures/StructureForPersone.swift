//
//  StructureForPersone.swift
//  HW_7.2
//
//  Created by Elizaveta Rogozhina on 06.06.2021.
//

import Foundation

class Persone{
    struct Persone_Info: Decodable{
        var id: Int,
        name: String,
        status: String,
        species: String,
        gender: String,
        location: Location?,
        image: String,
        episode: [String]
    }
    struct Location: Decodable{
        var name: String
    }
}
