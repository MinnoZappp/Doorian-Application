//
//  Item2.swift
//  doorianMock
//
//  Created by Samitanun Sapsukdee on 29/3/2566 BE.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore

struct Item2 : Identifiable, Codable {
   
    let id: String
    let dateCreated: Date
    let imageClass : String
    let scanImageUrl : String
    let userAddress : String
    
//    enum CodingKeys: String, CodingKey {
//        case id = "id"
//        case dateCreated = "dateCreated"
//        case imageClass  = "imageClass "
//        case scanImageUrl  = "scanImageUrl "
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.id = try container.decode(String.self, forKey: .id)
//        // Convert Timestamp to Date
//            let timestamp = try container.decode(Timestamp.self, forKey: .dateCreated)
//            self.dateCreated = timestamp.dateValue()
//        
//        self.imageClass  = try container.decode(String.self, forKey: .imageClass )
//        self.scanImageUrl  = try container.decode(String.self, forKey: .scanImageUrl )
//    }
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(self.id, forKey: .id)
//        try container.encode(self.dateCreated, forKey: .dateCreated)
//        try container.encode(self.imageClass , forKey: .imageClass )
//        try container.encode(self.scanImageUrl , forKey: .scanImageUrl)
//    }


}


   
