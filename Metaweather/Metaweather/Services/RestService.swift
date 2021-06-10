//
//  RestService.swift
//  Metaweather
//
//  Created by Vladimir Vaskin on 10.06.2021.
//

import Foundation

public class RestService {
    
    public init() {
    }
    
    public func currentWeather(location: String, completion: @escaping  (String?) -> Void) {
        searchLocation(location: location) { [self] items in
            if let item = items?.first {
                print("\(item.title) \(item.woeid)")
                getWeather(woeid: item.woeid) { weatherItem in
                    if let weather: WeatherItem = weatherItem, let consolidate: ConsolidatedWeatherItem = weather.consolidated.first {
                        let weatherString = """
                            \(weather.title)
                            Температура: \(consolidate.theTemp)
                            Ветер: \(consolidate.windSpeed)
                            """
                        print(weatherString)
                        completion(weatherString)
                    } else {
                        completion(nil)
                    }
                }
            } else {
                completion(nil)
            }
        }
    }
    
    public func getWeather(woeid: Int, completion: @escaping  (WeatherItem?) -> Void) {
        if let urlString = URL(string: "https://www.metaweather.com/api/location/\(woeid)/") {
            getApiRequest(url: urlString, completion: { (items:WeatherItem?) in
                completion(items)
            })
        } else {
            print("Invalid URL")
            completion(nil)
        }
    }
    
    public func searchLocation(location: String, completion: @escaping  ([LocationItem]?) -> Void) {
        let trimmed = location.trimmingCharacters(in: NSCharacterSet.whitespaces)
        let urlString = "https://www.metaweather.com/api/location/search/?query=\(trimmed)"
        let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
     
        if let url = url {
            getApiRequest(url: url, completion: { (items:[LocationItem]?) in
                completion(items)
            })
        } else {
            print("Invalid URL")
            completion(nil)
        }
    }
    
    func getApiRequest<T: Decodable>(url: URL, completion: @escaping (T?) -> Void) {
        let urlSession = URLSession.shared
        let urlRequest = NSMutableURLRequest(
        url: url,
        cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
        timeoutInterval: 10.0 * 1000)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
     
        let task = urlSession.dataTask(with: urlRequest as URLRequest) { (data, response, error) -> Void in
            guard error == nil else {
                print("Error while fetching remote rooms: \(String(describing: error))")
                completion(nil)
                return
            }

            let fieldItems: T = try! JSONDecoder().decode(T.self, from: data!)
                
            //print("JSON: \(fieldItems)")

            completion(fieldItems)
        }
        task.resume()
    }
}

