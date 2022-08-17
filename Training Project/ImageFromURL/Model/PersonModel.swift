//
//  PersonModel.swift
//  Training Project
//
//  Created by VironIT on 8/17/22.
//

import Foundation

struct PersonModel: Codable {
    let age: Int
    let gender: String
    let imageURL: String
    
    enum CodingKeys: String, CodingKey {
        case age
        case gender
        case imageURL = "image_url"
    }
}
