//
//  GeneralContent.swift
//  doorianMock
//
//  Created by Samitanun Sapsukdee on 21/4/2566 BE.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore

//final class ContentViewModel2 :  ObservableObject {
//    func addUserFavoriteContent(contentId: String){
//        Task{
//            guard let uid = Auth.auth().currentUser?.uid else { return }
//            try? await MainMessagesView.shared.addUserFavoriteContent(userId: uid, contentId: contentId)
//        }
//    }
//
//}

struct GeneralContent : Identifiable, Codable {
    
    var id: String
    var author: String
    var contentG1: String
    var contentG2: String
    var contentG3: String
    var contentG4: String
    var date: String
    var imageName: String
    var image: String
    var topic: String
    var subtopic: String
    var topicNews: String
    var status: String
    
}
