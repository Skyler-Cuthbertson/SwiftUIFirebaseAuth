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
    
    public init(
        type: ASAuthorizationAppleIDButton.ButtonType = .signIn,
        style: ASAuthorizationAppleIDButton.Style = .black,
        cornerRadius: CGFloat = 15,
        height: CGFloat? = 55
    ) {
        self.type = type
        self.style = style
        self.cornerRadius = cornerRadius
        self.height = height

    }
    
    public var body: some View {
        ZStack {
            Color.black.opacity(0.001)
            
            SignInWithAppleButtonViewRepresentable(type: type, style: style, cornerRadius: cornerRadius)
                .disabled(true)
                .frame(height: height)
        }
    }
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

#Preview("SignInWithAppleButtonView") {
    ZStack {
        Color.black
        
        VStack(spacing: 4) {
            SignInWithAppleButtonView(
                type: .signIn,
                style: .white, cornerRadius: 30)
                .frame(height: 50)
                .background(Color.red)
        }
        .padding(40)
    }
}
