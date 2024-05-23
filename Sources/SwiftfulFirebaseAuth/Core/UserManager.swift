import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth






final class UserManager {
    
    static let shared = UserManager()
    private init() { }
    
    private let userCollection: CollectionReference = Firestore.firestore().collection("users")
    
    func userDocument(userId: String) -> DocumentReference {
        userCollection.document(userId)
    }
    
//    private func userFavoriteProductCollection(userId: String) -> CollectionReference {
//        userDocument(userId: userId).collection("favorite_products")
//    }
//    
//    private func userFavoriteProductDocument(userId: String, favoriteProductId: String) -> DocumentReference {
//        userFavoriteProductCollection(userId: userId).document(favoriteProductId)
//    }
    
    private let encoder: Firestore.Encoder = {
        let encoder = Firestore.Encoder()
        return encoder
    }()

    private let decoder: Firestore.Decoder = {
        let decoder = Firestore.Decoder()
        return decoder
    }()
    
    
    func createNewUser(user: DBUser) async throws {
        try userDocument(userId: user.userId).setData(from: user, merge: false)
    }
    
    
    func getUser(userId: String) async throws -> DBUser {
        try await userDocument(userId: userId).getDocument(as: DBUser.self)
    }
    
    
    func updateUserPremiumStatus(userId: String, isPremium: Bool) async throws {
        let data: [String:Any] = [
            DBUser.CodingKeys.isPremium.rawValue : isPremium,
        ]

        try await userDocument(userId: userId).updateData(data)
    }
    
    func updateUserProfileImagePath(userId: String, path: String?, url: String?) async throws {
        let data: [String:Any] = [
            DBUser.CodingKeys.profileImagePath.rawValue : path ?? "",
            DBUser.CodingKeys.profileImagePathUrl.rawValue : url ?? "",
        ]

        try await userDocument(userId: userId).updateData(data)
    }
    
 
} // class

