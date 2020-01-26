//
//  Service.swift
//  HotelMovieApp
//
//  IB DP Computer Science IA
//

import UIKit

class ApiService {
    
    static let shared = ApiService()
        
    func fetchMovieVideos(id: Int, completion: @escaping (Result<VideoResponse, Error>) -> () ) {
        
        let urlString = "https://api.themoviedb.org/3/movie/\(id)/videos?api_key=8708e6e442f4c7d558ae6aa51d79152b"
        
        fetchGenericData(urlString: urlString, completion: completion)
    }
    
    func fetchMovieDetails(id: Int, completion: @escaping (Result<Movie, Error>) -> () ) {
        let urlString = "https://api.themoviedb.org/3/movie/\(id)?api_key=8708e6e442f4c7d558ae6aa51d79152b"
        
        fetchGenericData(urlString: urlString, completion: completion)
    }
    
    func fetchTopRated(completion: @escaping (Result<TopRatedMovies, Error>) -> () ) {
        
        let urlString = "https://api.themoviedb.org/3/movie/top_rated?api_key=8708e6e442f4c7d558ae6aa51d79152b&region=US"
        
        fetchGenericData(urlString: urlString, completion: completion)
        
    }
    
    func fetchPopular(completion: @escaping (Result<PopularMovies, Error>) -> () ) {
        
        let urlString = "https://api.themoviedb.org/3/movie/popular?api_key=8708e6e442f4c7d558ae6aa51d79152b&region=US"
        
        fetchGenericData(urlString: urlString, completion: completion)
    }
    
    
    func fetchUpcoming(completion: @escaping (Result<UpcomingMovies, Error>) -> () ) {
        
        let urlString = "https://api.themoviedb.org/3/movie/upcoming?api_key=8708e6e442f4c7d558ae6aa51d79152b&region=US"
        
        fetchGenericData(urlString: urlString, completion: completion)
    }
    
    
    func fetchNowPlaying(completion: @escaping (Result<NowPlayingMovies, Error>) -> () ) {
        
        let urlString = "https://api.themoviedb.org/3/movie/now_playing?api_key=8708e6e442f4c7d558ae6aa51d79152b&region=US"
        
       fetchGenericData(urlString: urlString, completion: completion)
    }
    
    
    func fetchReviews(movieId: Int, completion: @escaping (Result<ReviewResponse, Error>) -> () ) {
        print(movieId)
        let urlString = "https://api.themoviedb.org/3/movie/\(movieId)/reviews?api_key=8708e6e442f4c7d558ae6aa51d79152b"
        
       fetchGenericData(urlString: urlString, completion: completion)
    }
    
    
    func fetchCredits(movieId: Int, completion: @escaping (Result<CreditsResponse, Error>) -> () ) {
        
        let urlString = "https://api.themoviedb.org/3/movie/\(movieId)/credits?api_key=8708e6e442f4c7d558ae6aa51d79152b"
        
       fetchGenericData(urlString: urlString, completion: completion)
    }
    
    
    func searchMovies(searchTerm: String, completion: @escaping (Result<SearchResult, Error>) -> () ) {
        
        let term = searchTerm.replacingOccurrences(of: " ", with: "%20")
        
        let urlString = "https://api.themoviedb.org/3/search/movie?api_key=8708e6e442f4c7d558ae6aa51d79152b&query=\(term)"
        
        fetchGenericData(urlString: urlString, completion: completion)
        
    }
    
    
    func fetchGenericData<T: Decodable>(urlString: String, completion: @escaping (Result<T, Error>) -> () ) {
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                    return
                }
            }
            
            guard let data = data else { return }
            
            do {
                let results = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(results))
                }
            }
                
            catch let error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
            
        }.resume()
        
    }
}
