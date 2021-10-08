//
//  model.swift
//  LoginTask3CX
//
//  Created by Mohammed Hassan on 08/10/2021.
//

import Foundation

 enum SignUpErrors: String {
    case shortName = "user name should be  more than 5 char"
    case prohibitedPassword = "password must not Admin or Password"
    case passwordMatched = "password doesn't match"
    case passwordShort = "password should be more than 8 char"
    case success = ""
     case notYet = "not inserted"

}
