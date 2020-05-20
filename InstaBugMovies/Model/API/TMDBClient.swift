//
//  TMDBClient.swift
//  InstaBugMovies
//
//  Created by Ahmed Rezik on 5/19/20.
//  Copyright © 2020 Ahmed Rezik. All rights reserved.
//

import Foundation

public class TMDBClient{

    
    
//MARK:- Endpoints
enum Endpoints {
    //enum Constants
    static let base = "https://api.themoviedb.org/3"
    static let APIkey = "d2ed2dc66b76dd8114925cde235b31e0"
    static let apiKeyParam = "?api_key=\(Endpoints.APIkey)"
    
   
  
    
    
    //Cases
    case discover(Int)
    case PosterImage(String)

    
    
    //String Value
    var StringValue: String{
        switch self {
        case .discover(let pageNumber): return Endpoints.base + "/discover/movie" + Endpoints.apiKeyParam + "&page=\(pageNumber)"
        case .PosterImage(let posterpath):
                       return "https://image.tmdb.org/t/p/w500/" + posterpath
        }
        
  
    }
    
    //URL intialized using the String
    var url: URL {
        return URL(string: StringValue)!
            }
   
}



//MARK:- Get Request for Downloading Images
public class func downloadPosterImage(path:String, completion: @escaping (Data?, Error?) -> Void) {
     let task = URLSession.shared.dataTask(with: Endpoints.PosterImage(path).url) { data, response, error in
         
         guard let data = data
             else{
                 completion(nil,error)
                 return
         }
         DispatchQueue.main.async {
             
             completion(data, error)
         }
             
         
     }
     task.resume()
 }
    
    //MARK:- Get Request for Discover Movies
    public class func getMoviePopular(pageNumber: Int, completion: @escaping (Bool,Error?) -> Void){
    
    let task = URLSession.shared.dataTask(with: Endpoints.discover(pageNumber).url) { (data, response, error) in
        
        guard let data = data else{
            completion(false,error)
            return
        }
        
        let decoder = JSONDecoder()
        
        do{
                  let payload = try decoder.decode(MovieResults.self, from: data)
                 print("successful parsing")
                  
            
                    payload.results.forEach { (movie) in
                        ClassesModel.searchList.append(movie)
                    }
         
                  completion(true,nil)
              }
          
        catch{
                print("--------------------------")
                print(response.debugDescription)
                print("--------------------------")
                print(error )
                completion(false,error)
                  }

    }
    
    task.resume()
}

}
