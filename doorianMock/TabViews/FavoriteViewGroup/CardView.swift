//
//  CardView.swift
//  doorianMock
//
//  Created by Samitanun Sapsukdee on 29/3/2566 BE.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import SDWebImageSwiftUI

struct CardView: View {
    
    //    let data: (userFavoriteContent: UserFavoriteContent, content: Content, generalContent: GeneralContent)
           
        var data : Content
        var body: some View {
            VStack(alignment: .leading, spacing: 16.0){
                
                AnimatedImage(url: URL(string: data.image))
                    .resizable()
                    .frame(height: 140)
                    .frame(maxWidth: .infinity)
                
                cardText.padding(.horizontal, 8)
                
            }
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 24.0))
            .shadow(radius: 8)
        }

        var cardText: some View{
            VStack{
                VStack(alignment: .center){
                    HStack{
                        Text(data.topic)
                            .font(.custom(
                                "NotoSans-Bold",
                                fixedSize: 14))
                            .bold()
                            .foregroundColor(.black)
                    }
                }
                VStack(alignment: .leading){
                    HStack(spacing: 2.0){
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 30, height: 30)
                            .clipShape(Circle())
                        //                    .offset(y: -40)
                            .padding(.bottom,10)
                            .foregroundColor(Color("828282"))
                        
                        Text(data.author)
                            .padding()
                            .font(.custom(
                                "NotoSans-Regular",
                                fixedSize: 12))
                            .padding(.leading,-5)
                        
                        Spacer(minLength: 0)
                        
                    }.foregroundColor(Color("545454"))
                        .padding(.bottom,2)
                }
            }
            
        }
    }

