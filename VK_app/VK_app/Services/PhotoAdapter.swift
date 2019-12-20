//
//  PhotoAdapter.swift
//  VK_app
//
//  Created by Aleksandr Fetisov on 20.12.2019.
//  Copyright © 2019 Aleksandr Fetisov. All rights reserved.
//

import Foundation
import RealmSwift

class PhotoAdapter {
    
    private let realmService = RealmService()
    private var realmNotificationTokens: [String: NotificationToken] = [:]
    
    func getPhoto(from friendId: Int, at indexPath: IndexPath) -> Photo{
        let photos = try? RealmService.getData(type: Photo.self).filter("ownerId == [cd] %@", String(friendId))
        var photo = Photo()
        if let ph = photos?[indexPath.row] {
            photo = ph
        }
        return photo
    }
}

    
//        func getWeathers(inCity city: String, then completion: @escaping ([Photo]) -> Void) {
//            guard let realm = try? Realm()
//                , let realmCity = realm.object(ofType: Results<Photo>?, forPrimaryKey: city)
//                else { return }
//
//            self.realmNotificationTokens[city]?.invalidate()
//
//            let token = realmCity.weathers.addNotificationBlock { [weak self] (changes: RealmCollectionChange) in
//                guard let self = self else { return }
//                switch changes {
//                case .update(let realmWeathers, _, _, _):
//                    var weathers: [Weather] = []
//                    for realmWeather in realmWeathers {
//                        weathers.append(self.weather(from: realmWeather))
//                    }
//                    self.realmNotificationTokens[city]?.stop()
//                    completion(weathers)
//                case .error(let error):
//                    fatalError("\(error)")
//                case .initial:
//                    break
//                }
//            }
//            self.realmNotificationTokens[city] = token
//
//            weatherService.loadWeatherData(city: city)
//        }
//
//        private func weather(from rlmWeather: RLMWeather) -> Photo {
//            return Weather(cityName: rlmWeather.city,
//                           date: Date(timeIntervalSince1970: rlmWeather.date),
//                           temperature: rlmWeather.temp,
//                           pressure: rlmWeather.pressure,
//                           humidity: Double(rlmWeather.humidity),
//                           weatherName: rlmWeather.weatherName,
//                           weatherIconName: rlmWeather.weatherIcon,
//                           windSpeed: rlmWeather.windSpeed,
//                           windDegrees: rlmWeather.windDegrees)
//        }
//    }

