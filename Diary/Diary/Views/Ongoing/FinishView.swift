
//  FinishView.swift
//  Diary
//
//  Created by TAEHYOUNG KIM on 2023/01/11.
//

import SwiftUI
//import CoreLocation
//import PhotosUI

struct FinishView: View {
    
    @StateObject var studyStore: StudyStore
    var study: Study
    @Binding var isFinished: Bool
    @State var whatToDid = ""
    @State var whatILearned = ""
    
    //    var totalStudyTime: Int16 {
    //        study.doneCount * (study.studyTimePerSession + study.breakTimePerSession)
    //    }
    
    var placeholderString: String = "성장/ 좋았던점/ 고민할지점을 줘서 의미있던 부분"
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Section {
                        VStack(alignment: .leading) {
                            Text("What to did?")
                                .font(.title3)
                            Divider()
                                .padding(.horizontal , -20)
                                                            
                            TextEditor(text: $whatToDid)
                                .frame(height: UIScreen.main.bounds.height * 0.2)
                        }
                    }
                    Section {
                        VStack(alignment: .leading) {
                            Text("What did you learn?")
                                .font(.title3)
                                .padding(.bottom, 4)

                            Text("성장/ 좋았던점/ 고민할지점을 줘서 의미있던 부분")
                                .font(.footnote)
                                .foregroundColor(.secondary)
                            
                            Divider()
                                .padding(.horizontal , -20)

                        TextEditor(text: $whatILearned)
                                .frame(height: UIScreen.main.bounds.height * 0.2)
                        }
                    }
                }
                .onAppear {
                    whatToDid = study.whatToDo ?? "hello"
                }
                .background(Color("background"))
                .scrollContentBackground(.hidden)
                .navigationTitle("Finish plan")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button(role: .cancel) {
                            isFinished.toggle()
                        } label: {
                            Image(systemName: "xmark")
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button {
                            studyStore.finishStudy(study: study, did: whatToDid, learned: whatILearned)
                            isFinished.toggle()
                        } label: {
                            Text("Save")
                        }
                    }

                    
                }
            }
        }
    }
}

struct FinishView_Previews: PreviewProvider {
    static var previews: some View {
        let studyStore = StudyStore()
        let study = Study(context: studyStore.container.viewContext)
        study.whatToDo = "hello"
        study.goalCount = 5
        study.doneCount = 4
        return FinishView(studyStore: studyStore, study: study, isFinished: .constant(true))
    }
}
