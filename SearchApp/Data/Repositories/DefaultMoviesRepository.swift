//
//  DefaultMoviesRepository.swift
//  SearchApp
//
//  Created by Khanh Nguyen on 7/10/25.
//

import Foundation

final class DefaultMoviesRepository {
    
}

extension DefaultMoviesRepository: MoviesRepository {
    func fetchMoviesList() {
        // ở repository sẽ tương tác trực tiếp với API manager và return về 1 cái publisher(), ngày mai cần thêm các params tương tứng vào
    }
}


//class PhotoService {
//    
//    @Published var result: (photos: [PhotoModel]?, error: String?) = (nil, nil)
//    private var photosSubscription: AnyCancellable?
//    
//    private let fetchDataPublisher: () -> AnyPublisher<[PhotoModel], Error>
//    
//    init(fetchDataPublisher: @escaping () -> AnyPublisher<[PhotoModel], Error> = {
//        NetworkingManager.fetchWithCache(from: Constants.photosURLString)
//            .decode(type: [PhotoModel].self, decoder: JSONDecoder())
//            .eraseToAnyPublisher()
//    }) {
//        self.fetchDataPublisher = fetchDataPublisher
//    }
//
    
    //    func fetchPhotos() -> AnyPublisher<[PhotoModel], Error> {
    //        return fetchDataPublisher()
    //    }
//}
