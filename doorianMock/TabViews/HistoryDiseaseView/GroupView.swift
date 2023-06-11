//
//  GroupView.swift
//  doorianMock
//
//  Created by Samitanun Sapsukdee on 29/3/2566 BE.
//

import SwiftUI

import Firebase
import FirebaseFirestore
import SDWebImageSwiftUI

struct GroupView: View {
    var data: Item2
    
    // Date formatter for formatting the dateCreated property
       private let dateFormatter: DateFormatter = {
           let formatter = DateFormatter()
           formatter.dateStyle = .medium
           formatter.timeStyle = .short
           return formatter
       }()
    
    var body: some View {
        VStack(alignment: .leading){
            HStack {
                AnimatedImage(url: URL(string: data.scanImageUrl))
                    .resizable()
                    .frame(width: 100, height: 80)
                    .cornerRadius(20)
               
                VStack(alignment: .leading){
                    HStack{
                       
                        Text(dateFormatter.string(from: data.dateCreated))
                            .font(.system(size: 10))
                            .padding(.bottom, 8)
                        
//                        Text(",")
//                            .font(.system(size: 10))
//                            .padding(.bottom, 8)
//                            .padding(.leading, -8)
//
//                        Text(item2.time)
//                            .font(.system(size: 10))
//                            .padding(.bottom, 8)
//                            .padding(.leading, -6)
                    }
                    Text(data.imageClass)
                        .font(.system(size: 12))
                        .padding(.bottom, 8)
                        .bold()
                    HStack{
                        Image(systemName: "mappin")
                            .foregroundColor(Color("DE5B6D"))
                            .font(.system(size: 10))
                            .padding(.bottom, 8)
                        
                        
                        Text(data.userAddress)
                            .font(.system(size: 10))
                            .padding(.bottom, 8)
                            .padding(.leading, -4)
                    }
                 
                }
                .padding(.leading, 30)
                .padding(.trailing, 5)
                .foregroundColor(Color("0B0B0B"))
               
               
            }
            .padding(.horizontal, 5)
            
        }
    }
}

