//
//  EpisodeInfoLoader.swift
//  HW_7.2
//
//  Created by Elizaveta Rogozhina on 09.06.2021.
//

import Foundation

import Alamofire

class EpisodeLoader{
    func loadEpisodeInfoAlamofire(url: String, completion: @escaping ([Episode.Episode_Info]) -> Void){
        AF.request(url)
        .validate()
            .responseDecodable(of: Episode.Episode_Info.self) { (response) in
          guard let episode = response.value else { return }
                completion([episode])
        }
    }
}
