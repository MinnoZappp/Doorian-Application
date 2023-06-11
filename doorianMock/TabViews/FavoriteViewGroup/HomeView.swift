//
//  HomeView.swift
//  doorianMock
//
//  Created by Warunya on 28/3/2566 BE.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseStorage
import CoreLocation
import SDWebImageSwiftUI
import CoreLocationUI
import GoogleSignIn
import MapKit


struct HomeView: View {
    
    private let user = GIDSignIn.sharedInstance.currentUser
    @Binding var isUserCurrentlyLoggedOut  : Bool
    @ObservedObject private var vm = MainMessagesView()
    @State private var name: String = ""
    @StateObject var HomeModel = HomeViewModel()

    var body: some View {
        ZStack {
        
            VStack {
                ScrollView (.vertical, showsIndicators: true) {
                    Header()
                        .padding(.bottom, 23)
                    
                    GeneralNews()
                        .padding(.horizontal, 15)
                        .frame(maxWidth: .infinity)
                        .padding(20)
                        .padding(.top, -20)
                    
                    TodayNews()
                        .padding(.horizontal, 15)
                        .frame(maxWidth: .infinity)
                    
                }
            }
            
            
            if HomeModel.noLocation{
                
                Text("Please Enable Location Access In Setting To Further To Further Move On !!!")
                    .foregroundColor(.black)
                    .frame(width: UIScreen.main.bounds.width - 100, height: 120)
                    .background(Color.white)
                    .cornerRadius(10)
                    .frame(maxWidth: .infinity, maxHeight:  .infinity)
                    .background(Color.black.opacity(0.3).ignoresSafeArea())
            }
            
        }.onAppear(perform: {
            
            //calling location delegate
            HomeModel.locationManager.delegate = HomeModel
//            HomeModel.locationManager.requestWhenInUseAuthorization()
            // Modifying Info.plist
        })
        
    }
    
}


struct Header: View {
    @ObservedObject private var vm = MainMessagesView()
    private let user = GIDSignIn.sharedInstance.currentUser
    @State private var name: String = ""
    
    var body: some View {
        ZStack (alignment: .top){
            VStack {
                let name = vm.chatUser?.name.replacingOccurrences(of: "", with: "") ?? ""
                
                Group {
                    Text("🍀 สวัสดี!")
                        .font(.system(size: 18))
                        .padding(.bottom, 5)
                    Text("คุณ \(name)")
                        .font(.system(size: 24, weight: .heavy))
                        .padding(.bottom, 5)
                }
                .foregroundColor(Color.white)
            }
            .frame(maxWidth: .infinity, maxHeight: 150)
            .background(Color("bright-green"))
            
            
            Location()
                .padding(.top, 135)
        }
    }
}



struct Location: View {
    
    @StateObject var HomeModel = HomeViewModel()
  
    var body: some View {
        HStack {
            Image(systemName: "mappin.and.ellipse")
                .foregroundColor(Color("bright-green"))
//            Text(HomeModel.userLocation == nil ? "Locating..." : "Deliver To")
//                .foregroundColor(.black)
            Text(HomeModel.userAddress)
                .foregroundColor(.black)
 
        }
        .frame(width: 360, height: 30)
        .background(.white)
        .cornerRadius(100)
        .shadow(radius: 4, x: 0, y: 2)
    }

}


struct GeneralNews: View {
    @State var index = 0
    @ObservedObject var details2 = getGeneralContent()
 
    var body: some View {
        ZStack {
            
            VStack(alignment: .leading) {
                HStack{
                    Text("ประกาศทั่วไป")
                        .foregroundColor(.black)
                        .font(.system(size: 18, weight: .heavy))
                }
                if self.details2.contents.count != 0{
                    TabView(selection: self.$index) {
                        ForEach(self.details2.contents.indices, id: \.self) { index in
                            let content = self.details2.contents[index]
                            GeneralNewsCard(data: content)
                                .tag(index)
                        }
                    }
                    
                    .frame(height: 200)
                    .frame(maxWidth: .infinity)
                    .padding(.top,-1)
                    .tabViewStyle(PageTabViewStyle())
                }
                    
                
            }
        }
    }
       
}


struct TodayNews: View {
    @ObservedObject var details2 = getContent1()
  
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                    Text("ข่าววันนี้")
                        .font(.system(size: 18, weight: .heavy))
                        .foregroundColor(.black)
                        .padding(.top, -15)
                
                Spacer()
                NavigationLink(destination: ContentAllNews()) {
                    Text("ดูทั้งหมด")
                        .font(.system(size: 18, weight: .heavy))
                        .foregroundColor(Color("bright-green"))
                        .padding(.top, -15)
                    Image(systemName: "arrow.forward")
                        .foregroundColor(Color("bright-green"))
                        .font(.system(size: 18, weight: .heavy))
                        .padding(.top, -15)
                }
            }
            .padding()
            Spacer(minLength: 0)
                
                if self.details2.contents.count != 0{
                    
                    VStack{
                        
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 180), spacing: 15)], spacing: 15){
                            ForEach(self.details2.contents){ i in
                                
                                NewsCard(data: i)
                                   
                                
                                
                            }
                        }.padding()
                            .padding(.top,-5)
                    }
                }

            }
                
            }
        }


class LocationManagerDelegate: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var currentAddress: String = ""
    private var locationManager = CLLocationManager()

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            locationManager.startUpdatingLocation()
        } else {
            // Handle denied or restricted authorization status
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        reverseGeocodeLocation(location: location)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // Handle location manager errors
    }
    
    private func reverseGeocodeLocation(location: CLLocation) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if let placemark = placemarks?.first {
                let address = placemark.name ?? ""
                let city = placemark.locality ?? ""
                let state = placemark.administrativeArea ?? ""
                let postalCode = placemark.postalCode ?? ""
                let country = placemark.country ?? ""
                
                let fullAddress = "\(address), \(city), \(state) \(postalCode), \(country)"
                
                DispatchQueue.main.async {
                    self.currentAddress = fullAddress
                }
            }
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    @State static var isUserCurrentlyLoggedOut = false
 
    static var previews: some View {
        HomeView(isUserCurrentlyLoggedOut: $isUserCurrentlyLoggedOut)
    }
}


