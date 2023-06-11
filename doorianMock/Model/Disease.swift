//
//  Disease.swift
//  doorianMock
//
//  Created by Warunya on 2/5/2566 BE.
//

import Foundation

struct Disease: Hashable, Codable, Identifiable {
    var id: Int
    var name, label, type: String
    var scientificName, cause: String
    var descriptionDisease: String
    var symptom1, symptom2, symptom3, symptom4, symptom5: String
    var descriptionSolution1: String
    
    var recommend: String
    
    var solution1, solution2, solution3, solution4: String
    var descriptionSolution2: String
    
    var protect1, protect2, protect3: String
    
    init(id: Int, name: String, label: String, type: String, scientificName: String, cause: String, descriptionDisease: String, symptom1: String, symptom2: String, symptom3: String, symptom4: String, symptom5: String, descriptionSolution1: String, recommend: String, solution1: String, solution2: String, solution3: String, solution4: String, descriptionSolution2: String, protect1: String, protect2: String, protect3: String) {
        self.id = id
        self.name = name
        self.label = label
        self.type = type
        self.scientificName = scientificName
        self.cause = cause
        self.descriptionDisease = descriptionDisease
        self.symptom1 = symptom1
        self.symptom2 = symptom2
        self.symptom3 = symptom3
        self.symptom4 = symptom4
        self.symptom5 = symptom5
        self.descriptionSolution1 = descriptionSolution1
        self.recommend = recommend
        self.solution1 = solution1
        self.solution2 = solution2
        self.solution3 = solution3
        self.solution4 = solution4
        self.descriptionSolution2 = descriptionSolution2
        self.protect1 = protect1
        self.protect2 = protect2
        self.protect3 = protect3
    }
}
