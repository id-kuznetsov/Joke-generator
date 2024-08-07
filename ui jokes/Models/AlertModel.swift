//
//  AlertModel.swift
//  ui jokes
//
//  Created by Илья Кузнецов on 05.08.2024.
//

import UIKit

struct AlertModel {
    let title: String
    let message: String
    let buttonMessage: String
    let completion: () -> Void
}
