//
//  PhotosPickerTest.swift
//  Diary
//
//  Created by TAEHYOUNG KIM on 2023/01/11.
//

import SwiftUI
import PhotosUI

struct PhotosPickerView: View {
    @EnvironmentObject var avocado: AvocadoStore
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImage: Image?
    @State var selectedUImage: UIImage?
    
    var body: some View {
        
        VStack {
            if let selectedImage {
                selectedImage
                    .resizable()
                    .scaledToFit()
                    .frame(width: 400, height: 300)
            }
            PhotosPicker("Select image", selection: $selectedItem, matching: .images, photoLibrary: .shared())
        }
        .onChange(of: selectedItem) { _ in
            Task {
                if let data = try? await selectedItem?.loadTransferable(type: Data.self) {
                    if let uiImage = UIImage(data: data) {
                        selectedUImage = uiImage
                        selectedImage = Image(uiImage: uiImage)
                        return
                    }   
                }
                print("Failed")
            }
        }
        Button {
            if selectedUImage != nil {
                
                avocado.uploadImage(image: selectedUImage)
            } else {
                print("사진을 선택해주세요")
            }
        } label: {
            Text("사진저장")
        }
    }
}

struct PhotosPickerView_Previews: PreviewProvider {
    static var previews: some View {
        PhotosPickerView()
            .environmentObject(AvocadoStore())
    }
}
