//
//  LabelProtocol.swift
//  Training Project
//
//  Created by VironIT on 8/3/22.
//

import UIKit

protocol LabelProtocol {
    var someLabelText: String? { get set }
    
}

extension LabelProtocol {
    
    mutating func setText(_ someText: String) {
        self.someLabelText = someText
    }
}
