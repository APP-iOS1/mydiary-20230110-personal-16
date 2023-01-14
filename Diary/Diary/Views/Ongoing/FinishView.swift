
//  FinishView.swift
//  Diary
//
//  Created by TAEHYOUNG KIM on 2023/01/11.
//

import SwiftUI
import CoreLocation
import PhotosUI

struct FinishView: View {
    @EnvironmentObject var avocadoStore: AvocadoStore
    @EnvironmentObject var locationService: LocationService
    
    var currentStudy: Avocado
    @Binding var isFinished: Bool
    
    @State var currentLocation: CLLocationCoordinate2D?
    @State private var selectedItem: PhotosPickerItem?
    @State var selectedImage: Image?
    @State var selectedUImage: UIImage?
    
    @State var whatToDid = ""
    @State var whatILearned = "성장/ 좋았던점/ 고민할지점을 줘서 의미있던 부분"
    var placeholderString: String = "성장/ 좋았던점/ 고민할지점을 줘서 의미있던 부분"
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    Text("목표: \(currentStudy.goalCount)개")
                    Text("달성: \(currentStudy.doneCount ?? 0)개: \(currentStudy.totalStudyTime ?? 0)분")
                    HStack {
                        Text("위치:")
                        Button {
                            locationService.requestLocation { coordinate in
                                currentLocation = coordinate
                            }
                        } label: {
                            Text("현재위치 추가하기")
                        }
                        
                    }
                }
                Text("무엇을 했나요?")
                TextEditor(text: $whatToDid)
                    .onAppear {
                        whatToDid = currentStudy.whatToDo
                    }
                    .frame(height: 150)
                VStack(alignment: .leading) {
                    Text("무엇을 배웠나요?")
                    Text("성장/ 좋았던점/ 고민할지점을 줘서 의미있던 부분")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                    
                }
                TextEditor(text: $whatILearned)
                    .foregroundColor(self.whatILearned == placeholderString ? .gray : .primary)
                    .onTapGesture {
                        if self.whatILearned == placeholderString {
                            self.whatILearned = ""
                        }
                    }
                    .frame(height: 150)
                
                Section {
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
                }
                Section {
                    Button {
                        
                        avocadoStore.createAvocadoAtList(avocado: currentStudy, whatILearned: whatILearned, whatToDid: whatToDid, currentLocation: currentLocation ?? CLLocationCoordinate2D(latitude: 0, longitude: 0))
                        
                        if let selectedUImage {
                            
                            avocadoStore.uploadImage(image: selectedUImage, currentAvocado: currentStudy)
                            print("이미지: \(selectedUImage) 업로드 레쓰고")
                        }
                        
                        isFinished.toggle()
                    } label: {
                        Text("Save")
                    }
                }
            }
            .background(Color("background"))
            .scrollContentBackground(.hidden)
            .navigationTitle("마무리")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button {
                    isFinished.toggle()
                } label: {
                    Text("닫기")
                }

            }
        }
    }
}

struct FinishView_Previews: PreviewProvider {
    static var previews: some View {
        FinishView(currentStudy: currentStudy, isFinished: .constant(false))
            .environmentObject(AvocadoStore())
            .environmentObject(LocationService())
        
    }
}

var currentStudy: Avocado = Avocado(id: "1", goalCount: 4, studyTimePerAvocado: 25, breakTimePerAvocado: 5, whatToDo: "아보카드 샌드위치 만들기", doneCount: 6, whatToDid: "샌드위치, 후라이, 성공적", whatILearned: "소금, 후추로도 괜찮네")
