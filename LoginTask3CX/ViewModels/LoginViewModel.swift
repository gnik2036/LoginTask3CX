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
    @Published var buttonIsEnable: Bool = false
    @Published var textColor: UIColor = .red
    @Published var warningMessage: String = ""
    
    
    private var authService = AuthService()
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    
    private var repeatPasswordIsMatch: AnyPublisher<SignUpErrors, Never> {
        $confirmPass
            .map { [self] in
                self.textColor = .red
                if $0 == password {
                    return .success
                } else {
                    return .passwordMatched
                }
            }
            .eraseToAnyPublisher()
    }
    
    private var passwordIsMatch: AnyPublisher<SignUpErrors, Never> {
        $password
            .map { [self] in
                self.textColor = .red
                if confirmPass.count > 0 {
                    if $0 == confirmPass {
                        return .success
                    } else {
                        return .passwordMatched
                    }
                } else {
                    return .success
                }
            }
            .eraseToAnyPublisher()
    }
    
    
    private var isPasswordValide: AnyPublisher<SignUpErrors, Never> {
        $password
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .map({
                self.textColor = .red
                if $0 == "admin" || $0 == "password" {
                    return .prohibitedPassword
                } else {
                    if $0.count < 8 {
                        return .passwordShort
                    } else {
                        return .success
                    }
                    
                }
            })
            .eraseToAnyPublisher()
    }
    
    private var isUsernameValide: AnyPublisher<SignUpErrors, Never> {
        $username
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .map({
                self.textColor = .red
                if $0.count < 5 {
                    return .shortName
                } else {
                    return .success
                }
            })
            .eraseToAnyPublisher()
    }
    
    private var formIsValid: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest4(isUsernameValide, isPasswordValide , passwordIsMatch ,repeatPasswordIsMatch )
            .map { username, password , passwordMatch , passwordRepeate in
                if username == .success && password == .success && passwordMatch == .success && passwordRepeate == .success
                {
                    if self.confirmPass.count > 0
                    {
                        return true
                    }
                    else
                    {
                        return false
                    }
                }
                else {

                    return false
                }
                
            }
            .eraseToAnyPublisher()
    }
    
   
    
    init() {
        
        isUsernameValide
            .receive(on: RunLoop.main)
            .map({
                $0.rawValue
            })
            .assign(to: \.warningMessage, on: self)
            .store(in: &cancellableSet)
        
        isPasswordValide
            .receive(on: RunLoop.main)
            .map({
                $0.rawValue
            })
            .assign(to: \.warningMessage, on: self)
            .store(in: &cancellableSet)
        
        passwordIsMatch
            .receive(on: RunLoop.main)
            .map(
                {$0.rawValue
                })
            .assign(to: \.warningMessage, on: self)
            .store(in: &cancellableSet)
        
        repeatPasswordIsMatch
            .receive(on: RunLoop.main)
            .map(
                {$0.rawValue
                })
            .assign(to: \.warningMessage, on: self)
            .store(in: &cancellableSet)
        
        formIsValid
            .receive(on: RunLoop.main)
            .assign(to: \.buttonIsEnable, on: self)
            .store(in: &cancellableSet)
    }
    
    func singUp() {
        authService.auth { [self] (response) in
            self.textColor = .green
            self.warningMessage = response
        }
    }
    
    
}
