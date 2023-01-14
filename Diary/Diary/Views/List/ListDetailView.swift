//
//  ListDetailView.swift
//  Diary
//
//  Created by TAEHYOUNG KIM on 2023/01/13.
//

import SwiftUI
import MapKit

struct ListDetailView: View {
    @ObservedObject var avocadoStore: AvocadoStore = AvocadoStore()
    
    @Binding var region: MKCoordinateRegion
    
    var avocado: Avocado
    
    var body: some View {
        VStack {
            if let uimage = avocadoStore.downloadImage {
                Image(uiImage: uimage)
                    .resizable()
                    .scaledToFit()
            }
            
            if avocado.currentLocation?.latitude != 0 {
                Map(coordinateRegion: $region)
            }
        }
        .onAppear {
            print("[리스트뷰디테일] 패치 이미지 ")
            avocadoStore.downloadImages(avocado: avocado)
        }
    }
}


struct ListDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ListDetailView(region: .constant(MKCoordinateRegion()), avocado: currentStudy)
    }
}
