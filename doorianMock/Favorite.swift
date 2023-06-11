//
//  Favorite.swift
//  doorianMock
//
//  Created by Samitanun Sapsukdee on 19/4/2566 BE.
//

import SwiftUI
import Firebase

class Favorites: ObservableObject {
    @Published var contents = [Content]()

    @Published var savedItems: Set<String>

    init(){

        self.savedItems = []
        loadFavorites()
    }
    
    func contains(_ content:Content) -> Bool{
        savedItems.contains(content.id)
        
    }
    
    func toggleFav(_ content:Content){
        if contains(content){
            savedItems.remove(content.id)
            objectWillChange.send() // Add this line
        } else {
            savedItems.insert(content.id)
            objectWillChange.send() // Add this line
        }
        saveFavorites()

    }
    
    func add(_ content: Content) {
        objectWillChange.send()
        savedItems.insert(content.id)
        saveFavorites()

    }
    
    func remove(_ content: Content) {
        objectWillChange.send()
        savedItems.remove(content.id)
        objectWillChange.send()
        saveFavorites()

    }
    
    func loadFavorites() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let db = Firestore.firestore()
        let docRef = db.collection("Favorites").document(uid)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let data = document.data()
                if let favoriteIds = data?["favorites"] as? [String] {
                    self.savedItems = Set(favoriteIds)
                }
            }
        }
    }

    func saveFavorites() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let db = Firestore.firestore()
        let docRef = db.collection("Favorites").document(uid)
        
        docRef.setData(["favorites": Array(savedItems)]) { error in
            if let error = error {
                print("Error saving favorites: \(error)")
            } else {
                print("Favorites saved successfully")
            }
        }
    }


}
