//
//  GeneralNewsCard.swift
//  doorianMock
//
//  Created by Samitanun Sapsukdee on 14/4/2566 BE.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI

struct GeneralNewsCard: View {
    var data: GeneralContent
//    @ObservedObject var favorite = FavoriteG()
    @State var show = false
    
    var body: some View {
        VStack {
            Button(action: {
                self.show.toggle()
            }) {
                AnimatedImage(url: URL(string: data.image))
                    .resizable()
                    .frame(height: 200)
                    .frame(maxWidth: .infinity)
                    .cornerRadius(20)
//                    .overlay(alignment: .leading) {
//                        Text(data.topicNews)
//                            .font(.custom("NotoSans-Bold", fixedSize: 16))
//                            .foregroundColor(.black)
//                            .background(Color.white)
//                            .frame(maxWidth: .infinity)
//                            .padding()
//                        Text(data.subtopic)
//                            .font(.custom("NotoSans-Regular", fixedSize: 14))
//                            .foregroundColor(.black)
//                            .background(Color.white)
//                            .frame(maxWidth: .infinity)
//                            .padding(.top, 60)
//                            .padding(.leading, -110)
//                    }
            }
            .sheet(isPresented: self.$show) {
                ContentGeneralNews(data: self.data)
            }
        }
        .background(Color.black)
        .cornerRadius(20)
//        .environmentObject(favorite)
    }
}
