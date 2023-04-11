//
//  FinishedStudyDetail.swift
//  Diary
//
//  Created by TAEHYOUNG KIM on 2023/04/10.
//

import SwiftUI

struct FinishedStudyDetail: View {
    @StateObject var studyStore: StudyStore
    var study: Study
    var body: some View {
        List {
            Section {
                VStack(alignment: .leading) {
                    Text(study.whatToDid ?? "")
                    Text("오후 10:40 - 오전 1:10")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
            } header: {
                Text("What to did?")
                    .padding(.leading, -20)

            }
            
            Section {
                HStack {
                    CircleProgressBar(studyStore: studyStore, study: study, scale: 0.8)
                    VStack(alignment: .leading) {
                        Text("목표: \(study.doneCount) / \(study.goalCount)")
                        Text("\(study.studyTimePerSession)분 / \(study.breakTimePerSession)분")
                        Text("총 150분 / 2시간 30분")
                    }
                }
            } header: {
                Text("Acheivement")
                    .padding(.leading, -20)

            }
                
            Section {
                Text(study.whatILearned ?? "")

            } header: {
                Text("What to learned?")
                    .padding(.leading, -20)

            }

                                
                
        }
        .headerProminence(.increased)
        .navigationTitle("4월 10일 (월)")
        .background(Color("background"))
        .scrollContentBackground(.hidden)

    }
}

struct FinishedStudyDetail_Previews: PreviewProvider {
    static var previews: some View {
        let study = Study(context: StudyStore().container.viewContext)
        study.whatToDo = "코어데이터 코어데이터 프리뷰 크러쉬 해결"
        study.id = UUID().uuidString
        study.isFinished = true
        study.studyTimePerSession = 25
        study.breakTimePerSession = 5
        study.goalCount = 5
        study.doneCount = 4
        study.whatToDid = "코어데이터 코어데이터 프리뷰 크러쉬 해결"
        study.whatILearned = "코어데이터 코어데이터 프리뷰 크러쉬 해결"
        study.createdDate = Date()
        return FinishedStudyDetail(studyStore: StudyStore(), study: study)
    }
}

