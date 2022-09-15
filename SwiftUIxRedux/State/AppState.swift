//
//  AppState.swift
//  SwiftUIxRedux
//
//  Created by Nic Wu on 2022/9/14.
//

import Foundation

struct AppState {
    var settings = Settings()
}

extension AppState {
    
    /*
     AppState.Settings 替代原本在 SettingView 的 Settings: ObservableObject
     */
    struct Settings {
        
        enum AccountBehavior: CaseIterable {
            case register, login
        }

        enum Sorting: CaseIterable {
            case id, name, color, favorite
        }

        var accountBehavior = AccountBehavior.login
        var email = ""
        var password = ""
        var verifyPassword = ""

        var showEnglishName = true
        var sorting = Sorting.id
        var showFavoriteOnly = false
        
        var loginUser: User?
        var loginRequesting = false
        var loginError: AppError?
    }
}
