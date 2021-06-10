//
//  WeatherItem.swift
//  Metaweather
//
//  Created by Vladimir Vaskin on 10.06.2021.
//

import Foundation

public struct ConsolidatedWeatherItem: Codable {
    var humidity: Int
    var theTemp: Float
    var maxTemp: Float
    var minTemp: Float
    var windSpeed: Float
    
    enum CodingKeys: String, CodingKey {
        case humidity
        case theTemp = "the_temp"
        case maxTemp = "max_temp"
        case minTemp = "min_temp"
        case windSpeed = "wind_speed"
    }
}

public struct WeatherItem: Codable {
    var consolidated: [ConsolidatedWeatherItem]
    var title: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case consolidated = "consolidated_weather"
    }
}
