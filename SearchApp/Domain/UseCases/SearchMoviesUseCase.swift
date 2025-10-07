//
//  SearchMoviesUseCase.swift
//  SearchApp
//
//  Created by Khanh Nguyen on 7/10/25.
//

import Foundation

protocol SearchMoviesUseCase {
    func fetch()
}

final class DefaultSearchMoviesUseCase: SearchMoviesUseCase {
    
    private let moviesRepository: MoviesRepository
    
    init(moviesRepository: MoviesRepository) {
        self.moviesRepository = moviesRepository
    }
    
    
    func fetch() {
        // ở đây sẽ call dóng photoService từng làm, rồi publish data qua viewModel
//        moviesRepository.fetchMoviesList() ở đây sẽ làm để 
    }
}


//func fetchPhotos() {
//    photosSubscription = fetchDataPublisher()
//        .sink(receiveCompletion: { [weak self] completion in
//            switch completion {
//            case .failure(let error):
//                self?.result = (nil, error.localizedDescription)
//            default:
//                break
//            }
//        }, receiveValue: { [weak self] dataResponse in
//            self?.result = (dataResponse, nil)
//            self?.photosSubscription?.cancel()
//        })
//}
