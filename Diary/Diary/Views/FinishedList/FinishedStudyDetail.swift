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
                    Text("오후 10:40 - 오전 1:10")
                        .font(.footnote)
                        .foregroundColor(.gray)
                    
                    Text(study.whatToDid ?? "")
                        .padding(.vertical, 8)
                }
            } header: {
                Text("What to did?")
                    .padding(.leading, -20)
            }
            
            Section {
                VStack(spacing: 12) {
                    HStack {
                        CircleProgressBar(studyStore: studyStore, study: study, scale: 1.1)
                    }
                    
                    Divider()
                        .padding(.vertical, 12)
                    
                    HStack {
                        Text("Avocado 🥑")
                            .bold()
                        Spacer()
                        Text("\(study.doneCount) / \(study.goalCount)pcs.")
                        
                    }
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    
                    HStack {
                        Text("Concentration")
                            .bold()
                        Spacer()
                        Text("\((study.studyTimePerSession + study.breakTimePerSession) * study.doneCount)min.")
                    }
                }
                .padding(.vertical, 12)
            } header: {
                Text("Acheivement")
                    .padding(.leading, -20)
            }
            
            
            //MARK: Set Time
            Section {
                Text("\(study.studyTimePerSession)min study, \(study.breakTimePerSession)min break ")
            } header: {
                Text("📌 Set time")
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
        .navigationTitle(dateFormatter(createdDate: study.createdDate ?? Date(), dateFormat: "d, MMM (E)"))
        .background(Color("background"))
        .scrollContentBackground(.hidden)
        
    }
}

struct FinishedStudyDetail_Previews: PreviewProvider {
    static var previews: some View {
        let studyStore = StudyStore()
        let study = Study(context: studyStore.container.viewContext)
        study.whatToDo = "코어데이터 코어데이터 프리뷰 크러쉬 해결"
        study.id = UUID().uuidString
        study.isFinished = true
        study.studyTimePerSession = 25
        study.breakTimePerSession = 5
        study.goalCount = 5
        study.doneCount = 0
        study.whatToDid = "코어데이터 코어데이터 프리뷰 크러쉬 해결"
        study.whatILearned = "코어데이터 코어데이터 프리뷰 크러쉬 해결"
        study.createdDate = Date()
        return FinishedStudyDetail(studyStore: studyStore, study: study)
    }
}

