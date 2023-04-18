//
//  OngoingView.swift
//  Diary
//
//  Created by TAEHYOUNG KIM on 2023/01/11.
//

import SwiftUI

struct OngoingView: View {
    
    @StateObject var studyStore: StudyStore
    @State var isFinished: Bool = false
    @State var isEditing: Bool = false
    @Binding var isShowAddingView: Bool

    var body: some View {
        NavigationStack {
            VStack {
                if studyStore.savedStudies.isEmpty {
                    //MARK: - 진행중인 공부가 없을 경우
                    ZStack {
                        Color("background")
                      
                        Button {
                            isShowAddingView.toggle()
                        } label: {
                            VStack {
                                Image("avocado_1")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: UIScreen.main.bounds.width * 0.3)
                                
                                Label {
                                    Text("Make a plan")
                                        .foregroundColor(.gray)

                                } icon: {
                                    Image(systemName: "plus.circle")
                                }
                            }
                        }
                    }
                    .edgesIgnoringSafeArea(.all)
                } else {
                    //MARK: - 진행중인 공부가 있을 경우
                    List {
                        ForEach(studyStore.savedStudies) { study in
                            
                            //MARK: Progress
                            Section {
                                ProgressView(studyStore: studyStore, study: study)
                            } header: {
                                HStack {
                                    Text("Progress")
                                    
                                    Spacer()
                                    
                                    Menu {
                                        Button {
                                            isEditing.toggle()
                                        } label: {
                                            Label("Edit", systemImage: "pencil")
                                        }

                                        Button(role: .destructive) {
                                            studyStore.deleteAllStudy()
                                        } label: {
                                            Label("Delete", systemImage: "trash")
                                        }

                                    } label: {
                                        Image(systemName: "ellipsis")
                                            .foregroundColor(Color(UIColor.label))
                                            .font(.title)
                                    }
                                }
                                .padding(.horizontal, -20)
                            }
                            
                            //MARK: Set Time
                            Section {
                                Text("\(study.studyTimePerSession)min study, \(study.breakTimePerSession)min break ")
                            } header: {
                                Text("📌 Set time")
                                    .padding(.leading, -20)
                            }
                            
                            //MARK: To do
                            Section {
                                Text(study.whatToDo ?? "")
                                    .contextMenu {
                                        /*@START_MENU_TOKEN@*/Text("Menu Item 1")/*@END_MENU_TOKEN@*/
                                        /*@START_MENU_TOKEN@*/Text("Menu Item 2")/*@END_MENU_TOKEN@*/
                                        /*@START_MENU_TOKEN@*/Text("Menu Item 3")/*@END_MENU_TOKEN@*/
                                    }
                            } header: {
                                Text("✏️ To do")
                                    .padding(.leading, -20)
                            }
                            
                            //MARK: Done Button
                            HStack {
                                Spacer()
                                Button {
                                    studyStore.selectedStudy = study
                                    isFinished.toggle()
                                } label: {
                                    Text("Done")
                                }
                                .tint(Color.white)
                                Spacer()
                            }
                            .listRowBackground(Color.accentColor)
                        }
                    }
                    .headerProminence(.increased)
                    .background(Color("background"))
                    .scrollContentBackground(.hidden)
                }
            }
            .navigationTitle("Study in progess")
            .navigationBarTitleDisplayMode(.inline)
            .fullScreenCover(isPresented: $isFinished) {
                FinishView(studyStore: studyStore, study: studyStore.selectedStudy, isFinished: $isFinished)
            }
        }
    } 
}



struct OngoingView_Previews: PreviewProvider {
    static var previews: some View {
        OngoingView(studyStore: StudyStore(), isShowAddingView: .constant(false))
    }
}

