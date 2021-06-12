//
//  ColorForStatus.swift
//  HW_7.2
//
//  Created by Elizaveta Rogozhina on 07.06.2021.
//

import Foundation
import UIKit

class ChangeColorStatus{
    func colorStatus(status: String) -> UIColor{
        var color: UIColor = .black
        switch status {
        case "Alive":
            color = .green
        case "Dead":
            color = .red
        case "unknown":
            color = .yellow
        case "Not Found":
            color = .black
        default:
            print("error in status color")
        }
        return color
    }
}
