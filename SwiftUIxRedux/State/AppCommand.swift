//
//  AppCommand.swift
//  SwiftUIxRedux
//
//  Created by Nic Wu on 2022/9/14.
//

import Foundation
import Combine

/*
 Command用來代表「在設置狀態的同時需要觸發的"副作用"」
 1. Reducer 在返回新的 State 的同時，還返回一個需要進行某種副作用的Command
 2. Store 在接收到這個 Command 後，開始進行額外的操作
 3. 操作完成後發送一個新的 Action
 4. 新的Action 再次觸發Reducer 在返回新的 State (同1)
 */

/*
 - 副作用： 「會」改變 State 的副作用
 - 純副作用：「不再」改變 State 的副作用
 */

protocol AppCommand {
    func execute(in store: Store)
}


// MARK: - SubscriptionToken
/*
 為了保存通過sink訂閱返回的值(AnyCancellable)，
 相當於AnyCancellable.store(in: inout Set<AnyCancellable>)
 */
class SubscriptionToken {
    var cancellable: AnyCancellable?
    func unseal() { cancellable = nil }
}

extension AnyCancellable {
    func seal(in token: SubscriptionToken) {
        token.cancellable = self
    }
}

// MARK: - LoginAppCommand
struct LoginAppCommand: AppCommand {
    
    let email: String
    let password: String

    func execute(in store: Store) {
        
        let token = SubscriptionToken()
        
        LoginRequest(email: email, password: password).publisher
            .sink(receiveCompletion: { complete in
                if case .failure(let error) = complete {
                    // 發送新的Action
                    store.dispatch(.accountBehaviorDone(result: .failure(error)))
                }
                token.unseal()
            }, receiveValue: { user in
                // 發送新的Action
                store.dispatch(.accountBehaviorDone(result: .success(user)))
            }).seal(in: token)
    }
}
