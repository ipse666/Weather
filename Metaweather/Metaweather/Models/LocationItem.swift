//
//  LocationItem.swift
//  Metaweather
//
//  Created by Vladimir Vaskin on 10.06.2021.
//

import Foundation

public struct LocationItem: Codable {
    var title: String
    var locationType: String
    var lattLong: String
    var woeid: Int
    var distance: Int?
    
    enum CodingKeys: String, CodingKey {
        case woeid, title, distance
        case lattLong = "latt_long"
        case locationType = "location_type"
    }
}


