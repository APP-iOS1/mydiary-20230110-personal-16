//
//  ContentView.swift
//  Diary
//
//  Created by TAEHYOUNG KIM on 2023/01/10.
//

import SwiftUI

struct ContentView: View {
    @StateObject var studyStore: StudyStore = StudyStore()
    var body: some View {
        TabView{
            OngoingView(studyStore: studyStore)
                .tabItem {
                    Image(systemName: "message.badge")
                    Text("Ongoing")
                }
            
            FinishedListView(studyStore: studyStore)
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("List")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
 
