//
//  LogInErrors.swift
//  CafeMap
//
//  Created by Artemiy Zuzin on 05.05.2022.
//

import Foundation

enum LogInErrors: Error {
    case passwordFieldIsSmall,someError
}

enum SignInErrors: Error {
    case passwordFieldIsSmall, someError
}
