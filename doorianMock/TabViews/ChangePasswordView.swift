//
//  ChangePasswordView.swift
//  doorianMock
//
//  Created by Samitanun Sapsukdee on 29/3/2566 BE.
//

import SwiftUI
import Firebase
import FirebaseAuth
import SDWebImageSwiftUI

struct ChangePasswordView: View {
    
    @State private var newPasswordError: String?
    @State private var confirmPasswordError: String?
    @State var oldPassword: String = ""
    @State private var oldPasswordError: String?
    @State var newPassword: String = ""
    @State var confirmPassword : String = ""
    @State var visible = false
    @State private var showAlert = false
    @State private var showView = false
    @State private var errString: String?
    @State private var profileImageUrl: String = ""
    @ObservedObject private var vm = MainMessagesView()
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("uid") var userID: String = ""
    
    
    func checkOldPassword() {
        guard let currentUser = Auth.auth().currentUser else {
            // User is not authenticated
            return
        }
        
        let credential = EmailAuthProvider.credential(withEmail: currentUser.email ?? "", password: oldPassword)
        
        // Reauthenticate the user with the old password
        currentUser.reauthenticate(with: credential) { (_, error) in
            if error != nil {
                // Old password is incorrect
                self.oldPasswordError = "* กรอกรหัสผ่านเดิมไม่ถูกต้อง"
            } else {
                // Old password is correct
                // Call the changePassword function
                ChangePasswordAuth.changePassword(password: self.confirmPassword) { (result) in
                    switch result {
                    case .failure(let error):
                        self.errString = error.localizedDescription
                    case .success:
                        self.errString = "สำเร็จ! รหัสผ่านของคุณถูกเปลี่ยนแปลงเรียบร้อย"
                    }
                    self.showAlert = true
                }
            }
        }
    }
    
