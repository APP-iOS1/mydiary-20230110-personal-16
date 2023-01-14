//
//  WriteDiaryView.swift
//  Diary
//
//  Created by TAEHYOUNG KIM on 2023/01/10.
//

import SwiftUI

struct AddAvocado: View {
    @EnvironmentObject var avocadoStore: AvocadoStore
    @State var studyTimePerAvocado = 25
    @State var breakTimePerAvocado = 5
    @State var goalCount = 2
    @State var whatToDo: String = ""
    @Binding var addViewShowing: Bool
    
    var studyTimes: [Int] = [5,10,15,20,25,30,35,40,45,50,55,60]
    var breakTimes: [Int] = [5,10,15,20,25,30]
    
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
                    HStack {
                        Picker(selection: $studyTimePerAvocado) {
                            ForEach(studyTimes, id: \.self) { min in
                                Text("\(min)min")
                            }
                        } label: {
                            Text("Study time")
                        }
                    }
                    
                    HStack {
                        Picker(selection: $breakTimePerAvocado) {
                            ForEach(breakTimes, id: \.self) { min in
                                Text("\(min)min")
                            }
                        } label: {
                            Text("Break time")
                        }
                        
                    }
                    
                    HStack {
                        Picker(selection: $goalCount) {
                            ForEach(0..<50) { count in
                                Text("\(count)ea")
                            }
                        } label: {
                            Text("Number of avocados")
                        }
                    }
                    
                } header: {
                    Text("Set the times")
                        .padding(.leading, -20)
                } footer: {
                    Text("Example: Study for \(studyTimePerAvocado) minutes and take a \(breakTimePerAvocado) minute break, repeat \(goalCountString).")
                }
                .headerProminence(.increased)
                
                Section {
                    Text("What are you planning to do?")
                    TextEditor(text: $whatToDo)
                        .frame(height: 130)
                } header: {
                    Text("Set tasks")
                        .padding(.leading, -20)
                        .headerProminence(.increased)
                }
                
                HStack {
                    Spacer()
                    Button {
                        let avocado = Avocado(id: UUID().uuidString, goalCount: goalCount, studyTimePerAvocado: studyTimePerAvocado, breakTimePerAvocado: breakTimePerAvocado, whatToDo: whatToDo)
                        avocadoStore.createAvocadoPlan(avocado: avocado)
                        avocadoStore.fetchAvocado()
                        addViewShowing = false
                    } label: {
                        Text("Add")
                    }
                    .tint(Color.white)
                    Spacer()
                }
                .listRowBackground(Color(red: 0.775, green: 0.537, blue: 0.259))
                
            }
            .navigationTitle("Adding")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color("background"))
            .scrollContentBackground(.hidden)
        }
    }
}

struct AddAvocado_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AddAvocado(addViewShowing: .constant(false))
                .environmentObject(AvocadoStore())
        }
    }
}
