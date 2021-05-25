//
//  FavouriteStationService.swift
//  MyTravelHelper
//
//  Created by Rahul Gera on 25/05/21.
//  Copyright © 2021 Sample. All rights reserved.
//

import Foundation
class FavouriteStationService {
    private let kSourceStation = "SourceStation"
    private let kDestinationStation = "DestinationStation"
    
    private var userDefault: UserDefaults {
        return UserDefaults.standard
    }
    
    var sourceStation:String? {
        get {
            userDefault.value(forKey: kSourceStation) as? String
        }
        set(newValue){
            userDefault.set(newValue, forKey: kSourceStation)
        }
    }
    
    var destinationStation:String? {
        get {
            userDefault.value(forKey: kDestinationStation) as? String
        }
        set(newValue){
            userDefault.set(newValue, forKey: kDestinationStation)
        }
    }
    
}
