//
//  getGeneralContent.swift
//  doorianMock
//
//  Created by Samitanun Sapsukdee on 21/4/2566 BE.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class getGeneralContent: ObservableObject {
   
    @Published var contents = [GeneralContent]()
    static let shared = getGeneralContent()
    private let contentCollection = Firestore.firestore().collection("Content")

    init() {

        Firestore.firestore().collection("GeneralContent")
            .getDocuments { (snapshot, err) in
                
                if err != nil{
                    print((err?.localizedDescription)!)
                    return
                }
                
                for i in snapshot!.documents{
                    
                    let id = i.documentID
                    
                    let author = i.get("author") as! String
                    let contentG1 = i.get("contentG1") as! String
                    let contentG2 = i.get("contentG2") as! String
                    let contentG3 = i.get("contentG3") as! String
                    let contentG4 = i.get("contentG4") as! String
                    let date = i.get("date") as! String
                    let imageName = i.get("imageName") as! String
                    let image = i.get("image") as! String
                    let topic = i.get("topic") as! String
                    let subtopic = i.get("subtopic") as! String
                    let topicNews = i.get("topicNews") as! String
                    let status = i.get("status") as! String

                    if status == ""{
                        self.contents.append(GeneralContent(id: id, author: author, contentG1: contentG1, contentG2: contentG2, contentG3: contentG3, contentG4: contentG4, date: date, imageName: imageName, image: image, topic: topic, subtopic: subtopic, topicNews: topicNews, status: status))
                    }
                  
                }
            
            
            }
    }
    private func contentDocument(contentId: String) -> DocumentReference {
        contentCollection.document(contentId)
    }
    
    func getContent(contentId: String) async throws -> GeneralContent{
        try await contentDocument(contentId: contentId).getDocument(as: GeneralContent.self)
    }
}
