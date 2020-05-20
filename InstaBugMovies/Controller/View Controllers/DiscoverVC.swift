//
//  DiscoverVC.swift
//  InstaBugMovies
//
//  Created by Ahmed Rezik on 5/19/20.
//  Copyright © 2020 Ahmed Rezik. All rights reserved.
//

import Foundation
import UIKit

public class DiscoverVC: UIViewController{
//MARK:- Instance Vriables
    
    fileprivate var activityIndicator: LoadMoreActivityIndicator!
    @IBOutlet weak var discoverTableView: UITableView!

    static var pagenumber = 1
    var selectedSection = 1
    var selectedIndex = 1
    var ImagesCache = [Int:UIImage]()
    
   
    //MARK: VIEW LIFECYCLE METHODS
    public override func viewDidLoad() {
        discoverTableView.accessibilityIdentifier = "DiscoverTableView"
        // Activity Indicator at the Bottom of tableview
        activityIndicator = LoadMoreActivityIndicator(scrollView: discoverTableView, spacingFromLastCell: 10, spacingFromLastCellWhenLoadMoreActionStart: 60)
        
        //API Call to get Discover Movies
        TMDBClient.getMoviePopular(pageNumber: DiscoverVC.pagenumber, completion: handleResponse(success:error:))
        
        //Observers whether the User added a New Movie or not
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableView), name: Notification.Name("didCreateMovie"), object: nil)
    }
    
    //Selector func for Notification
    @objc func reloadTableView(){
        discoverTableView.reloadData()
    }
    
  
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "overview" {
            let destination = segue.destination as! MovieDetailView
            switch selectedSection {
            case 0:
                destination.overviewText = ClassesModel.userMovies[selectedIndex].overview
                destination.Viewtitle = ClassesModel.userMovies[selectedIndex].title
            case 1:
                destination.overviewText = ClassesModel.searchList[selectedIndex].overview
                destination.Viewtitle = ClassesModel.searchList[selectedIndex].title
            default:
                break
            }
        }
    }
   
  //MARK:- Privte class Funcs
    private func handleResponse(success:Bool,error:Error?){
        
        if(success){
            DispatchQueue.main.async {
                self.discoverTableView.reloadData()
            }
           
        }
        else{
            DispatchQueue.main.async {
                self.ShowAlert(message: "Error. Please Try again")
            }
            
        }
    }
    
    
}

//MARK:- TableView DataSource Extension
extension DiscoverVC:  UITableViewDataSource{
    
    //Count of rows in ech section
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return ClassesModel.userMovies.count
        
        case 1: return ClassesModel.searchList.count
        default:
            return 0
        }
    }
    
    //No.of sections in the TableView
    public func numberOfSections(in tableView: UITableView) -> Int {
       return 2
    }
    
    //Title for each section
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "User Movies"
        case 1:
            return "My Movies"
        default:
            return ""
            
        }
    }

    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieCell
 
        if indexPath.section == 0 {
            cell.posterImage.image = UIImage()
            let movie = ClassesModel.userMovies[indexPath.row]
            
                if let posterimage = movie.posterImage {
                    cell.posterImage.image = posterimage
                }
                else{
                    cell.posterImage.image = UIImage(named: "placeholder")
                }
            
            cell.TitleDateLabel.text = "\(movie.title) - \(movie.releaseYear)"
            return cell
        }
        
        
        let movie = ClassesModel.searchList[indexPath.row]
        cell.posterImage.image = UIImage()
        
        if let image = ImagesCache[movie.id] {
            cell.posterImage.image = image
        }
        else{
            if let posterpath = movie.posterPath{
                TMDBClient.downloadPosterImage(path: posterpath) { (data, error) in
                           guard let data = data
                            else{
                                return
                    }
                    DispatchQueue.main.async {
                        let posterImage = UIImage(data: data)
                        cell.posterImage.image = posterImage
                        self.ImagesCache[movie.id] = posterImage
                    }
                    
                       }
            }
        else{
            cell.posterImage.image = UIImage(named: "placeholder")
            }
            
            }
        
        
        let releaseYear = String(movie.releaseDate.prefix(4))
        cell.TitleDateLabel.text = "\(movie.title) - \(releaseYear)"
        return cell
        
        
        
        
    }
   
}

//MARK:- Table View Delegate Extension
extension DiscoverVC: UITableViewDelegate {
    
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
    
        activityIndicator.start {
            DiscoverVC.pagenumber += 1
            TMDBClient.getMoviePopular(pageNumber: DiscoverVC.pagenumber) { (success, error) in
                    if success{
                        DispatchQueue.main.async {
                            self.discoverTableView.reloadData()
                        }
                        
                    }
                    else{
                        DispatchQueue.main.async {
                            self.ShowAlert(message: "There are no more available Movies")
                        }
                        
                    }
            }
            self.activityIndicator.stop()
            }
    }
    
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        selectedSection = indexPath.section
        performSegue(withIdentifier: "overview", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
    
  

//MARK:- AlertView Method
extension DiscoverVC{
    public func ShowAlert(message:String){
        
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
                                      alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                                      NSLog("The \"OK\" alert occured.")
                                      }))
        
                    self.present(alert, animated: true)
        
    }}






