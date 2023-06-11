//
//  LoginView.swift
//  doorianMock
//
//  Created by Samitanun Sapsukdee on 29/3/2566 BE.
//

import SwiftUI
import Firebase
import FirebaseAuth
import GoogleSignIn

struct LoginView: View {
   
    @AppStorage("uid") var userID: String = ""
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State var visible = false
    @State var error = ""
    @State private var showLoginAlert: Bool = false
    @State private var showingSheet = false
    @Binding var isUserCurrentlyLoggedOut  : Bool
    
    private func isValidPassword(_ password: String) -> Bool {
        // minimum 8 characters long
        // 1 uppercase character
        // 1 lowerrcase character
        // 1 special char
        
        let passwordRegex = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[d$#$%&'()*+,-./:;<=>?@\\[\\\\\\]^_`{|}~])[A-Za-z\\dd$#$%&'()*+,-./:;<=>?@\\[\\\\\\]^_`{|}~]{8,}")
        
        return passwordRegex.evaluate(with: password)
    }
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack {
                    HStack {
                        Image("doorian_logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .padding()
                    }
                    .padding(.top)
                    
                    HStack {
                        Text("ยินดีต้อนรับสู่ Doorian!")
                            .font(.custom(
                                "NotoSans-Bold",
                                fixedSize: 24))
                            .foregroundColor(Color("0B0B0B"))
                    }
                    .padding(.bottom, 20)
                    
                    HStack {
                        Image(systemName: "envelope.fill")
                        TextField("อีเมล", text: $email)
                            .font(.system(size: 14))
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                        
                        Spacer()
                        

                    }
                    .foregroundColor(Color("4F704B"))
                    .padding(.vertical, 10)
                    .padding(.horizontal, 18)
                    .background(
                        RoundedRectangle(cornerRadius: 50)
                            .fill(Color("textfield"))
                    )
                    .padding(.bottom, 20)
                    
                    HStack {
                        Image(systemName: "lock.fill")
                        VStack{
                            if self.visible{
                                TextField("รหัสผ่าน", text: $password)
                                    .font(.system(size: 14))
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                            }
                            else{
                                SecureField("รหัสผ่าน", text: $password)
                                    .font(.system(size: 14))
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                            }
                        }
                        Spacer()

                        Button(action: {
                            self.visible.toggle()
                        }) {
                            Image(systemName: self.visible ? "eye" : "eye.slash" )
                                .font(.system(size: 14))
                        }
                        
                    }
                    .foregroundColor(Color("4F704B"))
                    .padding(.vertical, 10)
                    .padding(.horizontal, 18)
                    .background(
                        RoundedRectangle(cornerRadius: 50)
                            .fill(Color("textfield"))
                    )
                    .padding(.bottom, 20)
                    
                    HStack {
                        
                        Spacer()
                        VStack{
                            NavigationLink(destination: ResetPasswordView()) {
                                Text("ลืมรหัสผ่าน ?")
                                    .bold()
                            }
                        }
                    }
                    .font(.system(size: 14))
                    .foregroundColor(Color("4F704B"))
                    .padding(.bottom, 20)
                    
                    HStack{
                        Button {
                            
                            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                                if let error = error {
                                    print(error)
                                    self.showLoginAlert = true
                                    return
                                }
                                
                                if let authResult = authResult {
                                    print(authResult.user.uid)
                                    withAnimation {
                                        userID = authResult.user.uid
                                    }
                                    
                                }
                                self.isUserCurrentlyLoggedOut = true
                            }
                            
                        } label: {
                            
                            Text("เข้าสู่ระบบ")
                                .foregroundColor(Color("FFEA9A"))
                                .font(.system(size: 14))
                                .bold()
                            
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 10)
                            
                                .background(
                                    RoundedRectangle(cornerRadius: 50)
                                        .fill(Color("4F704B"))
                                )
                        }
                        .padding(.bottom, 20)
                        .alert(isPresented: $showLoginAlert) {
                            Alert(title: Text("Email/Password incorrect"))
                        }
                    }
                    HStack{
                        
                        Text("━━━━━━━━━ หรือ ━━━━━━━━━")
                            .font(.custom(
                                "NotoSans-Bold",
                                fixedSize: 14))
                            .padding(.bottom, 20)
                            .bold()
                            .foregroundColor(Color("0B0B0B"))
                    }
                    
                    HStack{
                     
                    GoogleSigninBtn {
                        FireAuth.share.signinWithGoogle(presenting: getRootViewController()) { errror in
                            print("ERROR: \(error)")
                        }
                      
                        
                    }
                    .padding(.bottom, 20)
                }
                    
                    HStack{
                        Button(action: {
                            showingSheet.toggle()

                        }
                        ) {
                       
                            Text("คุณยังไม่ได้สมัครสมาชิกหรือไม่")
                                .foregroundColor(.black.opacity(0.7))
                                .font(.custom(
                                    "NotoSans-Regular",
                                    fixedSize: 14))
                                .foregroundColor(Color("0B0B0B"))
                            Text("สมัครสมาชิก!")
                                .font(.custom(
                                    "NotoSans-Bold",
                                    fixedSize: 14))
                                .bold()
                                .foregroundColor(Color("4F704B"))
                        }
                        .padding(.bottom, 20)
                        .padding(.top, 30)
                        
                    }
                    .frame(width: 300, height: 35)
                   
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 30)
                .padding(.top, -50)
                .background(
                    Color(.white)
                        .ignoresSafeArea()
                )
            }
            
            }
            .sheet(isPresented: $showingSheet) {
                SignupView(isUserCurrentlyLoggedOut: $isUserCurrentlyLoggedOut)
                    .presentationDetents([.large])
                    .presentationDragIndicator(.visible)
            }
            
            .onTapGesture {
                self.hideKeyboard()
            }
        }
    

    }
//}

struct LoginView_Previews: PreviewProvider {
    
    @State static var isUserCurrentlyLoggedOut = false
    static var previews: some View {
      
        LoginView(isUserCurrentlyLoggedOut: $isUserCurrentlyLoggedOut)
    }
}
