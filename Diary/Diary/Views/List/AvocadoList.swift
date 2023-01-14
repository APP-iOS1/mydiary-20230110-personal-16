//
//  AvocadoList.swift
//  Diary
//
//  Created by TAEHYOUNG KIM on 2023/01/10.
//

import SwiftUI
import MapKit

struct AvocadoList: View {
    @EnvironmentObject var avocadoStore: AvocadoStore
    @State var region = MKCoordinateRegion()
    
    func setRegion(avocado: Avocado) {
        region = MKCoordinateRegion(center: avocado.currentLocation!, latitudinalMeters: 50, longitudinalMeters: 50)
    }
    
    func deleteItems(at offsets: IndexSet) {
        avocadoStore.avocados.remove(atOffsets: offsets)
        print("Item removed")
    }
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(avocadoStore.avocados) { avocado in
                        NavigationLink {
                            ListDetailView(region: $region, avocado: avocado)
                            
                        } label: {
                            VStack(alignment: .leading) {
                                Text("목표: \(avocado.goalCount)개")
                                Text("달성: \(avocado.doneCount ?? 0)개: \(avocado.totalStudyTime ?? 0)분")
                                Text("계획이 무엇이었나요?")
                                Text(avocado.whatToDo)
                                
                                Text("무엇을 했고, 달성했나요?")
                                Text(avocado.whatToDid ?? "")
                                
                                Text("무엇을 배웠나요?")
                                Text("성장/ 좋았던점/ 고민할지점을 줘서 의미있던 부분")
                                Text(avocado.whatILearned ?? "")
                                Rectangle()
                                    .frame(height: 7)
                            }
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
            }
            .onAppear {
                avocadoStore.fetchAvocadoAtList()
                print("리스트 온어피어!")
            }
            .navigationTitle("리스트")
            .toolbar {
                EditButton()
            }
        }
    }
    
}



struct AvocadoList_Previews: PreviewProvider {
    static var previews: some View {
        AvocadoList()
            .environmentObject(AvocadoStore())
    }
}
