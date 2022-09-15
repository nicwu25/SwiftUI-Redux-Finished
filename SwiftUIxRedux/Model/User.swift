//
//  User.swift
//  SwiftUIxRedux
//
//  Created by Nic Wu on 2022/9/14.
//

import Foundation

struct User: Codable {
    var email: String
    var favoritePokemonIDs: Set<Int>

    func isFavoritePokemon(id: Int) -> Bool {
        favoritePokemonIDs.contains(id)
    }
}
