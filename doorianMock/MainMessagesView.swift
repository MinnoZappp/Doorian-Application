//
//  MainMessagesView.swift
//  doorianMock
//
//  Created by Samitanun Sapsukdee on 29/3/2566 BE.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import SDWebImageSwiftUI
import Combine

struct ChatUser {
    let uid, email, name, profileImageUrl : String
   
}


class MainMessagesView: ObservableObject {
    
    static let shared = MainMessagesView()
    @Published var errorMessage = ""
    @Published var chatUser: ChatUser?
//    @Published var favoriteContents: UserFavoriteContent?
  
  
    
    init() {
        fetchCurrentUser()
//        fetchFavoriteContent()
        
    }
    
    private func fetchCurrentUser(){
        
        guard let uid = Auth.auth().currentUser?.uid else{
            self.errorMessage = "Could not find firebase uid"
            return
        }
        
        userCollection.document(uid).getDocument { snapshot, error in
                
                if let error = error {
                    self.errorMessage = "Failed to fetch current user: \(error)"
                    print("Failed to fetch current user",error)
                    return
                }
//                self.errorMessage = "123"
                
                guard let data = snapshot?.data() else {
                    self.errorMessage = "No datat found"
                    return
                }
//                self.errorMessage = "Data: \(data.description)"
                let uid = data["uid"] as? String ?? ""
                let email =  data["email"] as? String ?? ""
                let name = data["name"] as? String ?? ""
                let profileImageUrl = data["profileImageUrl"] as? String ?? ""
                
            
                
            self.chatUser = ChatUser(uid: uid, email: email, name: name, profileImageUrl: profileImageUrl)
                
//                self.errorMessage = chatUser.profileImageUrl
            }
    }
   
    
    private let userCollection : CollectionReference = Firestore.firestore().collection("users")

    private func userDocument(userId: String) -> DocumentReference {

        Firestore.firestore().collection("users").document(userId)
    }

    private func userFavoriteContentCollection(userId: String) -> CollectionReference{

        userDocument(userId: userId).collection("favorite_content")
    }
    private func userFavoriteContentDocument(userId: String, favoriteContentId: String) -> DocumentReference{

        userFavoriteContentCollection(userId: userId).document(favoriteContentId)
    }
   
    
    func addUserFavoriteContent(userId: String, contentId: String) async throws{

        let document = userFavoriteContentCollection(userId: userId).document()
        let documentId = document.documentID
        let data: [String:Any] = [
//            "id" : documentId,
//            "content_id" : contentId,
//            "date_created" : Timestamp()
           
            UserFavoriteContent.CodingKeys.id.rawValue : documentId,
            UserFavoriteContent.CodingKeys.contentId.rawValue : contentId,
            UserFavoriteContent.CodingKeys.dateCreated.rawValue : Timestamp()
            

        ]

        try await document.setData(data, merge: false)
    }

    func removeUserFavoriteContent(userId: String, favoriteContentId: String) async throws{
//        try await userFavoriteContentDocument(userId: userId, favoriteContentId: favoriteContentId).delete()
        
        let querySnapshot = try await Firestore.firestore().collection("users").document(userId).collection("favorite_content").whereField("content_id", isEqualTo: favoriteContentId).getDocuments()
        querySnapshot.documents.forEach { doc in
            doc.reference.delete()
        }

    }
    
    func getAllUserFavoriteContents(userId: String) async throws -> [UserFavoriteContent] {
        guard let querySnapshot = try? await Firestore.firestore().collection("users").document(userId).collection("favorite_content").getDocuments()
        else { return [] }
        return querySnapshot.documents.compactMap { document in
            try? document.data(as: UserFavoriteContent.self)
        }
    }
    
    func getAllUserScanHistory(userId: String) async throws -> [Item2] {
        guard let querySnapshot = try? await Firestore.firestore().collection("users").document(userId).collection("scan history").getDocuments()
        else { return [] }
        return querySnapshot.documents.compactMap { document in
            try? document.data(as:Item2.self)
        }
    }
    


}

struct UserFavoriteContent: Codable,  Identifiable {

    let id: String
    let contentId: String
    let dateCreated: Date

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case contentId = "content_id"
        case dateCreated = "date_created"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.contentId = try container.decode(String.self, forKey: .contentId)
        self.dateCreated = try container.decode(Date.self, forKey: .dateCreated)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.contentId, forKey: .contentId)
        try container.encode(self.dateCreated, forKey: .dateCreated)
    }


}


