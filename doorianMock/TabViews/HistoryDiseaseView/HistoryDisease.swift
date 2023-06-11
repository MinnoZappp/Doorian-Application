//
//  HistoryDisease.swift
//  doorianMock
//
//  Created by Samitanun Sapsukdee on 29/3/2566 BE.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import SDWebImageSwiftUI

struct HistoryDisease: View {
    @ObservedObject private var viewModel = HistoryViewModel() // Create a view model
    var body: some View {
        ScrollView (.vertical, showsIndicators: true) {
            
            VStack(alignment: .leading) {
                
                HStack{
                    
                    Text("ประวัติ")
                        .font(.custom(
                            "NotoSans-Bold",
                            fixedSize: 24))
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                }
                .padding()
                 
                Divider()
                
                VStack(alignment: .leading, spacing: 20){
                    ForEach(viewModel.items) { item2 in
                        
                        GroupView(data: item2)
                        Divider()
                    }
                    
                }
                .padding()
                .padding(.bottom, 5)
            }
            Spacer(minLength: 0)
            
        }
        .onAppear {
            viewModel.fetchItems() // Fetch the items when the view appears
        }
    }
}

class HistoryViewModel: ObservableObject {
    @Published var items: [Item2] = []
    
    func fetchItems() {
        // Retrieve the documents from the "scan history" subcollection
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let userRef = Firestore.firestore().collection("users").document(uid)
        let scanHistoryRef = userRef.collection("scan history")
        
        scanHistoryRef.getDocuments { snapshot, error in
            if let error = error {
                print("Error retrieving scan history: \(error)")
                return
            }
            
            guard let documents = snapshot?.documents else {
                print("No documents found in scan history")
                return
            }
            print("Snapshot documents: \(documents)")
            
            // Convert the documents to Item2 objects
            var fetchedItems: [Item2] = []
            for document in documents {
                let documentData = document.data()
                print("Document data: \(documentData)")
                
                if let id = documentData["id"] as? String,
                   let dateCreatedTimestamp = documentData["dateCreated"] as? Timestamp,
                   let imageClass = documentData["imageClass"] as? String,
                   let scanImageUrl = documentData["scanImageUrl"] as? String,
                   let userAddress = documentData["userAddress"] as? String
                {
                    
                    let dateCreated = dateCreatedTimestamp.dateValue()
                    let item = Item2(id: id, dateCreated: dateCreated, imageClass: imageClass, scanImageUrl: scanImageUrl, userAddress: userAddress)
                    fetchedItems.append(item)
                    print(item)
                } else {
                    print("Error creating Item2 instance for document: \(document.documentID)")
                }
            }
            // Assign fetched items to the items property
                        DispatchQueue.main.async {
                            self.items = fetchedItems
                        }
        }
    }
}

struct HistoryDisease_Previews: PreviewProvider {
    static var previews: some View {
        HistoryDisease()
    }
}
