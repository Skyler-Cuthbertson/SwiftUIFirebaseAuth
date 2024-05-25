//
//  SignInWithGoogleButtonView.swift
//
//
//  Created by Nicholas Sarno on 11/6/23.
//

import Foundation
import SwiftUI
import AuthenticationServices
import Firebase

public extension Color {
    static let googleRed = Color("GoogleRed", bundle: Bundle.module)
}

public struct SignInWithGoogleButtonView: View {
    
    private var backgroundColor: Color
    private var foregroundColor: Color
    private var borderColor: Color
    private var buttonText: String
    private var cornerRadius: CGFloat
    private var height: CGFloat?
    private let onSuccess: () -> Void?

        
    public init(
        type: ASAuthorizationAppleIDButton.ButtonType = .signIn,
        style: ASAuthorizationAppleIDButton.Style = .black,
        cornerRadius: CGFloat = 15,
        height: CGFloat? = 55,
        onSuccess: @escaping () -> Void?

    ) {
        self.cornerRadius = cornerRadius
        self.height = height
        self.backgroundColor = style.backgroundColor
        self.foregroundColor = style.foregroundColor
        self.borderColor = style.borderColor
        self.buttonText = type.buttonText
        self.onSuccess = onSuccess
    }
    
    public init(
        type: ASAuthorizationAppleIDButton.ButtonType = .signIn,
        backgroundColor: Color = .googleRed,
        borderColor: Color = .googleRed,
        foregroundColor: Color = .white,
        cornerRadius: CGFloat = 15,
        height: CGFloat = 55,
        onSuccess: @escaping () -> Void?

    ) {
        self.cornerRadius = cornerRadius
        self.height = height
        self.backgroundColor = backgroundColor
        self.borderColor = borderColor
        self.foregroundColor = foregroundColor
        self.buttonText = type.buttonText
        self.onSuccess = onSuccess
    }
    
    public var body: some View {
        Button {
            signInWithGoogleButtonPressed()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(borderColor)
                
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(backgroundColor)
                    .padding(0.8)
                
                HStack(spacing: 8) {
                    Image("GoogleIcon", bundle: .module)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 16, height: 16)
                    
                    Text("\(buttonText) Google")
                        .font(.system(size: 21))
                        .fontWeight(.medium)
                        .foregroundColor(foregroundColor)
                }
                
            }
            .padding(.vertical, 1)
            .disabled(true)
        } // button
        .frame(height: height)
    }
    
    
    @MainActor
    func signInWithGoogleButtonPressed() {
        Task {
            do {
                guard let clientId = FirebaseApp.app()?.options.clientID else { throw URLError(.cannotCreateFile) }
                let (authUser, isNewUser) = try await AuthManager.shared.signInGoogle(GIDClientID: clientId)
                onSuccess()
            } catch {
                print("Error Google Button: ", error)
            }
        }
    } // func
    
    
}

