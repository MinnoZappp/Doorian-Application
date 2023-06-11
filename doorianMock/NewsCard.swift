//
//  NewsCard.swift
//  doorianMock
//
//  Created by Samitanun Sapsukdee on 29/3/2566 BE.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI

struct NewsCard: View {
//    var item: Item //ยืมข้อมูลมาใช้ก่อนเด่วค่อยเปลี่ยน
//    @ObservedObject var contentViewModel: ContentViewModel
    @ObservedObject var favorite = Favorites()
    var data : Content
    @State var show = false
  
    
    var body: some View {
    VStack{
    Button(action: {
        self.show.toggle()
    }) {
            AnimatedImage(url: URL(string: data.image))
                    .resizable()
                    .frame(height: 200)
                    .frame(maxWidth: .infinity)
                    .cornerRadius(20)
//                    .overlay(alignment: .leading){
//                        VStack {
//                            HStack{
//                                Text(data.topicNews)
//                                
//                                    .font(.custom(
//                                        "NotoSans-Bold",
//                                        fixedSize: 16))
//                                    .foregroundColor(.black)
//                                    .background(Color.white)
//                                    .frame(maxWidth: .infinity)
//                                    .padding()
//                                //                                .padding(.leading, -110)
//                            }
//                            HStack{
//                                Text(data.subtopic)
//                                
//                                    .font(.custom(
//                                        "NotoSans-Regular",
//                                        fixedSize: 14))
//                                    .foregroundColor(.black)
//                                    .background(Color.white)
//                                    .frame(maxWidth: .infinity)
//                                
//                                    .padding(.top, -10)
//                                    .padding(.leading, -10)
//                            }
//                        }
//                        .padding(.leading, -110)
//                    }
        
        }.sheet(isPresented: self.$show) {
            
            ContentTodayNews(data: self.data)
        }
            
        }.background(Color.black)
         .cornerRadius(20)
         .environmentObject(favorite)
           
    }
}


