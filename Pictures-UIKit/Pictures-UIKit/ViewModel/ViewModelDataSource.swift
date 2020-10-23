//
//  ViewModelDataSource.swift
//  Pictures-UIKit
//
//  Created by Juan Capponi on 9/21/20.
//  Copyright © 2020 Juan Capponi. All rights reserved.
//

import Foundation
import UIKit

class ViewModelDataSource {
    
    init(){
        }
    
    func pictRetrieve() {
        let headers = Constants.headers
        
        let url = URL(string: Constants.urlPictures)
        guard let requestUrl = url else { fatalError() }

      // Create URL Request
        var request = URLRequest(url: requestUrl)
      
      // Specify HTTP Method to use
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        // Send HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // Check if Error took place
            if let error = error {
                print("Error took place \(error)")
                return
            }
            
            // Read HTTP Response Status code
            if let response = response as? HTTPURLResponse {
                //print("Response HTTP Status code: \(response.statusCode)")
            }
          
          guard let data = data, let dataString = String(data: data, encoding: .utf8) else {
              print("guard error")
              return
          }
          
          do {
            let jsonAll: JsonAll = try JSONDecoder().decode(JsonAll.self, from: data)
            self.photosArray = jsonAll.photos
          
          } catch let error {
                print("error:\(error.localizedDescription)")
            }
        }
        task.resume()
      
    }
    
    func videosRetrieve(){

        let headers = Constants.headers
        let url = URL(string: Constants.urlVideos)
        guard let requestUrl = url else { fatalError() }

        var request = URLRequest(url: requestUrl)
      
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print("Error took place \(error)")
                return
            }
            
            if let response = response as? HTTPURLResponse {
                print("Response HTTP Status code: \(response.statusCode)")
            }
          
          guard let data = data, let dataString = String(data: data, encoding: .utf8) else {
              return
          }
            
           // print(dataString)
            
          do {
                let jsonVideos: JsonVideos = try JSONDecoder().decode(JsonVideos.self, from: data)
                self.videosArray = jsonVideos.videos
            
            } catch let error {
                print("error:\(error.localizedDescription)")
            }
        }
      task.resume()
    }
   
    var refreshData = { () -> () in
      }
    
    var photosArray: [Photos] = [] {
            didSet {
                refreshData()
            }
        }
    
    var videosArray: [Videos] = [] {
        didSet {
            refreshData()
        }
    }
    
    var singlePicture: UIImage = UIImage() {
        didSet {
            refreshData()
        }
    }
    
    func singlepictRetrieve(url: String){
        guard let imageUrl:URL = URL(string: url) else {
            return
        }
        DispatchQueue.global().async { [weak self] in
            guard let imageData = try? Data(contentsOf: imageUrl) else {
                return
            }
            self!.singlePicture = UIImage(data: imageData)!
        }
    }
    
}


struct CellViewModelMovies {
    init(videoCreatorName: String, quality: String, link: String, imgageUrl: String ){
        self.name = videoCreatorName
        self.quality = quality
        self.link = link
        self.imgageUrl = imgageUrl
        
    }
    
    let name : String
    let quality : String
    let link : String
    var image : UIImage!
    let imgageUrl: String

    func loadPicture(url: String, completion: @escaping (UIImage) -> () ){
        guard let imageUrl:URL = URL(string: url) else {
            return
        }
        guard let imageData = try? Data(contentsOf: imageUrl) else {
            return
        }
        var img : UIImage?
        DispatchQueue.global(qos: .userInteractive).async {
            img = UIImage(data: imageData)!
            completion(img!)
        }
    }
    
    
    
}

struct CellViewModelPictures {
    
    init(photographerName: String, urlSmall : String, medium: String) {
        self.photographerName = photographerName
        self.urlSmall = urlSmall
        self.medium = medium
        //self.picture = simgleImage(urlSmall)
    }
    
    let photographerName: String
    let urlSmall : String
    let medium : String
    var picture: UIImage!
    
    let simgleImage:(String) -> (UIImage) = { url in
        var img: UIImage = UIImage()
        let data = try! Data(contentsOf: URL(string: url)!)
            img = UIImage(data: data)!
        return img
    }

    
    
  /*
    loadPicture(url: urlSmall) { img in
        //picture = img
        print("size..:\(img.size)")
    }
    */
    
    func loadPicture(url: String, completion: @escaping (UIImage) -> () ){
        guard let imageUrl:URL = URL(string: url) else {
            return
        }
        guard let imageData = try? Data(contentsOf: imageUrl) else {
            return
        }
        var img : UIImage?
        DispatchQueue.global(qos: .userInteractive).async {
            img = UIImage(data: imageData)!
            completion(img!)
        }
    }
    

}

