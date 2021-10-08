//
//  LoginViewModel.swift
//  LoginTask3CX
//
//  Created by Mohammed Hassan on 08/10/2021.
//



import SwiftUI
import Combine

class LoginViewModel: ObservableObject, Identifiable {
    
    @Published var username = ""
    @Published var password = ""
    @Published var confirmPass = ""
    
    @Published var isLoggedIn = false
    @Published var isLoading = false
    

    
}
