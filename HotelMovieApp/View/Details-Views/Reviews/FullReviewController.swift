//
//  FullReviewController.swift
//  HotelMovieApp
//
//  IB DP Computer Science IA
//

import UIKit
import WebKit

class FullReviewController: UIViewController {
    
    lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
         webView.addObserver(self, forKeyPath: #keyPath(WKWebView.isLoading), options: .new, context: nil)
        webView.backgroundColor = .black
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
    }
    
    init(reviewUrlString: String) {
        super.init(nibName: nil, bundle: nil)
        
        loadReview(with: reviewUrlString)
    }
    
    override func loadView() {
          self.view = webView
    }
    
    func loadReview(with urlString: String) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
           print(Float(webView.estimatedProgress))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
