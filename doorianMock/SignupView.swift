//
//  SignupView.swift
//  doorianMock
//
//  Created by Samitanun Sapsukdee on 29/3/2566 BE.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseStorage
import GoogleSignIn

struct SignupView: View {
    @Binding var isUserCurrentlyLoggedOut  : Bool
    @AppStorage("uid") var userID: String = ""
    
    @State private var name: String = ""
    @State private var profileImageUrl: String = ""
    @State private var scanImageUrl: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State var visible = false
    @State var shouldShowImagePicker = false
    @State var image: UIImage?
    @State private var StatusMessage = ""
    @State private var handle : String = ""
    @Environment(\.dismiss) var dismiss
    @State var error = ""
    @State var showAlert = false
    private let user = GIDSignIn.sharedInstance.currentUser
  
    private func isValidPassword(_ password: String) -> Bool {
        // minimum 8 characters long
        // 1 uppercase character
        // 1 lowerrcase character
        // 1 special char
        
        let passwordRegex = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[d$#$%&'()*+,-./:;<=>?@\\[\\\\\\]^_`{|}~])[A-Za-z\\dd$#$%&'()*+,-./:;<=>?@\\[\\\\\\]^_`{|}~]{8,}")
        
        return passwordRegex.evaluate(with: password)
    }
    
    private func storeUserInformation(imageProfileUrl: URL){
          guard let uid = Auth.auth().currentUser?.uid else { return }
        let userData = ["name": self.name, "email": self.email,"profileImageUrl": imageProfileUrl.absoluteString, "uid": uid]
        
          Firestore.firestore().collection("users")
              .document(uid).setData(userData) { error in
                
                  if let error = error {
                      print(error)
                      return
                  }
                  print("success")
              }
      }
    
 
    private func persisImageToStorage() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let ref = Storage.storage().reference(withPath: uid)
        guard let imageData = self.image?.jpegData(compressionQuality: 0.5) else {return}
        ref.putData(imageData, metadata: nil){metadata, err in
            if let err = err {
                self.StatusMessage = "Failed to push image to Storage: \(err)"
                return
            }
            
            ref.downloadURL{url, err in
                if let err = err {
                    self.StatusMessage = "Failed to retrieve downloadURL: \(err)"
                    return
                }
                
                self.StatusMessage = "Successfully stored image with url \(url?.absoluteString ?? "")"
                print(url?.absoluteString)
                
                guard let url = url else {return}
                self.storeUserInformation(imageProfileUrl: url)
            }
        }
    }
    
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                HStack{
                    Button{
                        shouldShowImagePicker.toggle()
                    } label: {
                        
                        HStack {
                            
                            if let image = self.image {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFit()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 128, height: 128)
                                    .cornerRadius(64)
                            }else{
                                
                                Image(systemName: "person.crop.circle.fill.badge.plus")
                                    .font(.system(size: 100))
                                    .padding()
                                    .foregroundColor(Color("4F704B"))
                            }
                        }
                        
                        .padding(.bottom, 20)
                        .padding()
                    }
                }
                
                HStack{
                    Text("สร้างบัญชีใหม่!")
                        .font(.custom(
                            "NotoSans-Bold",
                            fixedSize: 24))
                    
                }
                .padding(.top, -20)
                .padding(.bottom, 20)
                
                HStack{
                    Image(systemName: "person.fill")
                    TextField("ชื่อผู้ใช้", text: $name)
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
                
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "envelope.fill")
                        TextField("อีเมล", text: self.$email)
                            .font(.system(size: 14))
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                        
                        Spacer()
                        
                        if(email.count != 0) {
                            
                            Image(systemName: email.isValidEmail() ? "checkmark" : "xmark")
                                .foregroundColor(email.isValidEmail() ? .green : .red)
                        }
                    }
                    .foregroundColor(Color("4F704B"))
                    .padding(.vertical, 10)
                    .padding(.horizontal, 18)
                    .background(
                        RoundedRectangle(cornerRadius: 50)
                            .fill(Color("textfield"))
                    )
                    
                    Text("• รูปแบบอีเมล yourname@domain.com")
                        .font(.system(size: 10))
                        .foregroundColor(Color("dark-pink"))
                        .accentColor(Color("dark-pink"))
                }
                .padding(.bottom, 20)
                
                VStack(alignment: .leading) {
                    HStack {
                        
                        Image(systemName: "lock.fill")
                        
                        VStack{
                            
                            if self.visible{
                                TextField("รหัสผ่าน", text: self.$password)
                                    .font(.system(size: 14))
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                            }
                            else{
                                SecureField("รหัสผ่าน",text: self.$password)
                                    .font(.system(size: 14))
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                            }
                        }
                        
                        if(password.count != 0) {
                            
                            Image(systemName: isValidPassword(password) ? "checkmark" : "xmark")
                                .foregroundColor(isValidPassword(password) ? .green : .red)
                        }
                        Button(action: {
                            self.visible.toggle()
                        }) {
                            Image(systemName: self.visible ? "eye" : "eye.slash" )
                            
                        }
                        
                    }
                    .foregroundColor(Color("4F704B"))
                    .padding(.vertical, 10)
                    .padding(.horizontal, 18)
                    .background(
                        RoundedRectangle(cornerRadius: 50)
                            .fill(Color("textfield"))
                    )
                    
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
                    
                }
                .padding(.bottom, 20)
                
                HStack {
                    Button {
                        if !name.isEmpty && image != nil && isValidPassword(password) {
                            
                            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                                
                                if let error = error {
                                    print("Failed to create user:",error)
                                    return
                                }
                                print("Successfully created user: \(authResult?.user.uid ?? "")")
                                
                                self.StatusMessage = "Successfully created user: \(authResult?.user.uid ?? "")"
                                
                                self.persisImageToStorage()
                                
                                
                                if let authResult = authResult {
                                    print(authResult.user.uid)
                                    userID = authResult.user.uid
                                }
                                
                                self.isUserCurrentlyLoggedOut = true
                            }
                        } else {
                         error = "กรุณากรอกชื่อผู้ใช้, เลือกรูป และใส่รหัสผ่านตามกฎที่กำหนด"
                        showAlert = true
                        }
                        
                    } label: {
                        
                        Text("สมัครสมาชิก")
                            .foregroundColor(Color("FFEA9A"))
                            .font(.system(size: 14))
                            .bold()
                        
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 10)
                        
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color("4F704B"))
                            )
                    }
                    .alert(isPresented: $showAlert) {
                            Alert(title: Text("การสมัครยังไม่สำเร็จ"), message: Text(error), dismissButton: .default(Text("ตกลง")))
                        }
                   
                    
                }
                .padding(.top, 20)
                .padding(.bottom, 30)
                
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
                    Button(action: {
                        dismiss()
                
                    }) {
                        HStack {
                            Text("คุณมีบัญชีผู้ใช้แล้วใช่หรือไม่")
                                .foregroundColor(.black.opacity(0.7))
                                .font(.custom(
                                    "NotoSans-Regular",
                                    fixedSize: 14))
                                .foregroundColor(Color("0B0B0B"))
                            Text("เข้าสู่ระบบ!")
                                .font(.custom(
                                    "NotoSans-Bold",
                                    fixedSize: 14))
                                .foregroundColor(Color("4F704B"))
                                .bold()
                        }
                    }
                    
                }
                .padding(.top, 20)
                
            }
           
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 30)
        .padding(.top, 10)
        .background(
            Color(.white)
                .ignoresSafeArea()
        )
        .fullScreenCover(isPresented: $shouldShowImagePicker, onDismiss: nil) {
            ImagePicker(image: $image)
        }
        .onTapGesture {
            self.hideKeyboard()
        }
    
    }
}

struct SignupView_Previews: PreviewProvider {
    @State static var isUserCurrentlyLoggedOut = false
    static var previews: some View {
        SignupView(isUserCurrentlyLoggedOut: $isUserCurrentlyLoggedOut)
    }
}
