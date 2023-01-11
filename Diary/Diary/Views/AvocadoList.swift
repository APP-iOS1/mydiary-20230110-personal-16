//
//  AvocadoList.swift
//  Diary
//
//  Created by TAEHYOUNG KIM on 2023/01/10.
//

import SwiftUI

struct AvocadoList: View {
    @EnvironmentObject var avocadoStore: AvocadoStore
    var body: some View {
        NavigationStack {
            VStack {
                List(avocadoStore.avocados) { avocado in
                    NavigationLink {
                        if avocadoStore.downloadImage != nil {
                            VStack {
                                Image(uiImage: avocadoStore.downloadImage!)
                            }
                        }
                        Button {
                            avocadoStore.downloadImages(avocado: avocado)
                        } label: {
                            Text("패치")
                        }
                    } label: {
                        VStack(alignment: .leading) {
                            Text("목표: \(avocado.goalCount)개")
                            Text("달성: \(avocado.doneCount ?? 0)개: \(avocado.totalStudyTime ?? 0)분")
                            Text("계획이 무엇이었나요?")
                            Text(avocado.whatToDo)
                            
                            Text("무엇을 했고, 달성했나요?")
                            Text(avocado.whatILearned ?? "")
                            
                            Text("무엇을 배웠나요?")
                            Text("성장/ 좋았던점/ 고민할지점을 줘서 의미있던 부분")
                            Text(avocado.whatILearned ?? "")
                            Rectangle()
                                .frame(height: 7)
                        }
                    }

                    
//                    avocadoStore.downloadImages()
//                        .resizable()
//                        .scaledToFit()

                }
            }
            .navigationTitle("리스트")
            .toolbar {
                Button {
                    avocadoStore.fetchAvocadoAtList()
                } label: {
                    Text("새로고침")
                }
            }
//            .onAppear {
//                avocadoStore.fetchAvocadoAtList()
//            }
        }
    }
    
}
struct AvocadoList_Previews: PreviewProvider {
    static var previews: some View {
        AvocadoList()
            .environmentObject(AvocadoStore())
    }
}
