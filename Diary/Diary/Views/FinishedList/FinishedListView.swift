//
//  AvocadoList.swift
//  Diary
//
//  Created by TAEHYOUNG KIM on 2023/01/10.
//

import SwiftUI

struct FinishedListView: View {
    @StateObject var studyStore: StudyStore
    @Binding var page: Int
    @Binding var isShowAddingView: Bool
    var body: some View {
        NavigationStack {
            VStack {
                if studyStore.finishedStudies.isEmpty {
                    ZStack {
                        Color("background")
                      
                        Button {
                            if !studyStore.savedStudies.isEmpty {
                                page = 0
                            } else {
                                isShowAddingView.toggle()
                            }
                        } label: {
                            VStack {
                                Image("avocado_2")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: UIScreen.main.bounds.width * 0.3)
                                    .padding(10)
                                Text("There are no finished plans.")
                                    .foregroundColor(.gray)
                                if studyStore.savedStudies.isEmpty {
                                    Text("Start planning now")
                                        .foregroundColor(.gray)
                                    Image(systemName: "plus.circle")
                                }

                            }
                            .padding(.top, 40)
                        }
//                        .disabled(!studyStore.savedStudies.isEmpty)
                    }
                    .edgesIgnoringSafeArea(.all)
                } else {
                    List {
                        ForEach(studyStore.finishedStudies) { study in
                            Section {
                                NavigationLink {
                                    FinishedStudyDetail(studyStore: studyStore, study: study)
                                } label: {
                                    HStack {
                                        CircleProgressBar(studyStore: studyStore, study: study, scale: 0.5)

                                        Spacer()
                                        
                                        VStack() {
                                            Spacer()
                                            Text(study.whatToDid ?? "")
                                                .font(.title3)
                                                .frame(height: UIScreen.main.bounds.height * 0.08)
                                                .frame(maxWidth: .infinity, alignment: .bottomLeading)
                                            Spacer()
                                            Text(dateFormatter(createdDate: study.createdDate ?? Date(), dateFormat: "yy.MM.dd") )
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
                        }
                        .onDelete(perform: studyStore.deleteStudy)
                    }
                    .listStyle(.plain)
                    .background(Color("background"))
                    .scrollContentBackground(.hidden)
                    .toolbar {
                        EditButton()
                    }
                }
            }
            .navigationTitle("Finished Studies")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

func dateFormatter(createdDate: Date, dateFormat: String) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = dateFormat
    formatter.locale = Locale(identifier:"en_US")
    return formatter.string(from: createdDate)
}

struct FinishedListView_Previews: PreviewProvider {
    static var previews: some View {
        FinishedListView(studyStore: StudyStore(), page: .constant(1), isShowAddingView: .constant(false))
    }
}
