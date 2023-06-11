//
//  CustomTabbar.swift
//  doorianMock
//
//  Created by Warunya on 28/3/2566 BE.
//

import SwiftUI
import FirebaseAuth

var tabs = ["house.fill", "viewfinder", "person.fill"]

struct TabButton: View {
    var image: String
    
    @Binding var selectedTab : String
   
    
    var body: some View {
        Button(action: {selectedTab = image}) {
            ZStack {
                if image == "viewfinder" {
                    Circle()
                        .frame(width: 50, height: 50)
                        .foregroundColor(Color("red-button"))
                }
                
                VStack {
                    Image(systemName: image)
                        .imageScale(.large)
                        .foregroundColor(
                            selectedTab == image ? Color("dark-green") : Color("grey-icon")
                        )
                        .padding(.bottom, 2)
                    
                    
                    if image == "house.fill" {
                        Text("หน้าแรก")
                            .font(.system(size: 10))
                            .foregroundColor(
                                selectedTab == image ? Color("dark-green") : Color("grey-icon")
                            )
                    } else if image == "person.fill" {
                        Text("โปรไฟล์")
                            .font(.system(size: 10))
                            .foregroundColor(
                                selectedTab == image ? Color("dark-green") : Color("grey-icon")
                            )
                    }
                }
            }
        }
    }
}

struct CustomTabbar: View {
    @State var selectedTab = "house.fill"
//    @State private var isUserCurrentlyLoggedOut : Bool = false
    @State var shouldShowLogoutOption = false
    @Binding var isUserCurrentlyLoggedOut  : Bool
    
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            
            TabView(selection: $selectedTab) {
                HomeView(isUserCurrentlyLoggedOut: $isUserCurrentlyLoggedOut)
                    .tag("house.fill")
                ScanPicker(classifier: ImageClassifier(), disease: Disease(id: 0, name: "", label: "", type: "", scientificName: "", cause: "", descriptionDisease: "", symptom1: "", symptom2: "", symptom3: "", symptom4: "", symptom5: "", descriptionSolution1: "", recommend: "", solution1: "", solution2: "", solution3: "", solution4: "", descriptionSolution2: "", protect1: "", protect2: "", protect3: ""))
                    .tag("viewfinder")
                ProfileView(isUserCurrentlyLoggedOut: $isUserCurrentlyLoggedOut)
                    .tag("person.fill")
            }
            .actionSheet(isPresented: $shouldShowLogoutOption) {
                .init(title: Text("Sign out"), message:Text("คุณต้องการออกจากสู่ระบบหรือไม่?"), buttons: [
                   .destructive(Text("ยืนยัน"), action: {
                       print("handle sign out")
                       try? Auth.auth().signOut()
                       self.isUserCurrentlyLoggedOut = false
                   }),
                   .cancel(Text("ยกเลิก"))
                ])
            }
            
            
            HStack(spacing: 0) {
                ForEach(tabs, id: \.self) { image in
                    
                    TabButton(image: image, selectedTab: $selectedTab)
                    
                    if image != tabs.last {
                        Spacer(minLength: 0)
                    }
                }
            }
            .padding(.horizontal, 62)
            .padding(.vertical, 10)
            .background(Color("FCFCFC"))
        }
        
    }
}

struct ScanView: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> some UIViewController {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let controller = storyboard.instantiateViewController(identifier: "Scan")
        
        return controller
        
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
}

struct CustomTabbar_Previews: PreviewProvider {
    @State static var isUserCurrentlyLoggedOut = false
    static var previews: some View {
        CustomTabbar(isUserCurrentlyLoggedOut: $isUserCurrentlyLoggedOut)
    }
}

