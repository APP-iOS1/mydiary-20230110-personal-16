//
//  PhotosPickerTest.swift
//  Diary
//
//  Created by TAEHYOUNG KIM on 2023/01/11.
//

import SwiftUI
import PhotosUI

struct PhotosPickerView: View {
    @StateObject var studyStore: StudyStore
    @State private var selectedItem: PhotosPickerItem?
    @State var selectedImage: Image?
    @Binding var selectedUImage: UIImage?
//    @State var isImageNotSelected: Bool = false
    var body: some View {
        Text("hello")
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

                        print("사진선택됨")
                        return
                    }
                }
            }
        }
        
        Button {
            if selectedUImage != nil {
                avocado.uploadImage(image: selectedUImage)
            } else {
                print("사진을 선택해주세요")
                isImageNotSelected.toggle()
            }
        } label: {
            Text("사진저장")
        }
        .alert("사진을 선택해주세요", isPresented: $isImageNotSelected) {
            Button {
                
            } label: {
                Text("확인")
            }
            
        }
        
    }
}

struct PhotosPickerView_Previews: PreviewProvider {
    static var previews: some View {
        PhotosPickerView(studyStore: StudyStore(), selectedUImage: .constant(UIImage()))
    }
}
