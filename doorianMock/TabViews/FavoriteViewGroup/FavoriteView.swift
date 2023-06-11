//
//  FavoriteView.swift
//  doorianMock
//
//  Created by Samitanun Sapsukdee on 29/3/2566 BE.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseAuth
import SDWebImageSwiftUI

@MainActor
final class FavoriteViewModel: ObservableObject {
    static let shared = FavoriteViewModel()
    
    @Published private(set) var contents: [(userFavoriteContent: UserFavoriteContent, content: Content)] = []
    
    func getFavorites() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Task {
            do {
                let userFavoriteContents = try await MainMessagesView.shared.getAllUserFavoriteContents(userId: uid)
                var localArray: [(userFavoriteContent: UserFavoriteContent, content: Content)] = []
                print(userFavoriteContents)
                for userFavoriteContent in userFavoriteContents {
                    print(userFavoriteContent)
                    
                    //                    let content = try? await getContent1.shared.getContent(contentId: userFavoriteContent.contentId)
                    let content = try? await Firestore.firestore().collection("Content").document(userFavoriteContent.contentId).getDocument()
                    if let contentData = try content?.data(as: Content.self) {
                        localArray.append((userFavoriteContent, contentData))
                    }
                    //                        print(try content?.data(as: Content.self))
                    
                    //                        if ((content) != nil) {
                    //                            localArray.append((userFavoriteContent, content!))
                    //                        }
                    
                }
                
                DispatchQueue.main.async { [weak self] in
                    self?.contents = localArray
                }
            } catch {
                // Handle any errors during data retrieval
                print("Error getting favorites: \(error)")
            }
        }
    }
    func addUserFavoriteContent(contentId: String){
        print(contentId)
        Task{
            guard let uid = Auth.auth().currentUser?.uid else { return }
            try? await MainMessagesView.shared.addUserFavoriteContent(userId: uid, contentId: contentId)
        }
    }
    
    func removeFromFavorites(favoriteContentId: String) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        print(favoriteContentId)
        Task {
            do {
                try await MainMessagesView.shared.removeUserFavoriteContent(userId: uid, favoriteContentId: favoriteContentId)
                
                // Fetch updated user favorite contents
                getFavorites()
                // Trigger UI update
                DispatchQueue.main.async {
                    self.objectWillChange.send()
                }
                
                
            } catch {
                print("Error removing favorite: \(error)")
            }
        }
    }
}

struct FavoriteView: View {
    
    @StateObject private var viewModel = FavoriteViewModel()
    
    @EnvironmentObject var favorites: Favorites
   

    
    var body: some View {
        ScrollView (.vertical, showsIndicators: true) {
            
            VStack(alignment: .leading) {
                
                HStack{
                    
                    Text("สิ่งที่ฉันถูกใจ")
                        .font(.custom(
                            "NotoSans-Bold",
                            fixedSize: 24))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                }
                Divider()
                    .padding(.top,-10)
                
                if self.viewModel.contents.count != 0{
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 160), spacing: -10)], spacing: 15){
                        ForEach(viewModel.contents, id: \.userFavoriteContent.id.self) { item in
                            NavigationLink(destination: ContentTodayNews2(data: item.content)) {
                              
                                
                                CardView(data: item.content )
                                    
                                    .contextMenu{
                                        Button("Remove") {
                                            viewModel.removeFromFavorites(favoriteContentId: item.userFavoriteContent.contentId)
                                                
                                            
                                        }
                                      
                                    }
                                  
                                
                            }
                        }
                        
                        .padding()
                        .padding(.top,-10)
                    }
            
                }
                
                Spacer(minLength: 0)
                
            }
            
            .onAppear{
                viewModel.getFavorites()
                
            }
            
        }
        
    }
    
}


















