//
//  CustomMovieModel.swift
//  InstaBugMovies
//
//  Created by Ahmed Rezik on 5/20/20.
//  Copyright © 2020 Ahmed Rezik. All rights reserved.
//

import Foundation
import UIKit

public struct CustomMovie{
    
    let title:String
    let releaseYear:String
    let posterImage:UIImage?
    let overview:String
    
    public init(title:String, releaseYear:String,posterImage:UIImage?,overview:String){
        self.overview = overview
        self.posterImage = posterImage
        self.title = title
        self.releaseYear = releaseYear
        
    }
    
    
    
}
