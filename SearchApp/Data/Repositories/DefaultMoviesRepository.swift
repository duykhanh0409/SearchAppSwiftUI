//
//  DefaultMoviesRepository.swift
//  SearchApp
//
//  Created by Khanh Nguyen on 7/10/25.
//

import Foundation
import Combine

final class DefaultMoviesRepository {
    private let fetchDataPublisher: ()-> AnyPublisher<MoviesPage, Error>
    
    init(
        fetchDataPublisher: @escaping () -> AnyPublisher<MoviesPage, Error>
    ) {
        self.fetchDataPublisher = fetchDataPublisher
    }
    
}

extension DefaultMoviesRepository: MoviesRepository {
    
    func fetchMoviesList(query: MovieQuery, page: Int) -> AnyPublisher<MoviesPage, any Error> {
        
        let requestDTO = MoviesRequestDTO(query: query.query, page: page)
        let endpoint = APIEndpoints.getMovies(with: requestDTO)
        
        return fetchDataPublisher()
    }



//    func fetch {
//        // ở repository sẽ tương tác trực tiếp với API manager và return về 1 cái publisher(), ngày mai cần thêm các params tương tứng vào
//    }
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
