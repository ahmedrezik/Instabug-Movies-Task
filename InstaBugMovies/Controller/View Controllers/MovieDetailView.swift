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
    
    var overviewText:String! //title for Vc
    var Viewtitle: String! //The overview to be displayed
    @IBOutlet weak var overViewField: UITextView!
    
    
    
    public override func viewWillAppear(_ animated: Bool) {
        title = Viewtitle
        overViewField.text = overviewText
       
    }
    
}
