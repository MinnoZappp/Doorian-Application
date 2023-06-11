//
//  EmailEditView.swift
//  doorianMock
//
//  Created by Samitanun Sapsukdee on 29/3/2566 BE.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore
import SDWebImageSwiftUI
import Firebase

struct EmailEditView: View {
    
    @AppStorage("uid") var userID: String = ""
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var profileImageUrl: String = ""
    @Environment(\.presentationMode) var presentationMode
    @State private var errString: String?
    @ObservedObject private var vm = MainMessagesView()
    @State private var showUpdateEmailAlert: Bool = false
    
    
    
    private func updateEmailUser(){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let userEmail = Auth.auth().currentUser?.email
        let currentUser = Auth.auth().currentUser
        let userData = ["email":self.email, "uid": uid]
        if email != ""{
            Firestore.firestore().collection("users").document(uid)
                .updateData(userData){ err in
                    if let err = err {
                        print("Error updating document email: \(err)")
                    } else {
                        self.showUpdateEmailAlert = true
                        print("Document email successfully updated")
                    }
                }
            if email != userEmail{
                currentUser?.updateEmail(to: email){ err in
                    if let err = err {
                        print("Error updating email in firebase: \(err)")
                    } else {
                        print("Document email successfully updated!")
                    }

                }
            }
        }

      }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
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
                        
                        Text("แก้ไขอีเมล")
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
                
                HStack {
                    Image(systemName: "envelope.fill")
                    TextField("อีเมล", text: self.$email)
                        .font(.custom(
                            "NotoSans-Regular",
                            fixedSize: 14))
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
                        .fill(Color("gray-white"))
                )
                .padding()
                .padding(.top, 10)
                HStack{
                    Text("• รูปแบบอีเมล yourname@domain.com")
                        .font(.system(size: 10))
                        .foregroundColor(Color("dark-pink"))
                        .accentColor(Color("dark-pink"))
                } .padding(.leading,20)
                    .padding(.top,-5)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                
                
                Button(action: {
                    self.updateEmailUser()
                }) {
                    Text("บันทึก")
                        .foregroundColor(Color("FFEA9A"))
                        .font(.custom(
                            "NotoSans-Bold",
                            fixedSize: 14))
                    
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                    
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color("4F704B"))
                        )
                }
                .padding()
                .alert(isPresented: $showUpdateEmailAlert) {
                    Alert(title: Text("Password Reset"),
                          message: Text(self.errString ?? "Success! Email update successfully"), dismissButton: .default(Text("OK")) {
                        self.presentationMode.wrappedValue.dismiss()
                        
                    })
                }
                
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Color(.white)
                .ignoresSafeArea()
        )
    }
}

struct EmailEditView_Previews: PreviewProvider {
    static var previews: some View {
        EmailEditView()
    }
}
