//
//  ViewModelTable.swift
//  HW_7.2
//
//  Created by Elizaveta Rogozhina on 06.06.2021.
//

import Foundation
import Alamofire
import UIKit

protocol uploadInfo{
    func uploadAllInfo(names: [String], status: [String], last_loc: [String], species: [String], icons: [UIImage])
}

class ViewModelTable{
    
    private var info: [AllPersons.All_Info] = []
    
    var infoDelegate: uploadInfo?
    
    init(){
        uploadAllInfo()
    }
    
    func uploadAllInfo(){
        
        var names: [String] = [],
            status: [String] = [],
            last_loc: [String] = [],
            species: [String] = [],
            icon: [UIImage] = []
        
        TableLoader().loadTableAlamofire{ info in
            self.info = info
            DispatchQueue.main.async {
                for i in info{
                    for j in i.results{
                        names.append(j?.name ?? "Name not found")
                        status.append(j?.status ?? "Status not found")
                        species.append(j?.species ?? "Species not found")
                        last_loc.append(j?.location?.name ?? "Last location not found")
  
                        AF.request(URL(string: j!.image)!, method: .get).response{ response in
                            switch response.result {
                                case .success(let responseData):
                                    icon.append(UIImage(data: responseData!, scale:1) ?? .checkmark)
                                    if icon.count == last_loc.count{
                                        self.infoDelegate?.uploadAllInfo(names: names, status: status, last_loc: last_loc, species: species, icons: icon)
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
}