    private func isValidPassword(_ password: String) -> Bool {
        // minimum 8 characters long
        // 1 uppercase character
        // 1 lowerrcase character
        // 1 special char
        
        let passwordRegex = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[d$#$%&'()*+,-./:;<=>?@\\[\\\\\\]^_`{|}~])[A-Za-z\\dd$#$%&'()*+,-./:;<=>?@\\[\\\\\\]^_`{|}~]{8,}")
        
        return passwordRegex.evaluate(with: password)
    }
    var body: some View {
//        NavigationView {
            
            ScrollView(.vertical, showsIndicators: false) {
                ZStack{
                    VStack {
                        
                        VStack(spacing: 15){
                        
                            HStack{
                                WebImage(url: URL(string: vm.chatUser?.profileImageUrl ?? ""))
                                    .resizable()
                                    .scaledToFit()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 100, height: 100)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color("A3B694"), lineWidth: 10))
                                    .offset(y: -40)
                                    .padding(.bottom,-40)
                                
                            }
                            
                            HStack(alignment: .top, spacing: 10){
                                
                                Text("เปลี่ยนรหัสผ่าน")
                                    .font(.custom(
                                        "NotoSans-Bold",
                                        fixedSize: 18))
                                    
                            }
                            .frame(maxWidth: .infinity, alignment: .center)
                            .foregroundColor(.white)
                        }
                        .padding([.horizontal,.bottom])
                        .background(
                            Color("4F704B")
                            .cornerRadius(12)
                        )
                        .padding()
                        .padding(.top,40)
                        
                        VStack{
                            HStack {
                                Text("รหัสผ่านปัจจุบัน")
                                    .font(.custom(
                                        "NotoSans-Bold",
                                        fixedSize: 16))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .padding(.top,-10)
                            .padding(.leading, 20)
                            .padding(.bottom,10)
                            .foregroundColor(Color("4F704B"))
                            
                            HStack {
                                Image(systemName: "lock.fill")
                                VStack{
                                    if self.visible{
                                        TextField("รหัสผ่าน", text: $oldPassword)
                                            .font(.system(size: 14))
                                            .disableAutocorrection(true)
                                            .autocapitalization(.none)
                                    }
                                    else{
                                        SecureField("รหัสผ่าน", text: $oldPassword)
                                            .font(.system(size: 14))
                                            .disableAutocorrection(true)
                                            .autocapitalization(.none)
                                    }
                                }
                                Spacer()
                                
                                if (oldPassword.count != 0) {
                                    
                                    Image(systemName: isValidPassword(oldPassword) ? "checkmark" : "xmark")
                                        .foregroundColor(isValidPassword(oldPassword) ? .green : .red)
                                }
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
                                    .fill(Color("gray-white"))
                            )
                            .padding(.bottom, 20)
                            .padding()
                            .padding(.top, -20)
                        }
                        .padding(.top, 20)
                        VStack(alignment: .leading){
                            HStack {
                                
                                if let error = oldPasswordError {
                                    Text(error)
                                        .font(.system(size: 10))
                                        .foregroundColor(Color("dark-pink"))
                                       
                                }
                            }
                            .padding(.leading, -110)
                        }
                        .padding(.leading, -50)
                        .padding(.top,-30)
                        
                        VStack{
                            HStack {
                                Text("รหัสผ่านใหม่")
                                    .font(.custom(
                                        "NotoSans-Bold",
                                        fixedSize: 16))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .padding(.leading, 20)
                            .padding(.bottom,10)
                            .padding(.top, -10)
                            .foregroundColor(Color("4F704B"))
                            
                            HStack {
                                Image(systemName: "lock.fill")
                                VStack{
                                    if self.visible{
                                        TextField("รหัสผ่าน", text: $newPassword)
                                            .font(.system(size: 14))
                                            .disableAutocorrection(true)
                                            .autocapitalization(.none)
                                    }
                                    else{
                                        SecureField("รหัสผ่าน", text: $newPassword)
                                            .font(.system(size: 14))
                                            .disableAutocorrection(true)
                                            .autocapitalization(.none)
                                    }
                                }
                                Spacer()
                                
                                if (newPassword.count != 0) {
                                    
                                    Image(systemName: isValidPassword(newPassword) ? "checkmark" : "xmark")
                                        .foregroundColor(isValidPassword(newPassword) ? .green : .red)
                                }
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
                                    .fill(Color("gray-white"))
                            )
                            .padding(.bottom, 20)
                            .padding()
                            .padding(.top, -20)
                        }
                        .padding(.top, -10)
                        VStack{
                            Group {
                                Text("• กำหนดให้รหัสผ่านมากกว่าหรือเท่ากับ 8 ตัวอักษร")
                                Text("• มีตัวอักษรพิมพ์ใหญ่ (Uppercase) อย่างน้อย 1 ตัวอักษร")
                                Text("• มีตัวอักษรพิมพ์เล็ก (Lowercase) อย่างน้อย 1 ตัวอักษร")
                                Text("• มีอักขระพิเศษ (Special characters) เช่น (* + -  /) อย่างน้อย 1 ตัวอักษร")
                                Text("• มีตัวเลข (Numbers) 0-9 อย่างน้อย 1 ตัวอักษร")
                            }
                            .font(.system(size: 10))
                            .foregroundColor(Color("dark-pink"))
                            .accentColor(Color("dark-pink"))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading,15)
                            
                        }.padding(.top,-25)
                        
                        VStack{
                            HStack {
                                Text("ยืนยันรหัสผ่านใหม่")
                                    .font(.custom(
                                        "NotoSans-Bold",
                                        fixedSize: 16))
                                    .foregroundColor(Color("4F704B"))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .padding(.leading, 20)
                            .padding(.top,10)
                            .padding(.bottom,10)
                            
                            HStack {
                                Image(systemName: "lock.fill")
                                VStack{
                                    if self.visible{
                                        TextField("รหัสผ่าน", text: $confirmPassword)
                                            .font(.system(size: 14))
                                            .disableAutocorrection(true)
                                            .autocapitalization(.none)
                                    }
                                    else{
                                        SecureField("รหัสผ่าน", text: $confirmPassword)
                                            .font(.system(size: 14))
                                            .disableAutocorrection(true)
                                            .autocapitalization(.none)
                                    }
                                }
                                Spacer()
                                
                                if (confirmPassword.count != 0) {
                                    
                                    Image(systemName: isValidPassword(confirmPassword) ? "checkmark" : "xmark")
                                        .foregroundColor(isValidPassword(confirmPassword) ? .green : .red)
                                }
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
                                    .fill(Color("gray-white"))
                            )
                            .padding(.bottom, 20)
                            .padding()
                            .padding(.top, -20)
                            
                        }
                        .padding(.top, -10)
                        
                        Button(action: {
                            checkOldPassword()
                        }
                        ){
                            
                            Text("ยืนยัน")
                                .foregroundColor(Color("FFEA9A"))
                                .font(.custom(
                                    "NotoSans-Bold",
                                    fixedSize: 14))
                            
                                .frame(maxWidth: .infinity)
                                .padding()
                            
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(Color("4F704B"))
                                )
                                .padding(.horizontal)
                                .padding(.top,10)
                            
                        }
                        .disabled(!isValidPassword(newPassword) || newPassword != confirmPassword)
                    }
                    
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("การเปลี่ยนรัหสผ่าน"),
                      message: Text(self.errString ?? "สำเร็จ! รหัสผ่านของคุณถูกเปลี่ยนแปลงเรียบร้อย"), dismissButton: .default(Text("ตกลง")) {
                    self.presentationMode.wrappedValue.dismiss()
                    
                    //                    self.showView = true
                    
                    
                })
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 18)
        }
    }


struct ChangePasswordAuth{
    static func changePassword(password:String, resetCompletion:@escaping (Result<Bool,Error>) -> Void) {
        Auth.auth().currentUser?.updatePassword(to: password, completion: { (error) in
            if let error = error {
                resetCompletion(.failure(error))
            } else {
                resetCompletion(.success(true))
            }

        })
    }
}

struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordView()
    }
}
