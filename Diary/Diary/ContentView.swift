//
//  ContentView.swift
//  Diary
//
//  Created by TAEHYOUNG KIM on 2023/01/10.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var avocadoStore: AvocadoStore
    @State var isNotLogined: Bool = true
    var body: some View {
        TabView{
            OngoingView()
                .tabItem {
                    Image(systemName: "message.badge")
                    Text("Ongoing")
                }.tag(1)
            
            AvocadoList()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("List")
                }.tag(2)
        }
        .fullScreenCover(isPresented: $isNotLogined) {
            LoginView(isNotLogined: $isNotLogined)
        }
    }
}




    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AvocadoStore())
    }
}
