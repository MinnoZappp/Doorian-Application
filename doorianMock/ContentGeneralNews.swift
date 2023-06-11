//
//  ContentGeneralNews.swift
//  doorianMock
//
//  Created by Samitanun Sapsukdee on 29/3/2566 BE.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import SDWebImageSwiftUI

struct ContentGeneralNews: View {
    
    var data : GeneralContent
    
    var body: some View {
      
                
                    ScrollView (.vertical, showsIndicators: false) {
                        VStack {
                           
//                            FavoriteBtnG(data: data)
//                                .frame(maxWidth: .infinity, alignment: .trailing)
                            
                            VStack(alignment: .leading){
                                
                                HeaderContentG(data: data)
                                    .padding(.top, 20)
                                DetailUserG(data: data)
                            }
                           
                            .padding(.bottom, 20)
                            
                            VStack(alignment: .leading) {
                                AnimatedImage(url: URL(string: data.image))
                                    .resizable()
                                    .frame(height: 200)
                                    .frame(maxWidth: .infinity)
                                    .cornerRadius(20)
                                   
                            }
                            
                            ImageNameG(data: data)
                                .padding()
                            ContentG1(data: data)
                                .padding(10)
                            ContentG2(data: data)
                                .padding(10)
                            ContentG3(data: data)
                                .padding(10)
                            ContentG4(data: data)
                                .padding(10)
                        }
                        .frame(maxWidth: 360)
                        .padding(.horizontal,24)
                    }
                
    }
}

//struct FavoriteBtnG: View {
////    var data1 : GeneralContent
//    var data : GeneralContent //เด่วต้องแก้
//
//    @StateObject private var vm = ContentViewModel2()
//     @EnvironmentObject var favorite: FavoriteG
//    var body: some View {
//        Button{
//            if self.favorite.contains(self.data){
//                self.favorite.remove(self.data)
//            } else {
//                self.favorite.add(self.data)
//                vm.addUserFavoriteContent(contentId: data.id)
//            }
//        } label: {
//            Image(systemName: favorite.contains(data) ? "heart.fill" : "heart")
//                .foregroundColor(Color("dark-pink"))
//                .font(.system(size: 20))
//                .padding(.bottom, 4)
//
//        }
//    }
//}

struct HeaderContentG: View {
    var data : GeneralContent
    var body: some View {
            Text(data.topicNews)
                .font(.system(size: 24))
                .bold()
                .foregroundColor(Color("025711"))
                .padding(.bottom, 8)
          
    }
}

struct DetailUserG: View {
    var data : GeneralContent
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

struct ImageNameG: View {
    var data : GeneralContent
var body : some View {
        VStack(alignment: .center){
            Text(data.subtopic)
                .font(.system(size: 10))
                .bold()
                .foregroundColor(Color("828282"))
                .padding(.bottom, 4)
        
        }
    }
}

struct ContentG1: View {
    var data : GeneralContent
var body : some View {
        VStack(alignment: .center){
            Group{
                Text(data.contentG1)
                    .font(.custom(
                        "NotoSans-Regular",
                        fixedSize: 14))
                    .foregroundColor(Color("0B0B0B"))
                    .padding(.bottom, 10)
            }
        }
    }
}

struct ContentG2: View {
    var data : GeneralContent
var body : some View {
        VStack(alignment: .center){
            Group{
                Text(data.contentG2)
                    .font(.custom(
                        "NotoSans-Regular",
                        fixedSize: 14))
                    .foregroundColor(Color("0B0B0B"))
                    .padding(.bottom, 10)
            }
        }
    }
}

struct ContentG3: View {
    var data : GeneralContent
var body : some View {
        VStack(alignment: .center){
            Group{
                Text(data.contentG3)
                    .font(.custom(
                        "NotoSans-Regular",
                        fixedSize: 14))
                    .foregroundColor(Color("0B0B0B"))
                    .padding(.bottom, 10)
            }
        }
    }
}

struct ContentG4: View {
    var data : GeneralContent
var body : some View {
        VStack(alignment: .center){
            Group{
                Text(data.contentG4)
                    .font(.custom(
                        "NotoSans-Regular",
                        fixedSize: 14))
                    .foregroundColor(Color("0B0B0B"))
                    .padding(.bottom, 10)
            }
        }
    }
}
