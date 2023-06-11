//
//  getContents1.swift
//  doorianMock
//
//  Created by Samitanun Sapsukdee on 12/4/2566 BE.
//
import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class getContent1: ObservableObject {
   
    @Published var contents = [Content]()
    static let shared = getContent1()
    private let contentCollection = Firestore.firestore().collection("Content")

    init() {

        contentCollection.getDocuments { (snapshot, err) in
                
                if err != nil{
                    print((err?.localizedDescription)!)
                    return
                }
                
                for i in snapshot!.documents{
                    
                    let id = i.documentID
                    
                    let author = i.get("author") as! String
                    let contentP1 = i.get("contentP1") as! String
                    let contentP2 = i.get("contentP2") as! String
                    let contentP3 = i.get("contentP3") as! String
                    let contentP4 = i.get("contentP4") as! String
                    let date = i.get("date") as! String
                    let imageName = i.get("imageName") as! String
                    let image = i.get("image") as! String
                    let topic = i.get("topic") as! String
                    let subtopic = i.get("subtopic") as! String
                    let topicNews = i.get("topicNews") as! String
                    let status = i.get("status") as! String

                    if status == ""{
                        self.contents.append(Content(id: id, author: author, contentP1: contentP1, contentP2: contentP2, contentP3: contentP3, contentP4: contentP4, date: date, imageName: imageName, image: image, topic: topic, subtopic: subtopic, topicNews: topicNews, status: status))
                    }
                  
                }
            
            
            }
    }
    private func contentDocument(contentId: String) -> DocumentReference {
        contentCollection.document(contentId)
    }
    
    func getContent(contentId: String) async throws -> Content{
        try await contentDocument(contentId: contentId).getDocument(as: Content.self)
    }
}
