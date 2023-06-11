//
//  MinimizedViewNotification.swift
//  doorianMock
//
//  Created by Samitanun Sapsukdee on 29/3/2566 BE.
//

import SwiftUI

struct MinimizedViewNotification: View {
    var body: some View {
        NavigationView{
                ZStack {
                    VStack(alignment: .leading) {
                       
                            Text("อำเภอเมือง, จังหวัดจันทบุรี")
                                .font(.system(size: 18))
                                .bold()
                                .padding()
                                .padding(.bottom, 6)
                                .foregroundColor(Color("4F704B"))
                        
                        HStack {
                            Image("durian_image")
                                .resizable()
                                .frame(width: 150, height: 170)
                                .cornerRadius(20)
                            
                            VStack(alignment: .leading) {
                                HStack{
                                    Text("โรคที่พบ:")
                                        .font(.system(size: 12))
                                        .padding(.bottom, 8)
                                        .bold()
                                    
                                    Text("โรคใบใหม้")
                                        .font(.system(size: 12))
                                        .padding(.bottom, 8)
                                    
                                }
                                HStack{
                                    Text("ระดับความรุนแรง:")
                                        .font(.system(size: 12))
                                        .padding(.bottom, 8)
                                        .bold()
                                    
                                    Text("8/10 (รุนแรงมาก)")
                                        .font(.system(size: 12))
                                        .padding(.bottom, 8)
                                }
                                HStack{
                                    Text("ระยะเวลาที่เกิดโรค:")
                                        .font(.system(size: 12))
                                        .padding(.bottom, 8)
                                        .bold()
                                    
                                    Text("วันที่ 1 ธันวาคม 2565")
                                        .font(.system(size: 12))
                                        .padding(.bottom, 8)
                                }
                                HStack{
                                    Text("แนวทางป้องกัน:")
                                        .font(.system(size: 12))
                                        .padding(.bottom, 50)
                                        .bold()
                                    
                                    Text("ตัดพุ่มให้โปร่ง เพื่อรับแสงแดด และหากพบเจอใบที่เป็น โรคให้นำไปเผาทำลายทิ้ง")
                                        .font(.system(size: 12))
                                        .padding(.bottom, 8)
                                }
                            }
                            .padding(.leading, 5)
                            .padding(.trailing, 5)
                            .foregroundColor(Color("0B0B0B"))
                    
                           
                        }
                        .padding(.horizontal, 5)
                    }
                }
        }
    }
}

struct MinimizedViewNotification_Previews: PreviewProvider {
    static var previews: some View {
        MinimizedViewNotification()
    }
}
