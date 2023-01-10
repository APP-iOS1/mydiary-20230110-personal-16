//
//  AuthStore.swift
//  Diary
//
//  Created by TAEHYOUNG KIM on 2023/01/10.
//

import Foundation
import Firebase



enum LoginRequestState {
    case loggedIn
    case notLoggedIn
}

struct User {
    var id: String
    var userEmail: String
    var userNickname: String
}

class AuthStore: ObservableObject {
    @Published var errorMessage = ""
    @Published var loginRequestState: LoginRequestState = .notLoggedIn
    @Published var currentUser: User?

    let database = Firestore.firestore()
    let authentification = Auth.auth()
    
    
    
    // MARK: - Create New Customer(user)
    /// Auth에 새로운 사용자를 생성합니다.
    /// - Parameter email: 입력받은 사용자의 email
    /// - Parameter password: 입력받은 사용자의 password
    /// - Parameter nickname: 입력받은 사용자의 nickname
    @MainActor
    func signUp(email: String, password: String, nickname: String) async -> Bool {
        do  {
            try await authentification.createUser(withEmail: email, password: password)
            print("account created.")
            errorMessage = ""
            // firestore에 user 등록
            let currentUserId = authentification.currentUser?.uid ?? "userID"
            registerUser(uid: currentUserId, email: email, nickname: nickname)
            return true
        }
        catch {
            print(error.localizedDescription)
            errorMessage = error.localizedDescription
            return false
        }
    }
    
    // MARK: - Register Customer(user) in Firestore
    /// Auth에 새롭게 만든 사용자 정보를 Firestore에 등록합니다.
    /// - Parameter uid: 현재 사용자의 Auth uid
    /// - Parameter email: 현재 사용자의 email
    /// - Parameter nickname: 현재 사용자의 nickname
    func registerUser(uid: String, email: String, nickname: String) {
        database.collection("user")
            .document(uid)
            .setData([
                "id" : uid,
                "userEmail" : email,
                "userNickname" : nickname
            ])
    }
    
    // MARK: - 이메일 중복 검사
    /// 사용자가 입력한 이메일이 이미 사용하고 있는지 검사합니다.
    /// 입력받은 이메일이 DB에 이미 있다면 true를, 그렇지 않다면 false를 반환합니다.
    /// - Parameter currentUserEmail: 입력받은 사용자 이메일
    /// - Returns: 중복된 이메일이 있는지에 대한 Boolean 값
    @MainActor
    func isEmailDuplicated(currentUserEmail: String) async -> Bool {
        do {
            let document = try await database.collection("user")
                .whereField("userEmail", isEqualTo: currentUserEmail)
                .getDocuments()
            return document.isEmpty
        } catch {
            print(error.localizedDescription)
            return true
        }
    }
    
    // MARK: - 닉네임 중복 검사
    /// 사용자가 입력한 닉네임이 이미 사용하고 있는지 검사합니다.
    /// 입력받은 닉네임이 DB에 이미 있다면 false를, 그렇지 않다면 true를 반환합니다.
    /// - Parameter currentUserNickname: 입력받은 사용자 닉네임
    /// - Returns: 중복된 닉네임이 있는지에 대한 Boolean 값
    @MainActor
    func isNicknameDuplicated(currentUserNickname: String) async -> Bool {
        do {
            let document = try await database.collection("user")
                .whereField("userNickname", isEqualTo: currentUserNickname)
                .getDocuments()
            return document.isEmpty
        } catch {
            print(error.localizedDescription)
            return true
        }
    }
    
    // MARK: - Login
    @MainActor
    public func login(withEmail email: String, withPassword password: String) async -> Void {

        do {
            loginRequestState = .loggedIn
            try await authentification.signIn(withEmail: email, password: password)
            // 현재 로그인 한 유저의 정보 담아주는 코드
            // 변경이 필요함!
            let userNickname = await requestUserNickname(uid: authentification.currentUser?.uid ?? "")
            self.currentUser = User(id: self.authentification.currentUser?.uid ?? "", userEmail: email, userNickname: userNickname )
            print("userNickname: \(userNickname)")
        } catch {
            loginRequestState = .notLoggedIn
            dump("DEBUG : LOGIN FAILED \(error.localizedDescription)")
        }
    }
    
    // MARK: - User Logout
    /// 로그인한 사용자의 로그아웃을 요청합니다.
    public func logout() {
        do {
            try authentification.signOut()
            loginRequestState = .notLoggedIn
            
            // 로컬에 있는 User 구조체의 객체를 날림
            self.currentUser = nil
        } catch {
            dump("DEBUG : LOG OUT FAILED \(error.localizedDescription)")
        }
    }
    
