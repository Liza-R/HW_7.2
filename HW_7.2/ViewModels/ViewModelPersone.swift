//
//  ViewModelPersone.swift
//  HW_7.2
//
//  Created by Elizaveta Rogozhina on 07.06.2021.
//

import Foundation
import Alamofire
import UIKit

protocol uploadPersone{
    func uploadPersoneInfo(name_: String, status_: String, gender_: String, last_loc_: String, species_: String, icon_: UIImage, id_: Int, episodes_names: [String], episodes_s_e: [String])
}

class ViewModelPersone{
    
    private var persone: [Persone.Persone_Info] = [],
                episodes: [Episode.Episode_Info] = []
    
    var personeDelegate: uploadPersone?
    
    init(){
        uploadPersoneInfo()
    }
    
    func uploadPersoneInfo(){
        var name: String = "Not Found",
            status: String = "Not Found",
            gender: String = "Not Found",
            last_loc: String = "Not Found",
            species: String = "Not Found",
            icon: UIImage = .checkmark,
            id: Int = 1,
            episodes_names: [String] = [],
            episodes_s_e: [String] = []
        
        PersoneLoader().loadPersoneAlamofire(id: personeID){ persone in
            self.persone = persone
            DispatchQueue.main.async {
                for i in persone{
                    name = i.name
                    status = i.status
                    gender = i.gender
                    last_loc = i.location?.name ?? "Last loc not found"
                    species = i.species
                    id = i.id
                    
                    AF.request(URL(string: i.image)!, method: .get).response{ response in
                        switch response.result {
                            case .success(let responseData):
                                icon = UIImage(data: responseData!, scale:1) ?? .checkmark
                                for link in i.episode{
                                    EpisodeLoader().loadEpisodeInfoAlamofire(url: link){ episodes in
                                        self.episodes = episodes
                                        DispatchQueue.main.async {
                                            for i in episodes{
                                                episodes_names.append(i.name)
                                                episodes_s_e.append(i.episode)
                                            }
                                            
                                            self.personeDelegate?.uploadPersoneInfo(name_: name, status_: status, gender_: gender, last_loc_: last_loc, species_: species, icon_: icon, id_: id, episodes_names: episodes_names, episodes_s_e: episodes_s_e)
                                        }
                                    }
                                } 
                            case .failure(let error):
                                print("error--->",error)
                        }
                    }
                }
            }
        }
    }
}
