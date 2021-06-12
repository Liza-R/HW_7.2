//
//  TableLoader.swift
//  HW_7.2
//
//  Created by Elizaveta Rogozhina on 06.06.2021.
//

import Foundation
import Alamofire

class TableLoader{
    func loadTableAlamofire(completion: @escaping ([AllPersons.All_Info]) -> Void){
        AF.request(URL(string: linkForAll)!)
        .validate()
            .responseDecodable(of: AllPersons.All_Info.self) { (response) in
          guard let info = response.value else { return }
                completion([info])
        }
    }
}
