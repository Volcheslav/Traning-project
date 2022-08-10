//
//  Currency.swift
//  Training Project
//
//  Created by VironIT on 8/10/22.
//

import Foundation

struct Currency: Codable {
let id: Int
   let code: String
   let abbreviation: String
   let name: String
    
    private enum CodingKeys: String, CodingKey {
       case id = "Cur_ID"
       case code = "Cur_Code"
        case abbreviation = "Cur_Abbreviation"
        case name = "Cur_Name"
    }
}
