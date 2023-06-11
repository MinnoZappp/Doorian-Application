//
//  FavoriteG.swift
//  doorianMock
//
//  Created by Samitanun Sapsukdee on 27/4/2566 BE.
//
//
//import SwiftUI
//import Firebase
//
//class FavoriteG: ObservableObject {
//    
//    @Published var contents = [GeneralContent]()
//    
//    @Published var savedItems: Set<String>
//    @Published var saveKey = "Favorite"
//    
//    private var db = Database()
//    
//    init(){
//        self.savedItems = db.load()
//        self.savedItems = []
//    }
//    
//    func contains(_ content:GeneralContent) -> Bool{
//        savedItems.contains(content.id)
//        
//    }
//    
//    func toggleFav(_ content:GeneralContent){
//        if contains(content){
//            savedItems.remove(content.id)
//        } else {
//            savedItems.insert(content.id)
//        }
//        db.save(items: savedItems)
//    }
//    
//    func add(_ content: GeneralContent) {
//        objectWillChange.send()
//        savedItems.insert(content.id)
//        save()
//    }
//    
//    func remove(_ content: GeneralContent) {
//        objectWillChange.send()
//        savedItems.remove(content.id)
//        save()
//    }
//    
//    func save() {
//        
//    }
//}
//
