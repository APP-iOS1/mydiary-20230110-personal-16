//
//  OngoingView.swift
//  Diary
//
//  Created by TAEHYOUNG KIM on 2023/01/11.
//

import SwiftUI

struct OngoingView: View {
    @EnvironmentObject var avocadoStore: AvocadoStore
    @State var isFinished: Bool = false
    @State var doneCount: Int = 0
    var body: some View {
        NavigationStack {
            VStack {
                if avocadoStore.currentStudy != nil {
                    Form {
                        
                        Text("아보카도 계획서")
                        HStack {
                            Text("수집 예정 아보카도 개수")
                            Image("avocado")
                                .resizable()
                                .frame(width: 40, height: 40)
                            Text(": \(avocadoStore.currentStudy!.goalCount)개")
                        }
                        Text("오늘 모은 아보카도 개수: \(doneCount)개")
                        Section {
                            if doneCount > 0 {
                                
                                ScrollView(.horizontal) {
                                    HStack {
                                        ForEach(0..<doneCount, id: \.self) { count in
                                            Image("avocado")
                                                .resizable()
                                                .frame(width: 40, height: 40)
                                        }
                                    }
                                }
                            }
                        }
                        
                        Button {
                            doneCount += 1
                            print("\(doneCount)")
                        } label: {
                            Text("아보카도 추가하기")
                        }
                        .onChange(of: doneCount) { count in
                            avocadoStore.updateDoneCount(doneCount: doneCount)
                        }
                        Button {
                            doneCount -= 1
                            print("\(doneCount)")
                        } label: {
                            Text("아보카도 삭제하기")
                        }
                        
                        Text("공부 시간: \(avocadoStore.currentStudy!.studyTimePerAvocado)분 당 \(avocadoStore.currentStudy!.breakTimePerAvocado)분 휴식")
                        Text("오늘 공부할 것: \(avocadoStore.currentStudy!.whatToDo)")
                        
                        Section {
                            Button {
                                avocadoStore.currentStudy!.doneCount = doneCount
                                isFinished.toggle()
                            } label: {
                                Text("공부 끝내기")
                            }
                        }

                    }
                    .onAppear {
                        avocadoStore.fetchAvocado()

                        print("\(avocadoStore.currentStudy?.doneCount ?? 1)")
                        if avocadoStore.currentStudy?.doneCount != nil {
                            doneCount = (avocadoStore.currentStudy?.doneCount)!
                        }
                    }
                    .fullScreenCover(isPresented: $isFinished) {
                        FinishView(isFinished: $isFinished)
                    }
                } else {
                    Text("계획을 추가해주세요")
                        .foregroundColor(.secondary)
                }
                
                //        .formStyle(.columns)
            }
           
            .navigationTitle("Avocado 계획서")
                .toolbar {
                    NavigationLink {
                        AddAvocado()
                    } label: {
                        Text("계획추가")
                    }
                    Button {
                        avocadoStore.fetchAvocado()
                    } label: {
                        Text("새로고침")
                    }
                    

                    
                }
        }
    }
}

struct OngoingView_Previews: PreviewProvider {
    static var previews: some View {
        OngoingView()
            .environmentObject(AvocadoStore())
        
    }
}
