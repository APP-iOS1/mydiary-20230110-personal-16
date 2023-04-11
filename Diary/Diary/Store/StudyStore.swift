//
//  AvocadoStore.swift
//  Diary
//
//  Created by TAEHYOUNG KIM on 2023/01/10.
//

import Foundation
import CoreData


class StudyStore: ObservableObject {
    
    let container: NSPersistentContainer
        
    @Published var savedStudies = [Study]()
    @Published var finishedStudies = [Study]()
    @Published var selectedStudy = Study()
    
    init() /*(inMemory: Bool = false)*/ {
        container = NSPersistentContainer(name: "StudiesContainer")
        
//        if inMemory {
//            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
//
//        }
        
        
        container.loadPersistentStores { description, error in
            if let error = error {
                print("ERROR LOADING CORE DATA")
                print(error.localizedDescription)
            } else {
                print("SUCCESSFULLY LOAD CORE DATA")
            }
        }
        fetchCurrentStudy()
        fetchFinishedStudys()
    }
    
    func fetchCurrentStudy() {
        let request = NSFetchRequest<Study>(entityName: "Study")
        request.predicate = NSPredicate(
            format: "isFinished = %@", false as NSNumber
        )
        do {
            savedStudies = try container.viewContext.fetch(request)
        } catch {
            print("ERROR FETCHING CORE DATA")
            print(error.localizedDescription)
        }
    }
    
    func fetchFinishedStudys() {
        let request = NSFetchRequest<Study>(entityName: "Study")
        request.predicate = NSPredicate(
            format: "isFinished = %@", true as NSNumber
        )
        do {
            finishedStudies = try container.viewContext.fetch(request).sorted(by: {
                $0.createdDate ?? Date() > $1.createdDate ?? Date()
            })
        } catch {
            print("ERROR FETCHING CORE DATA")
            print(error.localizedDescription)
        }
    }
    
    func addStudy(studyTime: Int16, breakTime: Int16, goalCount: Int16, whatToDo: String) {
        let study = Study(context: container.viewContext)
        study.id = UUID().uuidString
        study.isFinished = false
        study.whatToDo = whatToDo
        study.studyTimePerSession = studyTime
        study.breakTimePerSession = breakTime
        study.goalCount = goalCount
        study.doneCount = 0
        study.createdDate = Date()
        saveData()
    }
    func deleteStudy(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let entity = finishedStudies[index]
        container.viewContext.delete(entity)
        saveData()
    }
    
    func deleteAllStudy() {
        for study in savedStudies {
            container.viewContext.delete(study)
        }
        saveData()
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
            fetchCurrentStudy()
            fetchFinishedStudys()
        } catch {
            print("ERROR SAVING CORE DATA")
            print(error.localizedDescription)
        }
    }
    
    func finishStudy(study: Study, did: String, learned: String) {
        study.isFinished = true
        study.whatToDid = did
        study.whatILearned = learned

        saveData()
    }
    
    func doneCount(study: Study, _ countOperator: String) {
        if countOperator == "-" {
            study.doneCount -= 1
        } else {
            study.doneCount += 1
        }
        saveData()
    }
    
    
    func deleteAll() {
        let fetchRequest1: NSFetchRequest<NSFetchRequestResult> = Study.fetchRequest()
        let batchDeleteRequest1 = NSBatchDeleteRequest(fetchRequest: fetchRequest1)
        _ = try? container.viewContext.execute(batchDeleteRequest1)
        try? container.viewContext.save()
        
    }

}

//extension StudyStore {
//    static var preview: StudyStore = {
//        let studyStore = StudyStore(inMemory: true)
//
//        var study = Study(context: studyStore.container.viewContext)
//        study.whatToDo = "코어데이터 코어데이터 프리뷰 크러쉬 해결"
//        study.id = UUID().uuidString
//        study.isFinished = true
//        study.studyTimePerSession = 25
//        study.breakTimePerSession = 5
//        study.goalCount = 5
//        study.doneCount = 4
//        study.createdDate = Date()
//
//        studyStore.finishedStudies = [study]
//        studyStore.savedStudies = [study]
//        studyStore.selectedStudy = study
//        return studyStore
//    }()
//}


