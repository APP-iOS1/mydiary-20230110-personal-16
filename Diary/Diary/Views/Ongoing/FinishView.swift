
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
    @State var whatILearned = "성장/ 좋았던점/ 고민할지점을 줘서 의미있던 부분"
    
    //    var totalStudyTime: Int16 {
    //        study.doneCount * (study.studyTimePerSession + study.breakTimePerSession)
    //    }
    
    var placeholderString: String = "성장/ 좋았던점/ 고민할지점을 줘서 의미있던 부분"
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Text("What to did?")
                    TextEditor(text: $whatToDid)
                        .onAppear {
                            //                        whatToDid = study.whatToDo ?? ""
                        }
                        .frame(height: 150)
                    //
                    VStack(alignment: .leading) {
                        Text("What did you learn?")
                        Text("성장/ 좋았던점/ 고민할지점을 줘서 의미있던 부분")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                        
                    }
                    
                    TextEditor(text: $whatILearned)
                        .foregroundColor(self.whatILearned == placeholderString ? .gray : .primary)
                        .onTapGesture {
                            if self.whatILearned == placeholderString {
                                self.whatILearned = ""
                            }
                        }
                        .frame(height: 150)
                    Section {
                        Button {
                            studyStore.finishStudy(study: study, did: whatToDid, learned: whatILearned)
                            isFinished.toggle()
                        } label: {
                            Text("Save")
                        }
                    }
                }
                .onAppear {
                    print("온어피어: \(study)")
                }
                .background(Color("background"))
                .scrollContentBackground(.hidden)
                .navigationTitle("마무리")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    Button {
                        isFinished.toggle()
                    } label: {
                        Text("닫기")
                    }
                    
                }
            }
        }
    }
}

struct FinishView_Previews: PreviewProvider {
    static var previews: some View {
        FinishView(studyStore: StudyStore(), study: Study(), isFinished: .constant(true))
    }
}
