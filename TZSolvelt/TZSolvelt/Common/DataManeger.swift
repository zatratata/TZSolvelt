//
//  DataManeger.swift
//  TZSolvelt
//
//  Created by Default User on 5/2/21.
//

import Foundation

final class DataManager {
    
    //MARK: - Constants
    private let jsonDataFileName = "generated"
    private let keyFoRLastUpdateTime = "keyFoRLastUpdateTimeInUserDefaults"
    private let cacheKey: NSString = "ClassRoomCacheKey"
    
    static let shared = DataManager()
    
    private init() {
    }
    
    //MARK: - Methods
    func fetchData(completion: @escaping (Result<[StudyingClassModel], Error>) -> ()) {
        let cache = NSCache<NSString, StudyingClassCacheModel>()
        let cacheObject: StudyingClassCacheModel
        
        if !self.isDataExpired(),
           let cachedVersion = cache.object(forKey: cacheKey) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                completion(.success(cachedVersion.classes))
            })
            
        } else {
            guard
                let url = Bundle.main.url(forResource: jsonDataFileName, withExtension: "json"),
                let data = try? Data(contentsOf: url),
                let classRoomData = try? JSONDecoder().decode([StudyingClassModel].self, from: data)
            else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                    completion(.success([]))
                })
                return
            }
            cacheObject = StudyingClassCacheModel(classes: classRoomData)
            cache.setObject(cacheObject, forKey: cacheKey)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                completion(.success(classRoomData))
            })
        }
    }
    
    private func saveLastUpdateTime() {
        let time = Date()
        if let data = try? JSONEncoder().encode(time) {
            UserDefaults.standard.set(data, forKey: self.keyFoRLastUpdateTime)
        }
    }
    
    private func isDataExpired() -> Bool {
        if let data = UserDefaults.standard.data(forKey: self.keyFoRLastUpdateTime),
           let time = try? JSONDecoder().decode(Date.self, from: data) {
            let now = Date()
            return Calendar.current.date(byAdding: .day, value: -1, to: now)! > time
        } else {
            return true
        }
    }
}
