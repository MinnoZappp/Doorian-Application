//
//  ContentAllGroupView.swift
//  doorianMock
//
//  Created by Samitanun Sapsukdee on 15/4/2566 BE.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI
struct ContentAllGroupView: View {

    @ObservedObject var favorite = Favorites()
        var data : Content

    @State var show = false
        var body: some View {
            NavigationLink(destination: ContentTodayNews(data: self.data)) {
                VStack(alignment: .leading){
             
                    HStack {
                        AnimatedImage(url: URL(string: data.image))
                            .resizable()
                            .frame(width: 100, height: 80)
                            .cornerRadius(20)
                        
                        VStack(alignment: .leading){
                            HStack{
                                Text(data.topicNews)
                                    .font(.system(size: 12))
                                    .padding(.bottom, 8)
                                    .bold()
                                
                            }
                            
                            HStack{
                                Text(data.author)
                                    .font(.system(size: 12))
                                    .padding(.leading, -4)
                                
                                Spacer()
                                
                                Text(data.date)
                                    .font(.system(size: 12))
                                    .padding(.leading, -4)
                            }
                            .padding(.top, 20)
                            
                        }
                        .padding(.leading, 25)
                        .padding(.trailing, 5)
                        .foregroundColor(Color("0B0B0B"))
                        
                        
                    }
                    .padding(.horizontal, 5)
                }
            }

                
            }

        }
    

