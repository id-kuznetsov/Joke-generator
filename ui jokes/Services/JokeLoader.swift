//
//  JokeLoader.swift
//  ui jokes
//
//  Created by Илья Кузнецов on 06.08.2024.
//

import Foundation

protocol JokeLoaderProtocol {
    func loadJoke(handler: @escaping (Result<JokeModel, Error>) -> Void)
    }

struct JokeLoader: JokeLoaderProtocol {
    private let networkClient = NetworkClient()
    
    private var jokeUrl: URL {
        guard let url = URL(string: "https://official-joke-api.appspot.com/jokes/random") else {
            preconditionFailure("Unable to construct jokeUrl")
        }
        return url
    }
    
    func loadJoke(handler: @escaping (Result<JokeModel, any Error>) -> Void) {
        networkClient.fetch(url: jokeUrl) { result in
            switch result {
            case .success(let data):
                do {
                    let jokeModel = try JSONDecoder().decode(JokeModel.self, from: data)
                    handler(.success(jokeModel))
                } catch {
                    handler(.failure(error))
                }
            case .failure(let error):
                handler(.failure(error))
            }
        }
    }
    
}

