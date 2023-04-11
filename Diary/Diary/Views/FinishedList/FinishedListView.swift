//
//  AvocadoList.swift
//  Diary
//
//  Created by TAEHYOUNG KIM on 2023/01/10.
//

import SwiftUI

struct FinishedListView: View {
    @StateObject var studyStore: StudyStore
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(studyStore.finishedStudies) { study in
                    Section {
                        NavigationLink {
                            FinishedStudyDetail(studyStore: studyStore, study: study)
                        } label: {
                            HStack {
                                CircleProgressBar(studyStore: studyStore, study: study, scale: 0.45)
                                    .padding(-12)
                                
                                Spacer()
                                
                                VStack() {
                                    Spacer()
                                    Text(study.whatToDid ?? "")
                                        .font(.title3)
//                                        .foregroundColor(.black)
                                        .frame(height: UIScreen.main.bounds.height * 0.08)
                                        .frame(maxWidth: .infinity, alignment: .bottomLeading)
                                    Spacer()
                                    Text(dateFormatter(createdDate: study.createdDate ?? Date()) )
                                        .font(.footnote)
                                        .foregroundColor(.gray)
                                        .frame(maxWidth: .infinity, alignment: .bottomTrailing)
                                }
                            }
                        }
                    }
                    .padding(12)
                    .listRowBackground(
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundColor(Color(UIColor.secondarySystemGroupedBackground))
                            .padding(
                                EdgeInsets(
                                    top: 4,
                                    leading: 20,
                                    bottom: 4,
                                    trailing: 20
                                )
                            )
                    )
                    .listRowSeparator(.hidden)

                }.onDelete(perform: studyStore.deleteStudy)
                
            }
            .listStyle(.plain)
            .navigationTitle("Finished Studies")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                EditButton()
            }
            .background(Color("background"))
            .scrollContentBackground(.hidden)
        }
    }
    
    func dateFormatter(createdDate: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy.MM.dd"
        return formatter.string(from: createdDate)
    }
}



struct FinishedListView_Previews: PreviewProvider {
    static var previews: some View {
        FinishedListView(studyStore: StudyStore())
    }
}
