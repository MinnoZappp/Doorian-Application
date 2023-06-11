//
//  ScanPickerButton.swift
//  doorianMock
//
//  Created by Warunya on 2/5/2566 BE.
//

import SwiftUI
import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

struct ScanPickerButton: View {
    @State var isPresenting: Bool = false
    @State private var scanImageUrl: String = ""
    @State var uiImage: UIImage?
    @State var sourceType:
    UIImagePickerController.SourceType = .photoLibrary
    @State private var StatusMessage = ""
    @State private var showUpdateImageAlert: Bool = false
    
    @ObservedObject var classifier: ImageClassifier
    @AppStorage("uid") var userID: String = ""
    
    
    private func updateScanImageUser(scanImageUrl: URL){
          guard let uid = Auth.auth().currentUser?.uid else { return }
       
        let scanImage = ["scanImageUrl": scanImageUrl.absoluteString, "uid": uid]
          Firestore.firestore().collection("users")
              .document(uid).updateData(scanImage) { err in
                
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
        guard let imageData = self.uiImage?.jpegData(compressionQuality: 0.5) else {return}
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
                self.updateScanImageUser(scanImageUrl: url)
            }
        }
    }
    
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "photo")
                    .onTapGesture {
                        isPresenting = true
                        sourceType = .photoLibrary
                    }
                
                Image(systemName: "camera")
                    .onTapGesture {
                        isPresenting = true
                        sourceType = .camera
                    }
            }
            .font(.title)
            .foregroundColor(.blue)
            
            Rectangle()
                .strokeBorder()
                .foregroundColor(.yellow)
                .overlay(
                    Group {
                        if let uiImage = self.uiImage {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFit()
                        }
                    }
                )
            
            VStack{
//                Button(action: {
//                    if uiImage != nil {
//                        classifier.detect(uiImage: uiImage!)
////                        self.persisImageToStorage()
////                        self.showUpdateImageAlert = true
//                    }
//                }) {
//                    Image(systemName: "bolt.fill")
//                        .foregroundColor(.orange)
//                        .font(.title)
//                }
//                HStack{
                    Button(action: {
                        self.persisImageToStorage()
                        self.showUpdateImageAlert = true
                    }) {
                        Text("บันทึก")
                            .foregroundColor(Color("FFEA9A"))
                            .font(.custom(
                                "NotoSans-Bold",
                                fixedSize: 14))
                        
                    }
                    
//                }
                
                Group {
                    if let imageClass = classifier.imageClass {
                        HStack{
                            Text("Image23 categories:")
                                .font(.caption)
                            Text(imageClass)
                                .bold()
                            Text("สวัสดี")
                        }
                    } else {
                        HStack{
                            Text("Image categories: NA")
                                .font(.caption)
                        }
                    }
                }
                .font(.subheadline)
                .padding()
                
            }
        }
        
        .sheet(isPresented: $isPresenting){
            ImagePick(uiImage: $uiImage, isPresenting:  $isPresenting, sourceType: $sourceType)
                .onDisappear{
                    if uiImage != nil {
                        classifier.detect(uiImage: uiImage!)
                        
                     
                                      
                       
                    }
                }
            
        }
        
        
        
        
        
        
        .padding()
    }
}


struct ScanPickerButton_Previews: PreviewProvider {
    static var previews: some View {
        ScanPickerButton(classifier: ImageClassifier())
    }
}
