//
//  MovieDetailsController.swift
//  HotelMovieApp
//
//  IB DP Computer Science IA
//

import UIKit

class MovieDetailsController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    fileprivate let detailsCellid = "detailsCellid"
    fileprivate let castCellid = "castCellid"
    fileprivate let headerid = "headerid"
    fileprivate let footedId = "footerID"
    fileprivate let rewiewCellID = "rewiewCellID"
    
    var movie: Movie?
    
    var castMembers = [CastMember]()
    var reviews = [Review]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(MovieDetailsCell.self, forCellWithReuseIdentifier: detailsCellid)
        collectionView.register(MovieDetailsReviewSectionCell.self, forCellWithReuseIdentifier: rewiewCellID)
        collectionView.register(MovieDetailsCastSectionCell.self, forCellWithReuseIdentifier: castCellid)
        collectionView.register(DetailsPosterHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerid)
        collectionView.register(DetailsFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footedId)
        
        fetchMovieCast()
        fetchReviews()
    }
    
    func fetchReviews() {
        guard let movieId = movie?.id else { return }
        
        ApiService.shared.fetchReviews(movieId: movieId) { (result) in
            switch result {
            case .failure(let error):
                print("error in fetching reviews ", error)
            case .success(let response):
                self.reviews = response.results
            }
        }
    }
    
    func fetchMovieCast() {
        guard let movieId = movie?.id else {
            print("no movie id, nil movie")
            return
        }
        
        ApiService.shared.fetchCredits(movieId: movieId) { (result) in
            switch result {
            case .failure(let error):
                print("error in cast fetching ", error)
            case .success(let response):
                guard let cast = response.cast else { return }
                self.castMembers = cast
            }
        }
    }
    
    func showFullReviewForReview(reviewString: String) {
        let fullReviewController = FullReviewController(reviewUrlString: reviewString)
        print(reviewString)
        present(fullReviewController, animated: true, completion: nil)
    }
    
    func handleClose() {
        dismiss(animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 0 {
            return .init(width: view.frame.width, height: 250)
        }
        
        if indexPath.section == 1 {
            return .init(width: view.frame.width, height: 200)
        }
        
        return .init(width: view.frame.width, height: 400)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: detailsCellid, for: indexPath) as! MovieDetailsCell
            cell.movie = movie
            cell.movieDetailsController = self 
            return cell
        }
        
        if indexPath.section == 1 {
            let castCell = collectionView.dequeueReusableCell(withReuseIdentifier: castCellid, for: indexPath) as! MovieDetailsCastSectionCell
            castCell.movieCastMembers = castMembers
            return castCell
        }
        
        let reviewCell = collectionView.dequeueReusableCell(withReuseIdentifier: rewiewCellID, for: indexPath) as! MovieDetailsReviewSectionCell
        reviewCell.movieReviews = reviews
        reviewCell.detailsController = self
        return reviewCell
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerid, for: indexPath) as! DetailsPosterHeader
            header.detailsController = self
            header.movie = movie
            return header
        }
        
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footedId, for: indexPath) as! DetailsFooter
        footer.movie = movie 
        return footer 
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        if section != 2 {
            return .zero
        }
        
        return .init(width: view.frame.width, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            let width = view.frame.width
            let height = width * 1.5
            
            return .init(width: width, height: height)
        }
        return .zero
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}


