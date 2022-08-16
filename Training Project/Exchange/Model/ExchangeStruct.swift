//
//  ExchangeStruct.swift
//  Training Project
//
//  Created by VironIT on 8/10/22.
//

import UIKit

let url = "https://www.nbrb.by/api/exrates/rates/usd?parammode=2"

struct Exchange: Codable {
    let id: Int
    let date: String
    let abbreviation: String
    let scale: Int
    let name:String
    let rate: Double
    
    private enum CodingKeys: String, CodingKey {
        case id = "Cur_ID"
        case date = "Date"
        case abbreviation = "Cur_Abbreviation"
        case scale = "Cur_Scale"
        case name = "Cur_Name"
        case rate = "Cur_OfficialRate"
        
    }
    
    init() {
        self.id = 0
        self.date = ""
        self.abbreviation = ""
        self.scale = 0
        self.name = ""
        self.rate = 0
    }
    
    init(id: Int, date: String, abbreviation: String, scale: Int, name: String, rate: Double) {
        self.id = id
        self.date = date
        self.abbreviation = abbreviation
        self.scale = scale
        self.name = name
        self.rate = rate
    }
}
