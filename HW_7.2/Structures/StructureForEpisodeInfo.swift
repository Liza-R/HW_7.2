//
//  StructureForEpisodeInfo.swift
//  HW_7.2
//
//  Created by Elizaveta Rogozhina on 09.06.2021.
//

import Foundation

class Episode{
    struct Episode_Info: Decodable{
        var id: Int,
        name: String,
        episode: String
    }
}
