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
    @State var addViewShowing: Bool = false
    var body: some View {
        NavigationStack {
            if avocadoStore.loginRequestState == .loggedIn {
                VStack {
                    if avocadoStore.currentStudy != nil {
                        List {
                            
                            //MARK: Progress
                            Section {
                                ProgressView(avocadoStore: avocadoStore)
                            } header: {
                                Text("Progress")
                                    .padding(.leading, -20)
                            }
                            .headerProminence(.increased)
                            
                            //MARK: Fixed Time
                            Section {
                                Text("\(avocadoStore.currentStudy?.studyTimePerAvocado ?? 0)min study, \(avocadoStore.currentStudy?.breakTimePerAvocado ?? 0)min break ")
                            } header: {
                                Text("📌 Fixed time")
                                    .padding(.leading, -20)
                            }
                            .headerProminence(.increased)
                            
                            //MARK: To do
                            Section {
                                Text("\(avocadoStore.currentStudy?.whatToDo ?? "")")
                            } header: {
                                Text("✏️ To do")
                                    .padding(.leading, -20)
                            }
                            .headerProminence(.increased)
                            
                            //MARK: Done Button
                            HStack {
                                Spacer()
                                Button {
                                    isFinished.toggle()
                                } label: {
                                    Text("Done")
                                }
                                .tint(Color.white)
                                Spacer()
                            }
                            .listRowBackground(Color(red: 0.775, green: 0.537, blue: 0.259))
                        }
                        .background(Color("background"))
                        .scrollContentBackground(.hidden)
                        
                    } else {
                        ZStack {
                            Color("background")
                            VStack {
                                Image("avocado")
                                    .resizable()
                                    .scaledToFit()
                                Text("계획을 추가해주세요")
                                    .foregroundColor(.secondary)
                            }
                        }
                        .edgesIgnoringSafeArea(.all)
                    }
                }
                
                .onAppear {
                    avocadoStore.fetchAvocado()
                    print("ongoingView fetch appear")
                }
                .navigationTitle("Ongoing...")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    if avocadoStore.currentStudy == nil {
                        Button {
                            addViewShowing.toggle()
                        } label: {
                            Text("Add")
                        }
                    }
                }
                .sheet(isPresented: $addViewShowing) {
                    AddAvocado(addViewShowing: $addViewShowing)
                }
                .fullScreenCover(isPresented: $isFinished) {
                    FinishView(currentStudy: avocadoStore.currentStudy!, isFinished: $isFinished)
                }
                
            } else {
                ZStack {
                    Color("background")
                        Text("로그인 해주세요")
                            .foregroundColor(.secondary)
                }
                .edgesIgnoringSafeArea(.all)
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

