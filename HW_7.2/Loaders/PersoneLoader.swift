//
//  PersoneLoader.swift
//  HW_7.2
//
//  Created by Elizaveta Rogozhina on 07.06.2021.
//

import Foundation
import Alamofire

class PersoneLoader{
    func loadPersoneAlamofire(id: Int, completion: @escaping ([Persone.Persone_Info]) -> Void){
        AF.request(URL(string: changeURLPersone().changePersoneURL(id: id))!)
        .validate()
            .responseDecodable(of: Persone.Persone_Info.self) { (response) in
          guard let persone = response.value else { return }
                completion([persone])
        }
    }
}
