//
//  ViewController.swift
//  ui jokes
//
//  Created by Илья Кузнецов on 10.07.2024.
//

import UIKit

class JokeViewController: UIViewController {
// MARK: - IBOutlets
    @IBOutlet private var idLabel: UILabel!
    @IBOutlet private var typeLabel: UILabel!
    
    @IBOutlet private var jokeLabel: UILabel!
    
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
    
    private var alertPresenter: AlertPresenterProtocol?
    
    private var joke: JokeModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let alertPresenter = AlertPresenter()
        alertPresenter.delegate = self
        self.alertPresenter = alertPresenter
        
        setupJoke()

        showLoadingIndicator()
    }

    @IBAction private func showPunchlineButton(_ sender: Any) {
        let text = joke?.punchline ?? ""
        let alertModel = AlertModel(
            title: "Punchline",
            message: text,
            buttonMessage: "Ok",
            completion: {
                print("Punchline показан")
            }
        )
        alertPresenter?.showAlert(model: alertModel)
    }
    
    @IBAction private func resetButton(_ sender: Any) {
        setupJoke()
    }
    
    private func showLoadingIndicator() {
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
    }
    
    private func setupJoke() {
        let jokeLoader = JokeLoader()
        jokeLoader.loadJoke{ [weak self] result in
            DispatchQueue.main.async {
                guard let self else { return }
                switch result {
                case .success(let currentJoke):
                    self.activityIndicator.stopAnimating()
                    self.joke = currentJoke
                    self.idLabel.text = String(currentJoke.id)
                    self.jokeLabel.text = currentJoke.setup
                    self.typeLabel.text = currentJoke.type
                case .failure(let error):
                    self.showError(error: error) // TODO: написать алерт для фейла
                }
            }
        }
    }
    private func showError(error: Error) {
        let alertModel = AlertModel(
            title: "Ошибка" ,
            message: error.localizedDescription,
            buttonMessage: "Ok",
            completion: { [weak self] in
                guard let self else { return }
                self.setupJoke()
            }
        )
            alertPresenter?.showAlert(model: alertModel)
    }
}
// MARK: - extensions
extension JokeViewController: AlertPresenterDelegate {
    func showAlert(_ alert: UIAlertController) {
        present(alert, animated: true)
    }
    
    
}
