//
//  ViewModel.swift
//  RedditListings
//
//  Created by Rahul Sharma on 1/1/20.
//  Copyright © 2020 Rahul Sharma. All rights reserved.
//

import Foundation


class ListingsModel {
    
    var children: [Children] = []
    
    func getListings(subreddit: String, _ completion: @escaping ([Children]?, Error?) -> Void) {
        let baseURL = subreddit.count > 0 ? "http://reddit.com/r/\(subreddit).json" :  "http://reddit.com/r/all.json"
        
        guard let url = URL(string: baseURL) else {return}
        
        URLSession.shared.dataTask(with: url) { [weak self] (data, resp, err) in
            
            if let err = err {
                print(err)
            }
            
            guard let data = data else {
                print("Error in the Data")
                return
            }
            
            switch Result(catching: {
            try JSONDecoder().decode(RedditData.self, from: data)
            }) {
            case .success(let json):
                DispatchQueue.main.async {
                    self?.children = json.data.children
                    completion(self?.children, nil)
                }
            case .failure(let err):
                print(err)
                completion(nil, err)
            }
        }.resume()
    }
    
}
