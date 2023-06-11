//
//  AccountView.swift
//  doorianMock
//
//  Created by Samitanun Sapsukdee on 29/3/2566 BE.
//

import SwiftUI
import FirebaseAuth
import FirebaseStorage
import SDWebImageSwiftUI
import Firebase

struct AccountView: View {
    @ObservedObject private var vm = MainMessagesView()
    @AppStorage("uid") var userID: String = ""
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var StatusMessage = ""
    @State var shouldShowImagePicker = false
    @State var image: UIImage?
    @State private var profileImageUrl: String = ""
    @Environment(\.editMode) private var editMode
    @Environment(\.presentationMode) var presentationMode
    @State private var errString: String?
    @Binding var isUserCurrentlyLoggedOut  : Bool
    @State private var showUpdateImageAlert: Bool = false
    
    private func updateImageUser(imageProfileUrl: URL){
          guard let uid = Auth.auth().currentUser?.uid else { return }
       
        let userImage = ["profileImageUrl": imageProfileUrl.absoluteString, "uid": uid]
          Firestore.firestore().collection("users")
              .document(uid).updateData(userImage) { err in
                
                  if let err = err {
                      print("Error updating document image: \(err)")
                    
                  } else {
                      self.showUpdateImageAlert = true
                      print("Document image successfully updated")
                  }
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
                self.updateImageUser(imageProfileUrl: url)
            }
        }
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack{
                
                VStack(spacing: 15){
                    
                    VStack{
                        
                        
//                        NavigationLink(destination: NameEditView()){
                        Button{
                            shouldShowImagePicker.toggle()
                        } label: {
                            
                            HStack {
                               
                                   
                                if let image = self.image {
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFit()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 120, height: 120)
                                        .clipShape(Circle())
                                        .overlay(Circle().stroke(Color("A3B694"), lineWidth: 10))
                                        .offset(y: -40)
                                        .padding(.bottom,-40)
                                        .padding(.leading, 45)
                                    
                                    Image(systemName: "plus.circle.fill")
                                        .foregroundColor(Color("0B0B0B"))
                                        .font(.system(size: 45))
                                        .offset(y: -5)
                                        .offset(x: -45)
                                        .padding(.bottom,-40)
                                   
                                }else{
                                    WebImage(url: URL(string: vm.chatUser?.profileImageUrl ?? ""))
                                        .resizable()
                                        .scaledToFit()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 120, height: 120)
                                        .clipShape(Circle())
                                        .overlay(Circle().stroke(Color("A3B694"), lineWidth: 10))
                                        .offset(y: -40)
                                        .padding(.bottom,-40)
                                        .padding(.leading, 45)
                                    
                                    Image(systemName: "plus.circle.fill")
                                        .foregroundColor(Color("0B0B0B"))
                                        .font(.system(size: 45))
                                        .offset(y: -5)
                                        .offset(x: -45)
                                        .padding(.bottom,-40)
                                }
                            }
                        
                        }
                    
                    }
                    
                           
                    HStack(alignment: .top, spacing: 10){
                       
                            let name = vm.chatUser?.name.replacingOccurrences(of: "", with: "") ?? ""
                            Text(name)
                                .font(.custom(
                                    "NotoSans-Bold",
                                    fixedSize: 18))
                                .foregroundColor(.white)
                                .padding(.top, 5)
                                .bold()
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                  
                    
                    Spacer()
                    
                } // Vstack 15
                .padding([.horizontal,.bottom])
                .background(
                    Color("4F704B")
                        .cornerRadius(12)
                )
                .padding()
                .padding(.top,40)
                .padding(.bottom, -10)
        
                
                HStack{
                    Text("ชื่อผู้ใช้")
                        .font(.custom("NotoSans-Bold", size: 16))
                        .foregroundColor(Color("4F704B"))
                        .bold()
                }
                .padding(.top,15)
                .padding(.leading,15)
                .frame(maxWidth: .infinity, alignment: .leading)
                HStack{
                    NavigationLink(destination: NameEditView()){
                        
                        let name = vm.chatUser?.name.replacingOccurrences(of: "", with: "") ?? ""
                        Text(name)
                            .font(.custom(
                                "NotoSans-Regular",
                                fixedSize: 14))
                            .foregroundColor(Color("4F704B"))
                        Spacer()
                        
                        Image(systemName: "pencil")
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
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top,-5)
                .padding(10)
                
                
                HStack{
                    Text("อีเมล")
                        .font(.custom("NotoSans-Bold", size: 16))
                        .foregroundColor(Color("4F704B"))
                        .bold()
                }
                .padding(.top,-15)
                .padding(.leading,15)
                .frame(maxWidth: .infinity, alignment: .leading)
                HStack{
                    NavigationLink(destination: EmailEditView()){
                        let email = vm.chatUser?.email.replacingOccurrences(of: "", with: "") ?? ""
                        Text(email)
                            .font(.custom(
                                "NotoSans-Regular",
                                fixedSize: 14))
                            .foregroundColor(Color("4F704B"))
                        Spacer()
                        
                        Image(systemName: "pencil")
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
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top,-5)
                .padding(10)
                
                HStack{
                    Button(action: {
                        self.persisImageToStorage()
                        self.showUpdateImageAlert = true
                    }) {
                        Text("บันทึก")
                            .foregroundColor(Color("FFEA9A"))
                            .font(.custom(
                                "NotoSans-Bold",
                                fixedSize: 14))
                            .bold()
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 10)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color("4F704B"))
                            )
                        
                    }
                    
                }
                .padding(.top, 5)
                .padding(10)
                
                .alert(isPresented: $showUpdateImageAlert) {
                    Alert(title: Text("การเปลี่ยนรูปภาพ")
                        .foregroundColor(.black)
                        .bold(),
                          message: Text(self.errString ?? "สำเร็จ! คุณได้เปลี่ยนรูปภาพเรียบร้อย")
                        .foregroundColor(Color("0B0B0B"))
                          , dismissButton: .default(Text("ตกลง")
                            .foregroundColor(Color("dark-pink"))
                            .bold()
                            ))
                }
                
            }
            .padding(.horizontal,22)
            .padding(.vertical,20)
            
        }
        
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Color(.white)
                .ignoresSafeArea()
        )
        .fullScreenCover(isPresented: $shouldShowImagePicker, onDismiss: nil) {
            ImagePicker(image: $image)
                
        }
       
        
    }
}


struct AccountView_Previews: PreviewProvider {
    @State static var isUserCurrentlyLoggedOut = false
    static var previews: some View {
        AccountView(isUserCurrentlyLoggedOut: $isUserCurrentlyLoggedOut)
    }
}
