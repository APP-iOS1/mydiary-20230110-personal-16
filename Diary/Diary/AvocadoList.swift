////
////  AvocadoList.swift
////  Diary
////
////  Created by TAEHYOUNG KIM on 2023/01/10.
////
//
//import SwiftUI
//
//struct AvocadoList: View {
//    
//    var body: some View {
//        NavigationStack {
//            List(avocados) { avocado in
//                VStack {
//                    HStack {
//                        
//                        Spacer()
//                        VStack {
//                            Text("목표: \(avocado.goalCount)개")
//                            Text("달성: \(avocado.doneCount)개")
//                        }
//                    }
//                    .padding()
//                    VStack(alignment: .leading) {
//                      Section {
//                           ScrollView(.horizontal) {
//                                HStack {
//                                    ForEach(0..<avocado.doneCount) { count in
//                                        Image("avocado")
//                                            .resizable()
//                                            .frame(width: 40, height: 40)
//                                    }
//                                }
//                            }
//                            .padding(.vertical, 15)
//                        }
//                        Section {
//                            Text("무엇을 했나요?")
//                                .foregroundColor(.secondary)
//                            Text(avocado.did)
//                                .padding(EdgeInsets(top: 0, leading: 15, bottom: 15, trailing: 15))
//                            
//                            Text("무엇을 배웠나요?")
//                                .foregroundColor(.secondary)
//                            Text(avocado.learn)
//                                .padding(EdgeInsets(top: 0, leading: 15, bottom: 15, trailing: 15))
//                        }
//                        .font(.title3)
//
//                    }
//                    .padding()
//                    Rectangle().frame(width: 400, height: 10).foregroundColor(.gray)
//                }
//            }
//            .listStyle(.inset)
//            .toolbar(content: {
//                
//                NavigationLink {
//                    AddAvocado()
//                } label: {
//                    Text("기록하기")
//                }
//            })
//            
//        }
//    }
//}
//
//struct AvocadoList_Previews: PreviewProvider {
//    static var previews: some View {
//        AvocadoList()
//    }
//}
