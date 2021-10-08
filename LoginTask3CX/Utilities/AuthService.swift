//  AuthService.swift
//  LoginTask3CX
//
//  Created by Mohammed Hassan on 08/10/2021.
//

import Foundation

class AuthService {
    func auth(completion: @escaping(String) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completion("SUCCESS")
        }
    }
}
