//
//  AppAction.swift
//  SwiftUIxRedux
//
//  Created by Nic Wu on 2022/9/14.
//

import Foundation

/*
 按照原則，UI不能直接改變 AppState，需要通過發送 Action 並被 Reducer 處理，間接改變存儲在 Store 中的 AppState。
 */
enum AppAction {
    case login(email: String, password: String)
    case accountBehaviorDone(result: Result<User, AppError>)
}
