//
//  FireAuth.swift
//  doorianMock
//
//  Created by Samitanun Sapsukdee on 3/4/2566 BE.
//

    
import Foundation
import FirebaseAuth
import GoogleSignIn
import Firebase
import FirebaseFirestore



struct FireAuth {

//    private var name: String = ""
//    private var email: String = ""
    private let user = GIDSignIn.sharedInstance.currentUser
   private var name: String = ""
  private var profileImageUrl: String = ""
  private var email: String = ""
  


    static let share = FireAuth()

    private init() {}

    func signinWithGoogle(presenting: UIViewController,
                          completion: @escaping (Error?) -> Void) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)

        GIDSignIn.sharedInstance.configuration = config

        guard let presentingVC = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else {return}

        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: presentingVC ) { signInResult, error in

            if let error = error {
                completion(error)
                return
            }

            guard
                let authentication = signInResult?.user,
                let idToken = authentication.idToken?.tokenString
            else {
                return
            }


            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: authentication.accessToken.tokenString)

            Auth.auth().signIn(with: credential) { result, error in
                guard error == nil else {
                    completion(error)
                    return
                }
                
                let existingUserRef = Firestore.firestore().collection("users").whereField("email", isEqualTo: email)
                existingUserRef.getDocuments { snapshot, error in
                    if let error = error {
                        completion(error)
                        return
                    }
                    
                    if let snapshot = snapshot, !snapshot.isEmpty {
                        // User with the same email already exists
                        let duplicateEmailError = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "An account with this email already exists"])
                        completion(duplicateEmailError)
                        return
                    }
                    
                    guard let user = result?.user else {
                        print("Failed to retrieve Firebase user")
                        return
                    }
                    
                    let uid = user.uid
                    let email = user.email ?? ""
                    let name = user.displayName ?? ""
                    let photoURLString = user.photoURL?.absoluteString ?? ""
                    // ... retrieve any other relevant user information
                    
                    // Save the user information to Firestore
                    let db = Firestore.firestore()
                    let userRef = db.collection("users").document(uid)
                    
                    
                    userRef.getDocument { snapshot, error in
                        if let error = error {
                            completion(error)
                            return
                        }
                        
                        if let snapshot = snapshot, snapshot.exists {
                            // User already exists in Firestore, no need to overwrite the data
                            print("User already exists")
                            completion(nil)
                        } else {
                            
                            userRef.setData(["uid": uid, "email": email, "name": name, "profileImageUrl": photoURLString ], merge: true) { error in
                                if let error = error {
                                    print("Firestore error: \(error.localizedDescription)")
                                } else {
                                    print("User information saved to Firestore")
                                }
                            }
                        }
                    }
                }
                print("SIGN IN")

                UserDefaults.standard.set(true, forKey: "signin")
                // When this change to true, it will go to the home screen
            }
        }
    }
}

struct User {
    let uid: String
    let displayName: String?
    let email: String?
    let photoURL: URL?
}
