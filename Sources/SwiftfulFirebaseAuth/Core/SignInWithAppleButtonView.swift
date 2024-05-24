//
//  SignInWithAppleButtonView.swift
//
//
//  Created by Nick Sarno on 10/25/23.
//

import SwiftUI
import AuthenticationServices

public struct SignInWithAppleButtonView: View {
    public let type: ASAuthorizationAppleIDButton.ButtonType
    public let style: ASAuthorizationAppleIDButton.Style
    public let cornerRadius: CGFloat
    public let height: CGFloat?
    private let action: () -> Void

    
    public init(
        type: ASAuthorizationAppleIDButton.ButtonType = .signIn,
        style: ASAuthorizationAppleIDButton.Style = .black,
        cornerRadius: CGFloat = 15,
        height: CGFloat? = 55,
        action: @escaping () -> Void

    ) {
        self.type = type
        self.style = style
        self.cornerRadius = cornerRadius
        self.height = height
        self.action = action


    }
    
    public var body: some View {
        Button {
            onSignIn()
        } label: {
            SignInWithAppleButtonViewRepresentable(type: type, style: style, cornerRadius: cornerRadius)
                .disabled(true)
                .frame(height: height)
        }
    }
    
    @MainActor
    func onSignIn() {
        Task {
            do {
                let (authUser, isNewUser) = try await AuthManager.shared.signInApple()
            } catch {
                print("Error Apple Button: ", error)
            }
        } // task
    } // func
}

private struct SignInWithAppleButtonViewRepresentable: UIViewRepresentable {
    let type: ASAuthorizationAppleIDButton.ButtonType
    let style: ASAuthorizationAppleIDButton.Style
    let cornerRadius: CGFloat
    
    func makeUIView(context: Context) -> some UIView {
        let button = ASAuthorizationAppleIDButton(type: type, style: style)
        button.cornerRadius = cornerRadius
        return button
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    func makeCoordinator() -> () {
        
    }
}


