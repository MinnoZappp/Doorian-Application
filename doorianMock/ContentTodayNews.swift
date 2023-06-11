//
//  ContentTodayNews.swift
//  doorianMock
//
//  Created by Samitanun Sapsukdee on 29/3/2566 BE.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import SDWebImageSwiftUI
struct ContentTodayNews: View {
    
    
    var data : Content
        @Environment(\.dismiss) var dismiss
        @State var show = false
    @StateObject var favorites = Favorites() 
    var body: some View {
        NavigationView{
            
                ScrollView (.vertical, showsIndicators: false) {
                    VStack {
                        FavoriteBtnT(data: data)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.top,20)
                            .environmentObject(favorites)

                        
                        VStack(alignment: .leading){
                            
                            HeaderContentT(data: data)
                                .padding(.top,10)
                            
                            DetailUserT(data: data)
                        }
                        VStack(alignment: .leading) {
                            AnimatedImage(url: URL(string: data.image))
                                .resizable()
                                .frame(height: 200)
                                .frame(maxWidth: .infinity)
                                .cornerRadius(20)
                               
                        }
                        .padding(.top,10)
                        
                        ContentT1(data: data)
                            .padding(10)
                        ContentT2(data: data)
                            .padding(10)
                        ContentT3(data: data)
                            .padding(10)
                        ContentT4(data: data)
                            .padding(10)
                    }
                    .frame(maxWidth: 360)
                    .padding(.horizontal,24)
                }
            }
           
    }
}

struct ContentTodayNews2: View {
    
    var data : Content
    @StateObject private var favorites = Favorites()

    var body: some View {
        NavigationView{
            
                ScrollView (.vertical, showsIndicators: false) {
                    VStack {
                       
                        VStack(alignment: .leading){
                            
                            HeaderContentT(data: data)
                                .padding(.top,10)
                            
                            DetailUserT(data: data)
                        }
                        VStack(alignment: .leading) {
                            AnimatedImage(url: URL(string: data.image))
                                .resizable()
                                .frame(height: 200)
                                .frame(maxWidth: .infinity)
                                .cornerRadius(20)
                               
                        }
                        .padding(.top,10)
                        
                        ContentT1(data: data)
                            .padding(10)
                        ContentT2(data: data)
                            .padding(10)
                        ContentT3(data: data)
                            .padding(10)
                        ContentT4(data: data)
                            .padding(10)
                    }
                    .frame(maxWidth: 360)
                    .padding(.horizontal,24)
                }
            }
           
    }
}

struct FavoriteBtnT: View {
   
    var data : Content
    
    @StateObject private var vm = FavoriteViewModel.shared
    @EnvironmentObject var favorites: Favorites
    
    var body: some View {
        Button{
            if self.favorites.contains(self.data){
                self.favorites.remove(self.data)
                vm.removeFromFavorites(favoriteContentId: data.id)
               
                print(self.data.id)
                print("Item removed from favorites")
        
                
            } else {
                self.favorites.add(self.data)
                vm.addUserFavoriteContent(contentId: data.id)
                print(self.data.id)
                print("Item added to favorites")
            }
           
            
        } label: {
            Image(systemName: favorites.contains(data) ? "heart.fill" : "heart")
                .foregroundColor(Color("dark-pink"))
                .font(.system(size: 20))
                .padding(.bottom, 4)
           
        }
        
    }
}

struct HeaderContentT: View {
    var data : Content
    var body: some View {
        Text(data.topic)
                .font(.system(size: 24))
                .bold()
                .foregroundColor(Color("025711"))
                .padding(.bottom, 8)
          
    }
}

struct DetailUserT: View {
    var data : Content
    var body: some View {
       
        HStack{
            
                Group{

                    Image(systemName: "person.fill")
                        .foregroundColor(Color("4F4F4F"))
                        .font(.system(size: 14))
                        .padding(.bottom, 4)
                    Text(data.author)
                        .font(.system(size: 10))
                        .bold()
                        .foregroundColor(Color("4F4F4F"))
                        .padding(.bottom, 4)
                    
                }
                Group{
                    Image(systemName: "clock")
                        .foregroundColor(Color("4F4F4F"))
                        .font(.system(size: 14))
                        .padding(.bottom, 4)
                    Text(data.date)
                        .font(.system(size: 10))
                        .bold()
                        .foregroundColor(Color("4F4F4F"))
                        .padding(.bottom, 4)
                }
            }
    }
}


struct ContentT1: View {
    var data : Content
var body : some View {
        VStack(alignment: .center){
            Group{
                Text(data.contentP1)
                    .font(.custom(
                        "NotoSans-Regular",
                        fixedSize: 14))
                    .foregroundColor(Color("0B0B0B"))
                    .padding(.bottom, 4)
            }
        }
    }
}

struct ContentT2: View {
    var data : Content
var body : some View {
        VStack(alignment: .center){
            Group{
                Text(data.contentP2)
                    .font(.custom(
                        "NotoSans-Regular",
                        fixedSize: 14))
                    .foregroundColor(Color("0B0B0B"))
                    .padding(.bottom, 4)
            }
        }
    }
}

struct ContentT3: View {
    var data : Content
var body : some View {
        VStack(alignment: .center){
            Group{
                Text(data.contentP3)
                    .font(.custom(
                        "NotoSans-Regular",
                        fixedSize: 14))
                    .foregroundColor(Color("0B0B0B"))
                    .padding(.bottom, 4)
            }
        }
    }
}

struct ContentT4: View {
    var data : Content
var body : some View {
        VStack(alignment: .center){
            Group{
                Text(data.contentP4)
                    .font(.custom(
                        "NotoSans-Regular",
                        fixedSize: 14))
                    .foregroundColor(Color("0B0B0B"))
                    .padding(.bottom, 4)
            }
        }
    }
}

//struct ContentTodayNews_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentTodayNews()
//    }
//}
