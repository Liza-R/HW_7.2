//
//  AllLinks.swift
//  HW_7.2
//
//  Created by Elizaveta Rogozhina on 06.06.2021.
//

import Foundation

let linkForAll = "https://rickandmortyapi.com/api/character"

class changeURLPersone{
    func changePersoneURL(id: Int) -> String{
        let linkForPerson = "https://rickandmortyapi.com/api/character/\(id)"
        return linkForPerson
    }
    func changeEpisodeURL(numd: Int) -> String{
        let linkForPerson = "https://rickandmortyapi.com/api/episode/\(numd)"
        return linkForPerson
    }
}
