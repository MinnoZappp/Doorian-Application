//
//  AuthView.swift
//  doorianMock
//
//  Created by Samitanun Sapsukdee on 29/3/2566 BE.
//

import SwiftUI
import Firebase
import GoogleSignIn

struct AuthView: View {
   @AppStorage("signin") var isUserCurrentlyLoggedOut : Bool = false
    
    var body: some View {
        NavigationView{
            if self.isUserCurrentlyLoggedOut {
                CustomTabbar(isUserCurrentlyLoggedOut:  $isUserCurrentlyLoggedOut)

                
            }else{
                LoginView(isUserCurrentlyLoggedOut:  $isUserCurrentlyLoggedOut)
            }
        }
        
        }
    }


struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
