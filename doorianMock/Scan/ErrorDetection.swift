//
//  ErrorDetection.swift
//  doorianMock
//
//  Created by Warunya on 18/5/2566 BE.
//

import SwiftUI

struct ErrorDetection: View {
    var body: some View {
        ZStack {
            Color.black
            
            VStack {
                Text("ลองอีกครั้ง")
                    .font(.system(size: 18, weight: .heavy))
                    .padding(.top, 30)
                    .padding(.bottom, 8)
                
                Text("ขออภัย เราไม่สามารถระบุชนิดใบได้")
                    .font(.system(size: 10, weight: .heavy))
                    .padding(.bottom, 8)
                
                Link("คุณสามารถอัปโหลดรูปเพื่อให้เราช่วยเหลือใหม่อีกครั้ง!", destination: URL(string: "https://forms.gle/z3VhbgbKn8jWBufFA")!)
                    .font(.system(size: 12))
                    .foregroundColor(.black)
                    .padding(.bottom, 16)
                
                Button(action: {
                    
                }) {
                    Text("ตกลง")
                        .font(.system(size: 12, weight: .heavy))
                        .foregroundColor(.white)
                }
                .frame(width: 200, height: 24)
                .background(Color("dark-pink"))
                .cornerRadius(100)
            }
            .padding()
            .frame(width: 300, height: 200)
            .background(.white)
            .cornerRadius(20)
            
            Group {
                Circle()
                    .fill(Color("FFC700"))
                    .frame(width: 60)
                    .overlay(Circle().stroke(Color.white, lineWidth: 10))
                
                
                Image(systemName: "questionmark")
                    .font(.system(size: 30))
                    .foregroundColor(.white)
            }
            .offset(y: -90)
            
        }
    }
}

struct ErrorDetection_Previews: PreviewProvider {
    static var previews: some View {
        ErrorDetection()
    }
}
