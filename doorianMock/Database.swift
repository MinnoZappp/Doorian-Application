//
//  Database.swift
//  doorianMock
//
//  Created by Samitanun Sapsukdee on 19/4/2566 BE.
//

import Foundation

final class Database {
    private let FAV_KEY = "fav_key"
    
    func save(items: Set<String>) {
        let array = Array(items)
        UserDefaults.standard.set(array, forKey: FAV_KEY)
    }
    
    func load() -> Set<String> {
        let array = UserDefaults.standard.array(forKey: FAV_KEY) as? [String] ?? [String]()
        return Set(array)
    }
}
