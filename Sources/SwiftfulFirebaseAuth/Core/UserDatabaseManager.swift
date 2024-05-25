import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth


final class UserDBManager {
    
    static let shared = UserDBManager()
    private init() { }
    
    private let userCollection: CollectionReference = Firestore.firestore().collection("users")
    
    
    func userDocument(userId: String) -> DocumentReference {
        userCollection.document(userId)
    }
    
    private let encoder: Firestore.Encoder = {
        let encoder = Firestore.Encoder()
        return encoder
    }()

    private let decoder: Firestore.Decoder = {
        let decoder = Firestore.Decoder()
        return decoder
    }()
    
    
    func createNewUser(user: UserAuthInfo) async throws {
        try userDocument(userId: user.uid).setData(from: user, merge: false)
    }
    
    
    func getUser(userId: String) async throws -> UserAuthInfo {
        try await userDocument(userId: userId).getDocument(as: UserAuthInfo.self)
    }
    
    
    func updateUserPremiumStatus(userId: String, isPremium: Bool) async throws {
        let data: [String:Any] = [
            UserAuthInfo.CodingKeys.isPremium.rawValue : isPremium,
        ]

        try await userDocument(userId: userId).updateData(data)
    }
    
    
    func updateUserProfileImagePath(userId: String, url: URL?) async throws {
        let url = url?.absoluteString
        
        let data: [String:Any] = [
           
            UserAuthInfo.CodingKeys.photoURL.rawValue : url ?? "",
        ]

        try await userDocument(userId: userId).updateData(data)
    }
    
    
    func validateUserOrNew(user: UserAuthInfo) async throws {
        do {
            let _ = try await self.getUser(userId: user.uid) // if successful then the user already exists
            do {
                try self.userDocument(userId: user.uid).setData(from: user,
                                                            mergeFields: [
                                                                "auth_providers",
                                                                "display_name",
                                                                "email",
                                                                "first_name",
                                                                "last_name",
                                                                "phone_number",
                                                                "photo_url",
                                                                "is_anonymous",
                                                                "last_sign_in_date",
                                                                "user_id"
                                                            ] // not all here just certain ones i want
                )
            } catch {
                print(error)
            }
        } catch {
            // If failure then we need to create a new user in FB.
            do {
                try await self.createNewUser(user: user)
            } catch {
                throw error
            }
        }
    } // func
 
} // class

