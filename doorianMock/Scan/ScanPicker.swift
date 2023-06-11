//
//  ScanPicker.swift
//  doorianMock
//
//  Created by Warunya on 15/5/2566 BE.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore
import CoreLocationUI

struct ScanPicker: View {
    
    @State var isPresenting: Bool = false
    
    @State private var scanImageUrl: String = ""
    @State var uiImage: UIImage?
    @State var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var StatusMessage = ""
    @State private var showUpdateImageAlert: Bool = false
    @ObservedObject var HomeModel = HomeViewModel()
    
    @ObservedObject var classifier: ImageClassifier
    @AppStorage("uid") var userID: String = ""
    
    @EnvironmentObject var modelData: ModelData
    
    var disease: Disease
 
    private func updateScanImageUser(scanImageUrl: URL, imageClass: String, userAddress: String) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let id = UUID().uuidString
        
        let scanImage = ["id": id,"scanImageUrl": scanImageUrl.absoluteString, "imageClass": imageClass,"dateCreated": Timestamp(date: Date()), "userAddress": userAddress] as [String : Any]
        
        let userRef = Firestore.firestore().collection("users").document(uid)
        userRef.collection("scan history").addDocument(data: scanImage) { error in
            if let error = error {
                print("Error adding document to scan history subcollection: \(error)")
            } else {
                self.showUpdateImageAlert = true
                print("Document image successfully added to scan history subcollection")
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
                guard let imageClass = classifier.imageClass else {return}
               
                self.updateScanImageUser(scanImageUrl: url, imageClass: imageClass, userAddress: HomeModel.userAddress)
            }
        }
    }
    
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("4F704B")
                    .ignoresSafeArea()
                
                VStack {
                        HStack {
                            Image(systemName: "photo.fill")
                            Text("อัลบั้มรูปภาพ")
                                .bold()
                        }
                        .font(.system(size: 24))
                        .padding(.vertical, 25)
                        .padding(.horizontal, 36)
                        .background(.white)
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.black, lineWidth: 2)
                        )
                        .onTapGesture {
                            isPresenting = true
                            sourceType = .photoLibrary
                        }
                        
                        Spacer()
                            .frame(height: 36)
                        
                        HStack {
                            Image(systemName: "camera.fill")
                            Text("กล้องถ่ายรูป")
                                .bold()
                        }
                        .font(.system(size: 24))
                        .padding(.vertical, 25)
                        .padding(.horizontal, 36)
                        .background(.white)
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.black, lineWidth: 2)
                        )
                        .onTapGesture {
                            isPresenting = true
                            sourceType = .camera
                        }
                }
                .fullScreenCover(isPresented: $isPresenting) {
                    ImagePick(uiImage: $uiImage, isPresenting: $isPresenting, sourceType: $sourceType)
                        .onDisappear{
                            if uiImage != nil {
                                classifier.detect(uiImage: uiImage!)
                            }
                        }
                }
                
                if uiImage != nil {
                    ZStack {
                        Image(uiImage: uiImage!)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: 390, maxHeight: .infinity)
                            .ignoresSafeArea()
                        
                        VStack() {
                            HStack {
                                Button(action: {
                                    uiImage = (hidden() as? UIImage)
                                }) {
                                    ZStack {
                                        Circle()
                                            .frame(width: 30)
                                            .foregroundColor(.white)
                                        Image(systemName: "arrow.backward")
                                            .font(.system(size: 15))
                                            .foregroundColor(.black)
                                    }
                                    .shadow(radius: 10)
                                }
                                
                                Spacer()
                                
                                Text(HomeModel.userAddress)
                                    .opacity(0)
                                
                                Button(action: {
                                    self.persisImageToStorage()
                                    self.showUpdateImageAlert = true
                                }) {
                                    ZStack {
                                        Circle()
                                            .frame(width: 30)
                                            .foregroundColor(.white)
                                        Image(systemName: "square.and.arrow.down.fill")
                                            .font(.system(size: 15))
                                            .foregroundColor(.black)
                                    }
                                    .shadow(radius: 10)
                                }
                                
                            }
                            .padding(.top, 16)
                            .padding(.horizontal, 20)
                            
                            Spacer()
                            
                            VStack {
//                                Text("🔎 ผลลัพธ์ที่คาดว่าจะเป็น")
//                                    .font(.system(size: 18, weight: .heavy))
//                                    .padding(.bottom, 18)
                                    
                                    VStack {
                                        if let stableClass = classifier.imageClass {
                                            
//                                                Image(uiImage: uiImage!)
//                                                    .resizable()
//                                                    .frame(width: 150, height: 170)
//                                                    .cornerRadius(20)
                                                
                                                Spacer()
                                                
                                                    Group {
                                                        //                                            Text(stableClass)
                                                        if stableClass == durianDisease.diseaseAgalSpot {
                                                            VStack {
                                                                Text("🔎 ผลลัพธ์ที่คาดว่าจะเป็น")
                                                                    .font(.system(size: 18, weight: .heavy))
                                                                    .padding(.bottom, 18)
                                                                
                                                                HStack(alignment: .top) {
                                                                    Image(uiImage: uiImage!)
                                                                        .resizable()
                                                                        .frame(width: 150, height: 170)
                                                                        .cornerRadius(20)
                                                                    
                                                                    VStack(alignment: .leading) {
                                                                        Text("\(durianDisease.diseaseAgalSpotTH) (\(durianDisease.sciAgalSpot))")
                                                                            .foregroundColor(Color("4F704B"))
                                                                            .font(.system(size: 18, weight: .heavy))
                                                                            .bold()
                                                                            .padding(.bottom, 4)
                                                                        
                                                                        Group {
                                                                            Text("ข้อมูลทั่วไป")
                                                                                .padding(.bottom, 2)
                                                                            Text(durianDisease.genAgalSpot1)
                                                                            Text(durianDisease.genAgalSpot2)
                                                                            Text(durianDisease.genAgalSpot3)
                                                                        }
                                                                        .font(.system(size: 14))
                                                                        
                                                                        NavigationLink {
                                                                            ResultFullView(classifier: classifier, disease: disease)
                                                                        } label: {
                                                                            Text("อ่านเพิ่มเติม")
                                                                                .font(.system(size: 12))
                                                                                .foregroundColor(Color("FFEA9A"))
                                                                                .bold()
                                                                                .frame(maxWidth: 180, maxHeight: 26)
                                                                                .background(Color("4F704B"))
                                                                                .cornerRadius(30)
                                                                        }
                                                                    }
                                                                    
                                                                    
                                                                }
                                                            }
                                                            .padding()
                                                            .background(Color.white)
                                                            .cornerRadius(20)
                                                            .frame(width: 430)
                                                            
                                                        } else if stableClass == durianDisease.diseaseAnthracnose {
                                                            
                                                            VStack {
                                                                Text("🔎 ผลลัพธ์ที่คาดว่าจะเป็น")
                                                                    .font(.system(size: 18, weight: .heavy))
                                                                    .padding(.bottom, 18)
                                                                
                                                                HStack(alignment: .top) {
                                                                    Image(uiImage: uiImage!)
                                                                        .resizable()
                                                                        .frame(width: 150, height: 170)
                                                                        .cornerRadius(20)
                                                                    
                                                                    VStack(alignment: .leading) {
                                                                        Text("\(durianDisease.diseaseAnthracnoseTH) (\(durianDisease.sciAnthracnose))")
                                                                            .foregroundColor(Color("4F704B"))
                                                                            .font(.system(size: 18, weight: .heavy))
                                                                            .bold()
                                                                            .padding(.bottom, 6)
                                                                        
                                                                        Group {
                                                                            Text("ข้อมูลทั่วไป")
                                                                                .padding(.bottom, 4)
                                                                            Text(durianDisease.genAntracnose1)
                                                                            Text(durianDisease.genAntracnose2)
                                                                            Text(durianDisease.genAntracnose3)
                                                                        }
                                                                        .font(.system(size: 14))
                                                                        
                                                                        NavigationLink {
                                                                            ResultFullView(classifier: classifier, disease: disease)
                                                                        } label: {
                                                                            Text("อ่านเพิ่มเติม")
                                                                                .font(.system(size: 12))
                                                                                .foregroundColor(Color("FFEA9A"))
                                                                                .bold()
                                                                                .frame(maxWidth: 180, maxHeight: 26)
                                                                                .background(Color("4F704B"))
                                                                                .cornerRadius(30)
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                            .padding()
                                                            .background(Color.white)
                                                            .cornerRadius(20)
                                                            .frame(width: 430)
                                                            
                                                        } else {
                                                            ZStack {
                                                                VStack {
                                                                    Text("ลองอีกครั้ง")
                                                                        .font(.system(size: 18, weight: .heavy))
                                                                        .padding(.top, 30)
                                                                        .padding(.bottom, 8)
                                                                    
                                                                    Text("ขออภัย เราไม่สามารถระบุชนิดใบได้")
                                                                        .font(.system(size: 10, weight: .heavy))
                                                                        .padding(.bottom, 8)
                                                                    
                                                                    Text("คุณสามารถอัปโหลดรูปเพื่อให้เราช่วยเหลือใหม่อีกครั้ง!")
                                                                        .font(.system(size: 12))
                                                                        .foregroundColor(.black)
                                                                        .padding(.bottom, 16)
                                                                    
                                                                    VStack {
                                                                        Link("อัปโหลดรูป", destination: URL(string: "https://forms.gle/z3VhbgbKn8jWBufFA")!)
                                                                            .font(.system(size: 12, weight: .heavy))
                                                                            .foregroundColor(.white)
                                                                    }
                                                                    .frame(width: 200, height: 30)
                                                                    .background(Color("dark-pink"))
                                                                    .cornerRadius(100)
                                                                    
//                                                                    Button(action: {
//                                                                        openURL(URL(string: "https://forms.gle/z3VhbgbKn8jWBufFA")!)
//                                                                    }) {
//                                                                        Text("อัปโหลดรูป")
//                                                                            .font(.system(size: 12, weight: .heavy))
//                                                                            .foregroundColor(.white)
//                                                                    }
//                                                                    .frame(width: 200, height: 30)
//                                                                    .background(Color("dark-pink"))
//                                                                    .cornerRadius(100)
                                                                }
                                                                .padding()
                                                                .frame(width: 300, height: 200)
                                                                .background(.white)
                                                                .cornerRadius(20)
                                                                
                                                                Group {
                                                                    Circle()
                                                                        .fill(Color("FFC700"))
                                                                        .frame(width: 60)
                                                                        .overlay(Circle().stroke(Color.white, lineWidth: 10))
                                                                    
                                                                    
                                                                    Image(systemName: "questionmark")
                                                                        .font(.system(size: 30))
                                                                        .foregroundColor(.white)
                                                                }
                                                                .offset(y: -90)
                                                            }
                                                        }
                                                        
                                                        
                                                    }
                                                    .onAppear {
                                                        if stableClass != classifier.imageClass {
                                                            // Only update the UI if the stableClass is different from the current imageClass
                                                            DispatchQueue.main.async {
                                                                classifier.objectWillChange.send()
                                                            }
                                                        }
                                                    }
                                                
                                            
                                        } else {
                                            VStack {
                                                Text("🔎 ผลลัพธ์ที่คาดว่าจะเป็น")
                                                    .font(.system(size: 18, weight: .heavy))
                                                    .padding(.bottom, 18)
                                                
                                                Text("Processing...")
                                                    .font(.system(size: 18))
                                                    .italic()
                                                    .foregroundColor(Color("E0E0E0"))
                                                    .padding(.bottom, 6)
                                            }
                                            .padding()
                                            .background(Color.white)
                                            .cornerRadius(20)
                                            .frame(width: 430)
                                        }
                                        
                                    }
                                .padding(.bottom, 30)
                            }
                            
                        }
                    }
                }
            }
        }
    }
}

struct ScanPicker_Previews: PreviewProvider {
    static var diseases = ModelData().diseases
    
    static var previews: some View {
        ScanPicker(classifier: ImageClassifier(), disease: diseases[0])
    }
}