    // MARK: - request Nickname
    /// uid 값을 통해 database의 특정 uid에 저장된 userNickname을 요청합니다.
    ///  - Parameter uid : currentUser의 UID
    ///  - Returns : currentUser의 userNickname
    private func requestUserNickname(uid: String) async -> String {
        var retValue = ""
//        print("requestUserNickname 1")
        return await withCheckedContinuation({ continuation in
            database.collection("user").document(uid).getDocument { (document, error) in
                if let document = document, document.exists {
                    retValue = document.get("userNickname") as! String
//                    print("requestUserNickname 2: \(retValue)")
                    continuation.resume(returning: retValue)
                } else {
                    print("2-")
                    continuation.resume(throwing: error as! Never)
                }
            }
        })
    }
    
    // MARK: - 회원정보 업데이트 (주소, 연락처)
    ///  - Parameter userAddress : 새로 입력한 주소
    ///  - Parameter phoneNumber : 새로 입력한 연락처
    ///  - Parameter user : 로그인한 유저의 객체 (User)
    ///  - firestore 반영: updateData 메소드를 이용하여 firestore에 정보를 업데이트한다.
    ///  - 로컬반영: 로컬에 있는 currentUser 객체를 재생성(초기화)하여 정보를 업데이트함
//    func updateUserInfo(userAddress: String, phoneNumber: String, user: User) {
//        database.collection("user")
//            .document(user.id).updateData([
//                "userAddress" : userAddress,
//                "phoneNumber" : phoneNumber
//            ]) { err in
//                if let err = err {
//                    print("회원정보 수정 오류: \(err)")
//                } else {
//                    print("회원정보 수정 완료")
//                    self.currentUser = User(id: self.authentification.currentUser?.uid ?? "", userEmail: user.userEmail, userNickname: user.userNickname, userAddress: userAddress, phoneNumber: phoneNumber )
//                }
//            }
//    }
    
    // MARK: - FireStore의 유저정보 fetch
    ///  - Parameter user : 로그인한 유저의 객체 (User)
    ///  - 로그인 시 firestore에 저장된 유저 정보를 currentUser에 할당한다.
//    func fetchUserInfo(user: User) {
//        database.collection("user").getDocuments { snapshot, error in
//            if let snapshot {
//
//                for document in snapshot.documents {
//                    let id : String = document.documentID
//                    let docData = document.data()
//
//                    if id == user.id {
//
//                        let userAddress: String = docData["userAddress"] as? String ?? ""
//                        let phoneNumber: String = docData["phoneNumber"] as? String ?? ""
//                        let userNickname: String = docData["userNickname"] as? String ?? ""
//                        let userEmail: String = docData["userEmail"] as? String ?? ""
//
//                        self.currentUser = User(id: id, userEmail: userEmail, userNickname: userNickname, userAddress: userAddress, phoneNumber: phoneNumber)
//                        print(self.currentUser!)
//                    }
//                }
//
//            }
//        }
//    }
//    // MARK: - 비밀번호 업데이트
//    ///  - Parameter password : 변경하려는 비밀번호
//    ///  - Auth에 접근하여 비밀번호를 업데이트한다
//    func updatePassword(password: String) {
//        authentification.currentUser?.updatePassword(to: password) { err in
//            if let err = err {
//                print("password update error: \(err)")
//            } else {
//                print("password update")
//            }
//        }
//    }

    // MARK: - 이메일 업데이트
//    func updateEmail(email: String) {
//        authentification.currentUser?.updateEmail(to: email) { err in
//            if let err = err {
//                print("email update error: \(err)")
//            } else {
//                print("email update")
//            }
//        }
//    }
    
//    // MARK: - 로그인 메소드를 사용하여 비밀번호 체크
//    ///  - Parameter email : 로그인 시 사용하는 이메일
//    ///  - Parameter password : 로그인 시 사용하는 비밀번호
//    ///  - Returns : 로그인 성공 유무에 따라 Bool값을 return
//    public func reAuthLoginIn(withEmail email: String, withPassword password: String) async -> Bool {
//        print("email: \(email), pw: \(password)")
//
//        do {
//            try await authentification.signIn(withEmail: email, password: password)
//
//            return true
//        } catch(let error) {
//            dump("error: \(error)")
//
//            return false
//        }
//    }
//
//
}