//
//  ContentView.swift
//  Diary
//
//  Created by TAEHYOUNG KIM on 2023/01/10.
//

import SwiftUI

struct ContentView: View {
    @StateObject var studyStore: StudyStore = StudyStore()
    @State var page = 0
    @State var isShowAddingView: Bool = false
    var body: some View {
        
        TabView(selection: $page){
            
            OngoingView(studyStore: studyStore, isShowAddingView: $isShowAddingView)
                .tabItem {
                    Image(systemName: "message")
                    Text("Ongoing")
                }.tag(0)
                .sheet(isPresented: $isShowAddingView, content: {
                    AddingView(studyStore: studyStore, page: $page, isShowAddingView: $isShowAddingView)
                })

            FinishedListView(studyStore: studyStore, page: $page, isShowAddingView: $isShowAddingView)
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("List")
                }.tag(1)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
 
