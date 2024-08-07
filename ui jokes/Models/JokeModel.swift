//
//  JokeModel.swift
//  ui jokes
//
//  Created by Илья Кузнецов on 06.08.2024.
//

import Foundation

class JokeModel: Decodable {
    let type: String
    let setup: String
    let punchline: String
    let id: Int
}
