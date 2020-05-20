//
//  MovieDetailView.swift
//  InstaBugMovies
//
//  Created by Ahmed Rezik on 5/20/20.
//  Copyright © 2020 Ahmed Rezik. All rights reserved.
//

import Foundation
import UIKit
public class MovieDetailView: UIViewController{
    
    var overviewText:String!
    
    @IBOutlet weak var overViewField: UITextView!
    
    
    
    public override func viewWillAppear(_ animated: Bool) {
        overViewField.text = overviewText
       
    }
    
}
