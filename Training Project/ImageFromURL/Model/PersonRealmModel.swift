//
//  PersonRealmModel.swift
//  Training Project
//
//  Created by VironIT on 8/17/22.
//
import RealmSwift
import UIKit

class PersonRealm: Object {
    @objc dynamic var name = ""
    @objc dynamic var surname = ""
    @objc dynamic var imageURL: String = ""
}