//    @Published var errorMessage = ""
//    @Published var loginRequestState: LoginRequestState?
//    @Published var currentLocalUser: User?
//    @Published var ongoingPlan: Avocado?
//    @Published var avocados: [Avocado] = []
//    @Published var test: [String] = []
//    @Published var downloadImage: UIImage?
//
//    init() {
//
//        //        self.currentStudy = Avocado(id: "1", goalCount: 4, studyTimePerAvocado: 25, breakTimePerAvocado: 5, whatToDo: "아보카드 샌드위치 만들기", doneCount: 6, whatToDid: "샌드위치, 후라이, 성공적", whatILearned: "소금, 후추로도 괜찮네")
//        //
//        //        self.loginRequestState = .loggedIn
//    }
//
//    let database = Firestore.firestore().collection("user")
//    let authentification = Auth.auth()
//    let storage = Storage.storage()
//
//
//
//    //MARK: -Storage 이미지 업로드
//    func uploadImage(image: UIImage?, currentAvocado: Avocado) {
//        guard let uid = authentification.currentUser?.uid
//        else {return}
//        let ref = storage.reference().child("\(uid)/\(currentAvocado.id)")
//        guard let imageData = image?.jpegData(compressionQuality: 0.5) else {return}
//        ref.putData(imageData, metadata: nil) { metadata, err in
//            if let err = err {
//                self.errorMessage = "Failed to push image to Storage: \(err)"
//                return
//            }
//            print("이미지 메소드 발동")
//            ref.downloadURL { url, err in
//                if let err = err {
//                    self.errorMessage = "Failed to retrieve downloadURL: \(err)"
//                }
//                self.errorMessage = "Successfully stored image with url: \(url?.absoluteString ?? "")"
//            }
//        }
//    }
//
//    //MARK: -Storage 이미지 다운로드
//    func downloadImage(avocado: Avocado) {
//        let idRef = storage.reference().child("\(authentification.currentUser?.uid ?? "")")
//
//        idRef.listAll { result, error in
//            if let error = error {
//                // ...
//            }
//        }
//    }
//
//
//    // MARK: - Create New Customer(user)
//    /// Auth에 새로운 사용자를 생성합니다.
//    /// - Parameter email: 입력받은 사용자의 email
//    /// - Parameter password: 입력받은 사용자의 password
//    /// - Parameter nickname: 입력받은 사용자의 nickname
//    func signUp(email: String, password: String, nickname: String) async -> Bool {
//        do  {
//            try await authentification.createUser(withEmail: email, password: password)
//            print("account created.")
//            errorMessage = ""
//            // firestore에 user 등록
//            let currentUserId = authentification.currentUser?.uid ?? "userID"
//            registerUser(uid: currentUserId, email: email, nickname: nickname)
//            return true
//        }
//        catch {
//            print(error.localizedDescription)
//            errorMessage = error.localizedDescription
//            return false
//        }
//    }
//
//
//    // MARK: - Register Customer(user) in Firestore
//    /// Auth에 새롭게 만든 사용자 정보를 Firestore에 등록합니다.
//    /// - Parameter uid: 현재 사용자의 Auth uid
//    /// - Parameter email: 현재 사용자의 email
//    /// - Parameter nickname: 현재 사용자의 nickname
//    func registerUser(uid: String, email: String, nickname: String) {
//        database.document(uid).setData([
//                "id" : uid,
//                "userEmail" : email,
//                "userNickname" : nickname
//            ])
//    }
//
//
//    // MARK: - 이메일 중복 검사
//    /// 사용자가 입력한 이메일이 이미 사용하고 있는지 검사합니다.
//    /// 입력받은 이메일이 DB에 이미 있다면 true를, 그렇지 않다면 false를 반환합니다.
//    /// - Parameter currentUserEmail: 입력받은 사용자 이메일
//    /// - Returns: 중복된 이메일이 있는지에 대한 Boolean 값
//    @MainActor
//    func isEmailDuplicated(currentUserEmail: String) async -> Bool {
//        do {
//            let document = try await database
//                .whereField("userEmail", isEqualTo: currentUserEmail)
//                .getDocuments()
//            return document.isEmpty
//        } catch {
//            print(error.localizedDescription)
//            return true
//        }
//    }
//
//
//    // MARK: - 닉네임 중복 검사
//    /// 사용자가 입력한 닉네임이 이미 사용하고 있는지 검사합니다.
//    /// 입력받은 닉네임이 DB에 이미 있다면 false를, 그렇지 않다면 true를 반환합니다.
//    /// - Parameter currentUserNickname: 입력받은 사용자 닉네임
//    /// - Returns: 중복된 닉네임이 있는지에 대한 Boolean 값
//    @MainActor
//    func isNicknameDuplicated(currentUserNickname: String) async -> Bool {
//        do {
//            let document = try await database
//                .whereField("userNickname", isEqualTo: currentUserNickname)
//                .getDocuments()
//            return document.isEmpty
//        } catch {
//            print(error.localizedDescription)
//            return true
//        }
//    }
//
//    // MARK: - Login
//    @MainActor
//    public func login(withEmail email: String, withPassword password: String) async -> Void {
//
//        do {
//            try await authentification.signIn(withEmail: email, password: password)
//            loginRequestState = .loggedIn
//
//            // 현재 로그인 한 유저의 정보 담아주는 코드
//            // 변경이 필요함!
//            let userNickname = await requestUserNickname(uid: authentification.currentUser?.uid ?? "")
//            self.currentLocalUser = User(id: self.authentification.currentUser?.uid ?? "", userEmail: email, userNickname: userNickname )
//            print("userNickname: \(userNickname)")
//        } catch {
//            loginRequestState = .notLoggedIn
//            dump("DEBUG : LOGIN FAILED \(error.localizedDescription)")
//        }
//    }
//
//    // MARK: - User Logout
//    /// 로그인한 사용자의 로그아웃을 요청합니다.
//    public func logout() {
//        do {
//            try authentification.signOut()
//            loginRequestState = .notLoggedIn
//
//            // 로컬에 있는 User 구조체의 객체를 날림
//            self.currentLocalUser = nil
//        } catch {
//            dump("DEBUG : LOG OUT FAILED \(error.localizedDescription)")
//        }
//    }
//
//    // MARK: - request Nickname
//    /// uid 값을 통해 database의 특정 uid에 저장된 userNickname을 요청합니다.
//    ///  - Parameter uid : currentUser의 UID
//    ///  - Returns : currentUser의 userNickname
//    private func requestUserNickname(uid: String) async -> String {
//        var retValue = ""
//        //        print("requestUserNickname 1")
//        return await withCheckedContinuation({ continuation in
//            database.document(uid).getDocument { (document, error) in
//                if let document = document, document.exists {
//                    retValue = document.get("userNickname") as! String
//                    //                    print("requestUserNickname 2: \(retValue)")
//                    continuation.resume(returning: retValue)
//                } else {
//                    print("2-")
//                    continuation.resume(throwing: error as! Never)
//                }
//            }
//        })
//    }
//
//    //MARK: - 계획 추가하기 in firestore
//    func createAvocadoPlan(avocado: Avocado) {
//        database
//            .document(currentLocalUser!.id)
//            .collection("currentAvocado")
//            .document(avocado.id)
//            .setData([
//                "id": avocado.id,
//                "goalCount": avocado.goalCount,
//                "studyTimePerAvocado": avocado.studyTimePerAvocado,
//                "breakTimePerAvocado": avocado.breakTimePerAvocado,
//                "whatToDo": avocado.whatToDo,
//                "doneCount": avocado.doneCount
//            ]) { err in
//                if let err = err {
//                    print("create avocado plan erorr: \(err)")
//                } else {
//                    print("create avocado plan 완료")
//                    self.ongoingPlan = Avocado(id: avocado.id, goalCount: avocado.goalCount, studyTimePerAvocado: avocado.studyTimePerAvocado, breakTimePerAvocado: avocado.breakTimePerAvocado, whatToDo: avocado.whatToDo, doneCount: 0)
//                }
//            }
//    }
//
//
//    func updateDoneCount(doneCount: Int) async {
//        do {
//            try await database
//                .document(currentLocalUser?.id ?? "")
//                .collection("currentAvocado")
//                .document(ongoingPlan?.id ?? "")
//                .updateData([
//                    "doneCount": doneCount
//                ])
//            self.ongoingPlan?.doneCount = doneCount
//        } catch {}
//    }
//
//    //MARK: - 진행중인 계획 패치
//    func readAvocado() {
//        database.document(authentification.currentUser?.uid ?? "").collection("currentAvocado").addSnapshotListener { documentSnapshot, error in
//
//            guard let document = documentSnapshot else { return }
//            let id = document.documents[0].documentID
//            let docData = document.documents[0].data()
//            let goalCount: Int = docData["goalCount"] as? Int ?? 0
//            let doneCount: Int = docData["doneCount"] as? Int ?? 0
//            let studyTimePerAvocado: Int = docData["studyTimePerAvocado"] as? Int ?? 0
//            let breakTimePerAvocado: Int = docData["breakTimePerAvocado"] as? Int ?? 0
//            let whatToDo: String = docData["whatToDo"] as? String ?? ""
//            let avocado = Avocado(id: id, goalCount: goalCount, studyTimePerAvocado: studyTimePerAvocado, breakTimePerAvocado: breakTimePerAvocado, whatToDo: whatToDo, doneCount: doneCount)
//
//            self.ongoingPlan = avocado
//        }
//    }
//
//    //MARK: - 리스트 패치
//    func fetchAvocadoAtList() {
//        database.document(authentification.currentUser?.uid ?? "").collection("avocados")
//            .getDocuments { snapshot, error in
//                self.avocados.removeAll()
//                if let snapshot {
//
//                    for document in snapshot.documents {
//                        let id : String = document.documentID
//                        let docData = document.data()
//
//                        let goalCount: Int = docData["goalCount"] as? Int ?? 0
//                        let doneCount: Int = docData["doneCount"] as? Int ?? 0
//                        let studyTimePerAvocado: Int = docData["studyTimePerAvocado"] as? Int ?? 0
//                        let breakTimePerAvocado: Int = docData["breakTimePerAvocado"] as? Int ?? 0
//                        let whatToDo: String = docData["whatToDo"] as? String ?? ""
//                        let whatILearned: String = docData["whatILearned"] as? String ?? ""
//                        let whatToDid: String = docData["whatToDid"] as? String ?? ""
//                        let currentGeoPoint: GeoPoint = docData["currentLocation"] as? GeoPoint ?? GeoPoint(latitude: 0, longitude: 0)
//                        let currentLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: currentGeoPoint.latitude, longitude: currentGeoPoint.longitude)
//                        self.avocados.append(Avocado(id: id, goalCount: goalCount, studyTimePerAvocado: studyTimePerAvocado, breakTimePerAvocado: breakTimePerAvocado, whatToDo: whatToDo, doneCount: doneCount, whatToDid: whatToDid, whatILearned: whatILearned, currentLocation: currentLocation)
//                        )
//                    }
//
//
//                }
//            }
//    }
//
//    //MARK: - 계획을 끝내고 리스트에 추가하기
//    func createAvocadoAtList(avocado: Avocado, whatILearned: String, whatToDid: String, currentLocation: CLLocationCoordinate2D) {
//        let currentGeoPoint: GeoPoint = GeoPoint(latitude: currentLocation.latitude, longitude: currentLocation.longitude)
//        database
//            .document(currentLocalUser?.id ?? "")
//            .collection("avocados")
//            .document(avocado.id)
//            .setData([
//                "id": avocado.id,
//                "goalCount": avocado.goalCount,
//                "studyTimePerAvocado": avocado.studyTimePerAvocado,
//                "breakTimePerAvocado": avocado.breakTimePerAvocado,
//                "whatToDo": avocado.whatToDo,
//                "whatILearned": whatILearned,
//                "whatToDid": whatToDid,
//                "doneCount": avocado.doneCount,
//                "currentLocation": currentGeoPoint
//            ]) { err in
//                if let err = err {
//                    print("create avocado plan erorr: \(err)")
//                } else {
//                    print("create avocado plan 완료")
//                }
//            }
//        database.document(authentification.currentUser?.uid ?? "")
//            .collection("currentAvocado").document(ongoingPlan?.id ?? "").delete()
//        self.ongoingPlan = nil
//    }
//
//
//    // MARK: - 회원정보 업데이트 (주소, 연락처)
//    ///  - Parameter userAddress : 새로 입력한 주소
//    ///  - Parameter phoneNumber : 새로 입력한 연락처
//    ///  - Parameter user : 로그인한 유저의 객체 (User)
//    ///  - firestore 반영: updateData 메소드를 이용하여 firestore에 정보를 업데이트한다.
//    ///  - 로컬반영: 로컬에 있는 currentUser 객체를 재생성(초기화)하여 정보를 업데이트함
//    //    func updateUserInfo(userAddress: String, phoneNumber: String, user: User) {
//    //        database
//    //            .document(user.id).updateData([
//    //                "userAddress" : userAddress,
//    //                "phoneNumber" : phoneNumber
//    //            ]) { err in
//    //                if let err = err {
//    //                    print("회원정보 수정 오류: \(err)")
//    //                } else {
//    //                    print("회원정보 수정 완료")
//    //                    self.currentUser = User(id: self.authentification.currentUser?.uid ?? "", userEmail: user.userEmail, userNickname: user.userNickname, userAddress: userAddress, phoneNumber: phoneNumber )
//    //                }
//    //            }
//    //    }
//
//    // MARK: - FireStore의 유저정보 fetch
//    ///  - Parameter user : 로그인한 유저의 객체 (User)
//    ///  - 로그인 시 firestore에 저장된 유저 정보를 currentUser에 할당한다.
//    //    func fetchUserInfo(user: User) {
//    //        database.getDocuments { snapshot, error in
//    //            if let snapshot {
//    //
//    //                for document in snapshot.documents {
//    //                    let id : String = document.documentID
//    //                    let docData = document.data()
//    //
//    //                    if id == user.id {
//    //
//    //                        let userAddress: String = docData["userAddress"] as? String ?? ""
//    //                        let phoneNumber: String = docData["phoneNumber"] as? String ?? ""
//    //                        let userNickname: String = docData["userNickname"] as? String ?? ""
//    //                        let userEmail: String = docData["userEmail"] as? String ?? ""
//    //
//    //                        self.currentUser = User(id: id, userEmail: userEmail, userNickname: userNickname, userAddress: userAddress, phoneNumber: phoneNumber)
//    //                        print(self.currentUser!)
//    //                    }
//    //                }
//    //
//    //            }
//    //        }
//    //    }
//    //    // MARK: - 비밀번호 업데이트
//    //    ///  - Parameter password : 변경하려는 비밀번호
//    //    ///  - Auth에 접근하여 비밀번호를 업데이트한다
//    //    func updatePassword(password: String) {
//    //        authentification.currentUser?.updatePassword(to: password) { err in
//    //            if let err = err {
//    //                print("password update error: \(err)")
//    //            } else {
//    //                print("password update")
//    //            }
//    //        }
//    //    }
//
//    // MARK: - 이메일 업데이트
//    //    func updateEmail(email: String) {
//    //        authentification.currentUser?.updateEmail(to: email) { err in
//    //            if let err = err {
//    //                print("email update error: \(err)")
//    //            } else {
//    //                print("email update")
//    //            }
//    //        }
//    //    }
//
//    //    // MARK: - 로그인 메소드를 사용하여 비밀번호 체크
//    //    ///  - Parameter email : 로그인 시 사용하는 이메일
//    //    ///  - Parameter password : 로그인 시 사용하는 비밀번호
//    //    ///  - Returns : 로그인 성공 유무에 따라 Bool값을 return
//    //    public func reAuthLoginIn(withEmail email: String, withPassword password: String) async -> Bool {
//    //        print("email: \(email), pw: \(password)")
//    //
//    //        do {
//    //            try await authentification.signIn(withEmail: email, password: password)
//    //
//    //            return true
//    //        } catch(let error) {
//    //            dump("error: \(error)")
//    //
//    //            return false
//    //        }
//    //    }
//    //
//    //
//}
//
//
//
//
////// Points to the root reference
////let storageRef = Storage.storage().reference()
////
////// Points to "images"
////let imagesRef = storageRef.child("images")
////
////// Points to "images/space.jpg"
////// Note that you can use variables to create child values
////let fileName = "space.jpg"
////let spaceRef = imagesRef.child(fileName)
////
////// File path is "images/space.jpg"
////let path = spaceRef.fullPath
////
////// File name is "space.jpg"
////let name = spaceRef.name
////
////// Points to "images"
////let images = spaceRef.parent()
////