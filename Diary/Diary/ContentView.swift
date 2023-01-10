//
//  ContentView.swift
//  Diary
//
//  Created by TAEHYOUNG KIM on 2023/01/10.
//

import SwiftUI

struct Diary: Hashable, Identifiable {
    
    var id: String
    var title: String
    var body: String
    
}

var diaries: [Diary] = [

    Diary(id: UUID().uuidString, title: "오늘은 기분이 좋다", body: "좋기 때문이다")
    
]

struct ContentView: View {
    @State var isNotLogined: Bool = false
    var body: some View {
        NavigationStack {
            List(diaries) { diary in
                NavigationLink {
                    EmptyView()
                } label: {
                    HStack {
                        Text(diary.title)
                        Image(systemName: "sun.max")
                    }
                }
            }
            .listStyle(.inset)
            .toolbar(content: {
                NavigationLink {
                    Text("hi")
                } label: {
                    Text("일기 쓰기")
                }
            })
            .fullScreenCover(isPresented: $isNotLogined, content: {
                LoginView(isNotLogined: $isNotLogined)
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AuthStore())
    }
}
