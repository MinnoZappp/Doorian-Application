//
//  ContentAllNews.swift
//  doorianMock
//
//  Created by Samitanun Sapsukdee on 14/4/2566 BE.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI

struct ContentAllNews: View {
    @ObservedObject var details2 = getContent1()
    @StateObject var favorites = Favorites()
    var body: some View {
        ScrollView (.vertical, showsIndicators: true) {
            
            VStack(alignment: .leading) {
                
                HStack{
                    
                    Text("บทความทั้งหมด")
                        .font(.custom(
                            "NotoSans-Bold",
                            fixedSize: 24))
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    
                }
                .padding()
                Divider()
                if self.details2.contents.count != 0{
                    VStack(alignment: .leading, spacing: 20){
                        ForEach(self.details2.contents) { i in
                            NavigationLink(destination: ContentTodayNews(data: i)) {
                                ContentAllGroupView(data: i)
                            }
                            Divider()
                        }
                        
                    }
                    .padding()
                    .padding(.bottom, 5)
                }
            }
            Spacer(minLength: 0)
            }
            .environmentObject(favorites) 

        }
    }


struct ContentAllNews_Previews: PreviewProvider {
    static var previews: some View {
        ContentAllNews()
    }
}
