//
//  ResultFullView.swift
//  doorianMock
//
//  Created by Samitanun Sapsukdee on 29/3/2566 BE.
//

import SwiftUI

struct ResultFullView: View {
    @ObservedObject var classifier: ImageClassifier
    
    @EnvironmentObject var modelData: ModelData
    
    var diseaseIndex: Int {
        modelData.diseases.firstIndex(where: { $0.id == disease.id })!
    }
        
    var disease: Disease
    
    
    var body: some View {
        NavigationView {
            ScrollView (.vertical, showsIndicators: false) {
                VStack {

                    if let stableClass = classifier.imageClass {
                        Group {
                            if stableClass == durianDisease.diseaseAgalSpot {
                                Text(durianDisease.diseaseAgalSpotTH)
                                    .font(.system(size: 24, weight: .heavy))
                                    .padding(.bottom, 6)
                                
                                Text("ประเภท\(durianDisease.typeAgalSpot)")
                                    .font(.system(size: 14))
                                    .padding(.bottom, 12)

                                Image("agalspot")
                                    .resizable()
                                    .frame(maxHeight: 200)
                                    .cornerRadius(20)
                                    .padding(.bottom, 12)

                                VStack {
                                    
//                                    ชื่อวิทยาศาสตร์
                                    HStack {
                                        VStack(alignment: .leading) {
                                            HStack {
                                                Text("ชื่อวิทยาศาสตร์")
                                                    .bold()
                                                    .foregroundColor(Color("dark-green"))
                                                    .padding(.trailing, 10)
                                                Text(durianDisease.sciAgalSpot)
                                            }
                                            .padding(.bottom, 12)
                                            
                                            HStack(alignment: .top) {
                                                Text("สาเหตุ")
                                                    .bold()
                                                    .foregroundColor(Color("dark-green"))
                                                    .padding(.trailing, 60)
                                                Text(durianDisease.causeAgalSpot)
                                            }
                                        }
                                        .font(.system(size: 14))
                                    }
                                    .frame(maxWidth: .infinity)
                                    .padding(.bottom, 20)
                                    
//                                    ข้อมูลทั่วไป
                                    HStack(alignment: .top) {
                                        Group {
                                            Image(systemName: "ladybug")
                                                .foregroundColor(Color("A3B694"))
                                            
                                            VStack(alignment: .leading) {
                                                Text("ข้อมูลทั่วไปของ\(durianDisease.diseaseAgalSpotTH)")
                                                    .font(.system(size: 14))
                                                    .bold()
                                                    .foregroundColor(Color("dark-green"))
                                                    .padding(.bottom, 4)
                                                
                                                Text(durianDisease.descriptionDiseaseAgalSpot)
                                                    .font(.system(size: 14))
                                            }
                                            .lineSpacing(3)
                                        }
                                        .padding(10)
                                    }
                                    .frame(maxWidth: .infinity)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color("grey-light"), lineWidth: 1)
                                    )
                                    
//                                    อาการ
                                    HStack(alignment: .top) {
                                        Group {
                                            Image(systemName: "magnifyingglass")
                                                .foregroundColor(Color("A3B694"))
                                            
                                            VStack(alignment: .leading) {
                                                Text("อาการของ\(durianDisease.diseaseAgalSpotTH)")
                                                    .font(.system(size: 14))
                                                    .bold()
                                                    .foregroundColor(Color("dark-green"))
                                                    .padding(.bottom, 4)
                                                
                                                Group {
                                                    Text(durianDisease.symtomAgalSpot1)
                                                    Text(durianDisease.symtomAgalSpot2)
                                                    Text(durianDisease.symtomAgalSpot3)
                                                    Text(durianDisease.symtomAgalSpot4)
                                                    Text(durianDisease.symtomAgalSpot5)
                                                }
                                                .font(.system(size: 14))
                                                .lineSpacing(3)
                                            }
                                        }
                                        .padding(10)
                                    }
                                    .frame(maxWidth: .infinity)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color("grey-light"), lineWidth: 1)
                                    )
                                    
//                                    วิธีแก้ไข
                                    HStack(alignment: .top) {
                                        Group {
                                            Image(systemName: "wand.and.stars")
                                                .foregroundColor(Color("A3B694"))
                                            
                                            VStack(alignment: .leading) {
                                                Text("วิธีการแก้ไข")
                                                    .bold()
                                                    .foregroundColor(Color("dark-green"))
                                                    .padding(.bottom, 4)
                                                
                                                Text(durianDisease.descriptionSolutionAgalSpot1)
                                                
                                                HStack {
                                                    Image(systemName: "hand.thumbsup.fill")
                                                        .foregroundColor(Color("FFC700"))
                                                    Text(durianDisease.recommendAgalSpot)
                                                }
                                                .padding(.horizontal, 5)
                                                .frame(minHeight: 50)
                                                .background(Color("FEFCCB"))
                                                .cornerRadius(10)
                                                
                                                Group {
                                                    Text(durianDisease.solutionAgalSpot1)
                                                    Text(durianDisease.solutionAgalSpot2)
                                                    Text(durianDisease.solutionAgalSpot3)
                                                    Text(durianDisease.solutionAgalSpot4)
                                                }
                                                .lineSpacing(3)
                                                
                                                HStack {
                                                    Image(systemName: "lightbulb.fill")
                                                        .foregroundColor(Color("FFC700"))
                                                    Text(durianDisease.descriptionSolutionAgalSpot2)
                                                }
                                                .padding(.horizontal, 5)
                                                .frame(minHeight: 50)
                                                .background(Color("FEFCCB"))
                                                .cornerRadius(10)
                                            }
                                        }
                                        .font(.system(size: 14))
                                        .padding(10)
                                    }
                                    .frame(maxWidth: .infinity)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color("grey-light"), lineWidth: 1)
                                    )
                                    
//                                    แนวทางป้องกัน
                                    HStack(alignment: .top) {
                                        Group {
                                            Image(systemName: "checkmark.shield")
                                                .foregroundColor(Color("A3B694"))
                                            
                                            VStack(alignment: .leading) {
                                                Text("แนวทางป้องกัน")
                                                    .font(.system(size: 14))
                                                    .bold()
                                                    .foregroundColor(Color("dark-green"))
                                                    .padding(.bottom, 4)
                                                
                                                Group {
                                                    Text(durianDisease.protectAgalSpot1)
                                                    Text(durianDisease.protectAgalSpot2)
                                                    Text(durianDisease.protectAgalSpot3)
                                                }
                                                .font(.system(size: 14))
                                                .lineSpacing(3)
                                            }
                                        }
                                        .padding(10)
                                    }
                                    .frame(maxWidth: .infinity)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color("grey-light"), lineWidth: 1)
                                    )
                                    
                                }
                                
                                

                            } else {
                                Text(durianDisease.diseaseAnthracnoseTH)
                                    .font(.system(size: 24, weight: .heavy))
                                    .padding(.bottom, 6)

                                Text("ประเภท\(durianDisease.typeAntracnose)")
                                    .font(.system(size: 14))
                                    .padding(.bottom, 12)

                                Image("anthracnose")
                                    .resizable()
                                    .frame(maxHeight: 200)
                                    .cornerRadius(20)
                                    .padding(.bottom, 12)

                                VStack {
                                    
//                                    ชื่อวิทยาศาสตร์
                                    HStack {
                                        VStack(alignment: .leading) {
                                            HStack {
                                                Text("ชื่อวิทยาศาสตร์")
                                                    .bold()
                                                    .foregroundColor(Color("dark-green"))
                                                    .padding(.trailing, 10)
                                                Text(durianDisease.sciAnthracnose)
                                            }
                                            .padding(.bottom, 12)
                                            
                                            HStack(alignment: .top) {
                                                Text("สาเหตุ")
                                                    .bold()
                                                    .foregroundColor(Color("dark-green"))
                                                    .padding(.trailing, 60)
                                                Text(durianDisease.causeAnthracnose)
                                            }
                                        }
                                        .font(.system(size: 14))
                                    }
                                    .frame(maxWidth: .infinity)
                                    .padding(.bottom, 30)
                                    
//                                    ข้อมูลทั่วไป
                                    HStack(alignment: .top) {
                                        Group {
                                            Image(systemName: "ladybug")
                                                .foregroundColor(Color("A3B694"))
                                            
                                            VStack(alignment: .leading) {
                                                Text("ข้อมูลทั่วไปของ\(durianDisease.diseaseAnthracnoseTH)")
                                                    .font(.system(size: 14))
                                                    .bold()
                                                    .foregroundColor(Color("dark-green"))
                                                    .padding(.bottom, 4)
                                                
                                                Text(durianDisease.descriptionDiseaseAnthracnose)
                                                    .font(.system(size: 14))
                                            }
                                            .lineSpacing(3)
                                        }
                                        .padding(10)
                                    }
                                    .frame(maxWidth: .infinity)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color("grey-light"), lineWidth: 1)
                                    )
                                    
