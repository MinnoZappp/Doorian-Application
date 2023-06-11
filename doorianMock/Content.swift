//
//  Content.swift
//  doorianMock
//
//  Created by Samitanun Sapsukdee on 12/4/2566 BE.
//
import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore

final class ContentViewModel :  ObservableObject {
    func addUserFavoriteContent(contentId: String){
        Task{
            guard let uid = Auth.auth().currentUser?.uid else { return }
            try? await MainMessagesView.shared.addUserFavoriteContent(userId: uid, contentId: contentId)
        }
    }
    
}

struct Content : Identifiable, Codable {
    
    var id: String
    var author: String
    var contentP1: String
    var contentP2: String
    var contentP3: String
    var contentP4: String
    var date: String
    var imageName: String
    var image: String
    var topic: String
    var subtopic: String
    var topicNews: String
    var status: String

    
}
