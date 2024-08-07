//
//  AlertPresenter.swift
//  ui jokes
//
//  Created by Илья Кузнецов on 05.08.2024.
//

import UIKit

class AlertPresenter: AlertPresenterProtocol {
 
    weak var delegate: AlertPresenterDelegate?
    
    func showAlert(model: AlertModel) {
        let alert = UIAlertController(
            title: model.title,
            message: model.message,
            preferredStyle: .alert
        )
        
        let action = UIAlertAction(
            title: model.buttonMessage,
            style: .default
        ) { _ in
            model.completion()
        }
        
        alert.addAction(action)
        
        delegate?.showAlert(alert)
    }
}
