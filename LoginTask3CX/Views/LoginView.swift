//
//  LoginView.swift
//  LoginTask3CX
//
//  Created by Mohammed Hassan on 08/10/2021.
//


import SwiftUI

struct LoginView: View {
    
    @ObservedObject var viewModel = LoginViewModel()
    
    var loginButton: some View {
        {
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Text("Login").foregroundColor(.white).fontWeight(.bold)
                    Spacer()
                }
                Spacer()
            }.frame(minHeight: 55.0, maxHeight: 55.0)
                .background(Color.black)
                .cornerRadius(10)
                .padding(.top, 77.0)
            
        }().simultaneousGesture(TapGesture().onEnded{
            self.loginUser()
        })
    }
    
    var placeHolderTextView: some View {
        PlaceholderTextField(placeholder: Text("Username"), text: $viewModel.username)
            .padding(.top, 32.0)
    }
    
    var passwordTextView: some View {
        SecurePlaceholderTextField(placeholder: Text("Password"), text: $viewModel.password)
            .padding(.top, 32.0)
    }
    var passwordConfirmTextView: some View {
        SecurePlaceholderTextField(placeholder: Text("Confirm Password"), text: $viewModel.confirmPass)
            .padding(.top, 32.0)
    }
    
    
    var titleView: some View {
        VStack(alignment: .leading) {
            Text("Welcome to")
                .tracking(1.0)
            Text("3CX APP ").fontWeight(.bold)
        }.padding(EdgeInsets(top: 44.0, leading: .zero, bottom: .zero, trailing: .zero))
    }
    
    var body: some View {
        NavigationView {
            LoadingView(isShowing: .constant(false)) {
                VStack(alignment: .leading) {
                    self.titleView
                    self.placeHolderTextView
                    self.passwordTextView
                    self.passwordConfirmTextView
                    self.loginButton
                    Spacer()
                    Spacer()
                }.padding(22.0)
            }
        }
    
    }
    
    private func loginUser() {
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
