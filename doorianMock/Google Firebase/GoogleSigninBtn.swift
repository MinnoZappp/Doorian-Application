//
//  GoogleSigninBtn.swift
//  doorianMock
//
//  Created by Samitanun Sapsukdee on 29/3/2566 BE.
//

import SwiftUI

struct GoogleSigninBtn: View {
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack{
                HStack{
                    Image("googleicon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 30)
                        
                    Text("Google")
                        .foregroundColor(.white)
                        .font(.title3)
                        .bold()
                }
                .frame(width: 130, height: 35)
                .padding(.vertical, 7)
                .padding(.horizontal, 10)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                    .fill(Color("dark-pink"))
                )
            }
        }
    }
}

struct GoogleSigninBtn_Previews: PreviewProvider {
    static var previews: some View {
       
        GoogleSigninBtn(action: {})
    }
}
