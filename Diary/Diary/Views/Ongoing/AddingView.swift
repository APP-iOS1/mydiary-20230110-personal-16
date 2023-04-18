//
//  WriteDiaryView.swift
//  Diary
//
//  Created by TAEHYOUNG KIM on 2023/01/10.
//

import SwiftUI

struct AddingView: View {
    @StateObject var studyStore: StudyStore
    
    @State var studyTimePerSession: Int16 = 25
    @State var breakTimePerSession: Int16 = 5
    @State var goalCount: Int16 = 2
    @State var whatToDo: String = ""
    @Binding var page: Int
    @Binding var isShowAddingView: Bool
    @State var haveWhiteSpace: Bool = false
    var studyTimes: [Int16] = [5,10,15,20,25,30,35,40,45,50,55,60]
    var breakTimes: [Int16] = [5,10,15,20,25,30]
    
    var goalCountString: String {
        switch goalCount {
        case 1:
            return "once"
        case 2:
            return "twice"
        case 3:
            return "three times"
        case 4:
            return "four times"
        case 5:
            return "five times"
        case 6:
            return "six times"
        case 7:
            return "seven times"
        case 8:
            return "eight times"
        case 9:
            return "nine times"
        case 10:
            return "ten times"
        default:
            return "\(goalCount)"
        }
    }
    var body: some View {
        NavigationStack {
            List {
                Section {
                    VStack {
                        HStack {
                            Picker(selection: $studyTimePerSession) {
                                ForEach(studyTimes, id: \.self) { min in
                                    Text("\(min)min")
                                        .tag(min)
                                }
                            } label: {
                                Text("Study time")
                            }
                        }
                        Divider()
                        HStack {
                            Picker(selection: $breakTimePerSession) {
                                ForEach(breakTimes, id: \.self) { min in
                                    Text("\(min)min")
                                        .tag(min)
                                }
                            } label: {
                                Text("Break time")
                            }
                        }
                        Divider()

                        HStack {
                            Picker(selection: $goalCount) {
                                ForEach(Int16(1)..<Int16(50), id: \.self) { count in
                                    Text("\(count)pcs")
                                        .tag(count)
                                }
                            } label: {
                                Text("Number of repetitions 🥑")
                            }
                        }
                    }
                    .listRowBackground(
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundColor(Color(UIColor.secondarySystemGroupedBackground))
                    )
                    .listRowSeparator(.hidden)

                    
                } header: {
                    Text("Set the times")
                        .padding(.leading, -20)
                } footer: {
                    Text("Example: Study for \(studyTimePerSession) minutes and take a \(breakTimePerSession) minute break, repeat \(goalCountString).")
                }
                .headerProminence(.increased)
                
                Section {
                    VStack(alignment: .leading) {
                        Text("What are you planning to do?")
                            .padding(.vertical, 8)
                        Divider()
                            .padding(.horizontal, -20)
                            .frame(maxWidth: .infinity)
                        
                        TextEditor(text: $whatToDo)
                            .frame(height: UIScreen.main.bounds.height * 0.2)
                    }
                } header: {
                    Text("Set tasks")
                        .padding(.leading, -20)
                        .headerProminence(.increased)
                }
                .listRowBackground(
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(Color(UIColor.secondarySystemGroupedBackground))
                )
            }
            
            .navigationTitle("New plan")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color("background"))
            .scrollContentBackground(.hidden)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(role: .cancel) {
                        isShowAddingView.toggle()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        if whatToDo.trimmingCharacters(in: .whitespacesAndNewlines).count > 0 {
                            studyStore.addStudy(studyTime: studyTimePerSession, breakTime: breakTimePerSession, goalCount: goalCount, whatToDo: whatToDo)
                            page = 0
                            isShowAddingView = false
                        } else {
                            haveWhiteSpace.toggle()
                        }
                    } label: {
                        Text("Add")
                    }

                }
            }
            .alert("", isPresented: $haveWhiteSpace) {
                Button("확인") {
                    //action
                    print("hello")
                }
            } message: {
                Text("Please enter your plan")
            }
        }
    }
}

struct AddAvocado_Previews: PreviewProvider {
    static var previews: some View {
        AddingView(studyStore: StudyStore(), page: .constant(0), isShowAddingView: .constant(true))
    }
}
