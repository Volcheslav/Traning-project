//
//  BarsProtocol.swift
//  Training Project
//
//  Created by VironIT on 8/3/22.
//

import UIKit

protocol BarState {

    func changeTabBarState(_ isHidden: Bool)

}

protocol NavbarAndTabBar: BarState {
    func changeNavBarState(_ isHidden: Bool)
}
