//
//  ResetPasswordView.swift
//  doorianMock
//
//  Created by Samitanun Sapsukdee on 29/3/2566 BE.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct ResetPasswordView: View {
    @State private var email: String = ""
    @AppStorage("uid") var userID: String = ""
    @Environment(\.presentationMode) var presentationMode
    @State private var showAlert = false
    @State private var showView = false
    @State private var errString: String?
    
    var body: some View {
        NavigationView{
            ZStack{
                Color(.white).edgesIgnoringSafeArea(.all)
                VStack{
                    HStack{
                        Image("doorian_logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .padding()
                    }
                    .padding(.top)
                    HStack{
                        Text("ลืมรหัสผ่าน?")
                            .font(.custom(
                                "NotoSans-Bold",
                                fixedSize: 24))
                        
                    }
                    .padding()
                    HStack{
                        Text("กรุณากรอกอีเมลของคุณที่ช่องด้านล่าง")
                            .font(.custom(
                                "NotoSans-Bold",
                                fixedSize: 14))
                            .foregroundColor(Color("4F704B"))
                    }
                    HStack{
                        Text("เราจะทำการส่งอีเมลตั้งรหัสผ่านใหม่ให้แก่คุณ!")
                            .font(.custom(
                                "NotoSans-Bold",
                                fixedSize: 14))
                            .foregroundColor(Color("4F704B"))
                    }
                    
                    HStack{
                        Image(systemName: "mail")
                        TextField("อีเมล", text: $email)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .font(.custom(
                                "NotoSans-Regular",
                                fixedSize: 14))
                        
                        
                        Spacer()
                        if(email.count != 0) {
                            Image(systemName: email.isValidEmail() ? "checkmark" : "xmark")
                                .foregroundColor(email.isValidEmail() ? .green : .red)
                        }
                        
                    }
                    .padding()
                    .foregroundColor(Color("4F704B"))
                    .background(
                        RoundedRectangle(cornerRadius: 50)
                            .fill(Color("gray-white"))
                    )
                    .padding()
                    
                    Button(action: {
                        ResetEmailAuth.resetPassword(email: self.email) { (result) in
                            switch result {
                            case .failure(let error):
                                self.errString = error.localizedDescription
                            case .success( _):
                                break
                            }
                            self.showAlert = true

                        }
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
                                RoundedRectangle(cornerRadius: 50)
                                    .fill(Color("4F704B"))
                            )
                            .padding(.horizontal)
                            
                    }
                    
                    
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("การเปลี่ยนรหัสผ่าน"),
                      message: Text(self.errString ?? "สำเร็จ! เราทำการส่งอีเมลตั้งรหัสผ่านใหม่แก่คุณแล้ว"), dismissButton: .default(Text("ตกลง")) {
                    self.presentationMode.wrappedValue.dismiss()
                    



                })
            }
            
        }
    }
}

struct ResetEmailAuth{
    static func resetPassword(email:String, resetCompletion:@escaping (Result<Bool,Error>) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email, completion: { (error) in
            if let error = error {
                resetCompletion(.failure(error))
            } else {
                resetCompletion(.success(true))
            }

        })
    }
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView()
    }
}
