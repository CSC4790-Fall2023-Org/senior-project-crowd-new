//
//  ContentView.swift
//  senior-project-crowd-new
//
//  Created by Gerremy F on 10/27/23.
//

import SwiftUI
import Firebase
import FirebaseStorage
import FirebaseFirestore
import FirebaseCore

class FirebaseManager: NSObject {
    
    let auth: Auth
    let storage: Storage
    let firestore: Firestore
    
    static let shared = FirebaseManager()
    
    override init() {
        
        FirebaseApp.configure()
        
        self.auth = Auth.auth()
        self.storage = Storage.storage()
        self.firestore = Firestore.firestore()
        
        super.init()
        
    }
    
}

struct HomePage: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("crowd.")
                    .font(.system(size: 60))
                    .fontWeight(.bold)
                NavigationLink(destination: LoginView()) {
                    Text("Click Here to Log In/Create an Account")
                        .foregroundColor(.blue)
                        .font(.system(size:15))
                        .fontWeight(.bold)
                }
            }
        }
    }
}

struct LoginView: View {
    
    @State var isLoginMode = false
    @State var email = ""
    @State var password = ""
    
    @State var shouldShowImagePicker = false
    
    var body: some View {
        
        NavigationView{
            ScrollView {
                VStack(spacing: 16) {
                    Picker(selection: $isLoginMode, label: Text("Picker here")) {
                        Text("Login")
                            .tag(true)
                        Text("Create Account")
                            .tag(false)
                    }.pickerStyle(SegmentedPickerStyle())
                        //.padding()
                    
                    if !isLoginMode {
                        Button {
                            shouldShowImagePicker.toggle()
                        } label: {
                            VStack {
                                if let image = self.image {
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 128, height: 128)
                                        .cornerRadius(64)
                                } else {
                                    Image(systemName: "person.fill") // could use person.3.sequence.fill here
                                        .symbolRenderingMode(.hierarchical)
                                        .foregroundStyle(Color(.init(red: 0.15, green: 0.9, blue: 0.9, alpha: 0.8)))
                                        //.background(Color.white)
                                        .font(.system(size: 94))
                                        .padding()
                                }
                            }
                            .overlay(RoundedRectangle(cornerRadius: 64)
                                .stroke(Color(.init(red: 0.15, green: 0.9, blue: 0.9, alpha: 0.8)), lineWidth: 3)
                            )
                        }
                    }
                    
                    Group {
                        TextField("Email", text: $email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                        SecureField("Password", text: $password)
                            .autocapitalization(.none)
                    }
                    .padding(11)
                    .background(Color(.init(white: 1, alpha: 0.1)))
                    
                    //Text("Here is my account creation page")
                    
                    Button {
                        handleAction()
                    } label: {
                        HStack {
                            Spacer()
                            Text(isLoginMode ? "Log In" : "Create Account")
                                .foregroundColor(.white)
                                .padding(.vertical, 10)
                                .font(.system(size: 14, weight: .semibold))
                            Spacer()
                        }.background(Color(.init(red: 0.15, green: 0.9, blue: 0.9, alpha: 0.8)))
                    }
                    
                    Text(self.loginStatusMessage)
                        .foregroundColor(.pink)
                    
                }
                .padding()
                .background(Color(.init(white: 0, alpha: 0.02)))
            }
            .navigationTitle(isLoginMode ? "Log In" : "Create Account")
            .background(Color(.init(red: 0.75, green: 0.95, blue: 0.95, alpha: 0.5)))
                //.ignoreSafeArea())
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .fullScreenCover(isPresented: $shouldShowImagePicker, onDismiss: nil) {
            ImagePicker(image: $image)
            }
    }
    
    @State var image: UIImage?
    
    private func handleAction() {
        if isLoginMode {
            //print("Should log into Firebase with existing credentials")
            loginUser()
        } else {
            createNewAccount()
            //print("Register a new acount inside of Firebase Auth and then store image in Storage")
        }
    }
    
    private func loginUser() {
        FirebaseManager.shared.auth.signIn(withEmail: email, password: password) {
            result, err in
            if let err = err {
                print("Failed to login user:", err)
                self.loginStatusMessage = "Failed to login user: \(err)"
                return
            }
            
            print("Successfully logged in as user: \(result?.user.uid ?? "")")
            
            self.loginStatusMessage = "Successfully logged in as user: \(result?.user.uid ?? "")"
        }
    }
    
    @State var loginStatusMessage = ""
    
    private func createNewAccount() {
        FirebaseManager.shared.auth.createUser(withEmail: email, password: password) {
            result, err in
            if let err = err {
                print("Failed to create user:", err)
                self.loginStatusMessage = "Failed to create user: \(err)"
                return
            }
            
            print("Successfully created user: \(result?.user.uid ?? "")")
            
            self.loginStatusMessage = "Successfully created user: \(result?.user.uid ?? "")"
            
            self.persistImageToStorage()
            
        }
    }
    
    private func persistImageToStorage() {
        //let filename = UUID().uuidString
        guard let uid = 
            FirebaseManager.shared.auth.currentUser?.uid
            else { return }
        let ref = 
            FirebaseManager.shared.storage
            .reference(withPath: uid)
        guard let imageData = 
            self.image?.jpegData(compressionQuality: 0.5)
            else { return }
        ref.putData(imageData, metadata: nil) { metadata, err in
            if let err = err {
                self.loginStatusMessage = "Failed to push image to Storage: \(err)"
                return
            }
                
            ref.downloadURL { url, err in
                if let err = err {
                    self.loginStatusMessage = "Failed to retrieve download URL: \(err)"
                    return
                }
                    
                self.loginStatusMessage = "Successfully stored image with url: \(url?.absoluteString ?? "")"
                print(url?.absoluteString)
                
                guard let url = url else { return }
                self.storeUserInformation(imageProfileUrl: url)
            }
        }
    }
    
    private func storeUserInformation(imageProfileUrl: URL) {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        let userData = ["email": self.email, "uid": uid, "profileImageUrl": imageProfileUrl.absoluteString]
        FirebaseManager.shared.firestore.collection("users")
            .document(uid).setData(userData) { err in
                if let err = err {
                    print(err)
                    self.loginStatusMessage = "\(err)"
                    return
                }
                
                print("Success")
                
            }
    }
}

#Preview {
    HomePage()
    //LoginView()
}
