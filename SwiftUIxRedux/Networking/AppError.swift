//
//  AppError.swift
//  SwiftUIxRedux
//
//  Created by Nic Wu on 2022/9/14.
//

import Foundation

enum AppError: Error, Identifiable {
    
    var id: String { localizedDescription }

    case passwordWrong
}

extension AppError: LocalizedError {
    
    var localizedDescription: String {
        switch self {
        case .passwordWrong: return "密码错误"
        }
    }
}
