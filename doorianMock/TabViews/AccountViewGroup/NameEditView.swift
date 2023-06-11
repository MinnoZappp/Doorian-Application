//
//  NameEditView.swift
//  doorianMock
//
//  Created by Samitanun Sapsukdee on 29/3/2566 BE.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore
import SDWebImageSwiftUI

struct NameEditView: View {
    
    @AppStorage("uid") var userID: String = ""
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var profileImageUrl: String = ""
    @ObservedObject private var vm = MainMessagesView()
    @Environment(\.presentationMode) var presentationMode
    @State private var errString: String?
    @State private var showUpdateNameAlert: Bool = false
    
    
    private func updateNameUser(){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let userData = ["name":self.name, "uid": uid]
        if name != ""{
            Firestore.firestore().collection("users").document(uid)
                .updateData(userData){ err in
                    if let err = err {
                        print("Error updating document name: \(err)")
                    } else {
                        self.showUpdateNameAlert = true
                        print("Document name successfully updated")
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
                        
                        Text("แก้ไขชื่อผู้ใช้")
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
                    Image(systemName: "person.fill")
                    TextField("ชื่อผู้ใช้", text: self.$name)
                        .font(.custom(
                            "NotoSans-Regular",
                            fixedSize: 14))
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
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
                
                
                Button(action: {
                    self.updateNameUser()
                    self.showUpdateNameAlert = true
                
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
                .alert(isPresented: $showUpdateNameAlert) {
                    Alert(title: Text("Password Reset"),
                          message: Text(self.errString ?? "Success! Name update successfully"), dismissButton: .default(Text("OK")) {
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

struct NameEditView_Previews: PreviewProvider {
    static var previews: some View {
        NameEditView()
    }
}