//                                    อาการ
                                    HStack(alignment: .top) {
                                        Group {
                                            Image(systemName: "magnifyingglass")
                                                .foregroundColor(Color("A3B694"))
                                            
                                            VStack(alignment: .leading) {
                                                Text("อาการของ\(durianDisease.diseaseAnthracnoseTH)")
                                                    .font(.system(size: 14))
                                                    .bold()
                                                    .foregroundColor(Color("dark-green"))
                                                    .padding(.bottom, 4)
                                                
                                                Group {
                                                    Text(durianDisease.symtomAnthracnose1)
                                                    Text(durianDisease.symtomAnthracnose2)
                                                    Text(durianDisease.symtomAnthracnose3)
                                                    Text(durianDisease.symtomAnthracnose4)
                                                    Text(durianDisease.symtomAnthracnose5)
                                                }
                                                .font(.system(size: 14))
                                                .lineSpacing(3)
                                            }
                                        }
                                        .padding(10)
                                    }
                                    .frame(maxWidth: .infinity)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color("grey-light"), lineWidth: 1)
                                    )
                                    
//                                    วิธีแก้ไข
                                    HStack(alignment: .top) {
                                        Group {
                                            Image(systemName: "wand.and.stars")
                                                .foregroundColor(Color("A3B694"))
                                            
                                            VStack(alignment: .leading) {
                                                Text("วิธีการแก้ไข")
                                                    .bold()
                                                    .foregroundColor(Color("dark-green"))
                                                    .padding(.bottom, 4)
                                                
                                                Text(durianDisease.descriptionSolutionAnthracnose1)
                                                
                                                HStack {
                                                    Image(systemName: "hand.thumbsup.fill")
                                                        .foregroundColor(Color("FFC700"))
                                                    Text(durianDisease.recommendAnthracnose)
                                                }
                                                .padding(.horizontal, 5)
                                                .frame(minHeight: 50)
                                                .background(Color("FEFCCB"))
                                                .cornerRadius(10)
                                                
                                                Group {
                                                    Text(durianDisease.solutionAnthracnose1)
                                                    Text(durianDisease.solutionAnthracnose2)
                                                    Text(durianDisease.solutionAnthracnose3)
                                                    Text(durianDisease.solutionAnthracnose4)
                                                }
                                                .lineSpacing(3)
                                                
                                                HStack {
                                                    Image(systemName: "lightbulb.fill")
                                                        .foregroundColor(Color("FFC700"))
                                                    Text(durianDisease.descriptionSolutionAnthracnose2)
                                                }
                                                .padding(.horizontal, 5)
                                                .frame(minHeight: 50)
                                                .background(Color("FEFCCB"))
                                                .cornerRadius(10)
                                            }
                                        }
                                        .font(.system(size: 14))
                                        .padding(10)
                                    }
                                    .frame(maxWidth: .infinity)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color("grey-light"), lineWidth: 1)
                                    )
                                    
