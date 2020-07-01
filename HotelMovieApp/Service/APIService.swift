//
//  APIService.swift
//  HotelMovieApp
//
//  Created by Andrew Demenagas on 6/5/20.
//  Copyright © 2020 Andrew Demenagas. All rights reserved.
//

import Foundation

class Service {
    
    static let shared = Service()
    static let smallImageUrl = "https://image.tmdb.org/t/p/w300/"
    
    fileprivate let base_url = "https://api.themoviedb.org/3/"
    fileprivate let api_key = "?api_key=8708e6e442f4c7d558ae6aa51d79152b"
    
    func fetchMovie(id: String, completion: @escaping (Result<Movie, Error>) -> () ) {
        let urlString = "https://api.themoviedb.org/3/movie/\(id)?api_key=8708e6e442f4c7d558ae6aa51d79152b&region=US"
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
        let urlString = "https://api.themoviedb.org/3/movie/\(movieId)/reviews?api_key=8708e6e442f4c7d558ae6aa51d79152b"
        fetchGenericData(urlString: urlString, completion: completion)
    }
    
    
    func fetchCredits(movieId: Int, completion: @escaping (Result<CreditsResponse, Error>) -> () ) {
        let urlString = "https://api.themoviedb.org/3/movie/\(movieId)/credits?api_key=8708e6e442f4c7d558ae6aa51d79152b"
        fetchGenericData(urlString: urlString, completion: completion)
    }
    
    func fetchMovieVideos(for id: Int, completion: @escaping (Result<VideoResponse, Error>) -> () ) {
        let urlString = base_url + "movie/\(id)/videos" + api_key
        fetchGenericData(urlString: urlString, completion: completion)
    }
    
    func searchMovies(searchTerm: String, completion: @escaping (Result<SearchResult, Error>) -> () ) {
        let term = searchTerm.replacingOccurrences(of: " ", with: "+")
        
        let urlString = base_url + "search/movie" + api_key + "&query=\(term)"
        
        fetchGenericData(urlString: urlString, completion: completion)
    }
    
    fileprivate func fetchGenericData<T: Decodable>(urlString: String, completion: @escaping (Result<T, Error>) -> ()) {
        guard let url = URL(string: urlString) else {
            return 
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                    return
                }
            }
            
            guard let data = data else {
                fatalError("Invalid Data")
            }
            
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