//                                    แนวทางป้องกัน
                                    HStack(alignment: .top) {
                                        Group {
                                            Image(systemName: "checkmark.shield")
                                                .foregroundColor(Color("A3B694"))
                                            
                                            VStack(alignment: .leading) {
                                                Text("แนวทางป้องกัน")
                                                    .font(.system(size: 14))
                                                    .bold()
                                                    .foregroundColor(Color("dark-green"))
                                                    .padding(.bottom, 4)
                                                
                                                Group {
                                                    Text(durianDisease.protectAnthracnose1)
                                                    Text(durianDisease.protectAnthracnose2)
                                                    Text(durianDisease.protectAnthracnose3)
                                                }
                                                .font(.system(size: 14))
                                                .lineSpacing(3)
                                            }
                                        }
                                        .padding(10)
                                    }
                                    .frame(maxWidth: .infinity)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color("grey-light"), lineWidth: 1)
                                    )
                                    
                                }
                                
                            }
                        }
                        .onAppear {
                            if stableClass != classifier.imageClass {
                                DispatchQueue.main.async {
                                    classifier.objectWillChange.send()
                                }
                            }
                        }
                    } else {
                        Text("Processing...")
                            .font(.system(size: 18))
                            .italic()
                            .foregroundColor(Color("E0E0E0"))
                            .padding(.bottom, 6)
                    }
                    
                }
                .padding(.horizontal)
                .padding(.bottom, 50)
            }
        }
    }
}

struct ResultFullView_Previews: PreviewProvider {
    static let modelData = ModelData()
    
    static var previews: some View {
        ResultFullView(classifier: ImageClassifier(), disease: modelData.diseases[0])
            .environmentObject(modelData)
    }
}
