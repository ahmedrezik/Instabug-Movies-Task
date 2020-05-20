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
    var selectedSection = 0
    var selectedIndex = 0
    
    @IBAction func AddMovie(_ sender: Any) {
        
        
    }
    //MARK: VIEW LIFECYCLE METHODS
    public override func viewDidLoad() {
        activityIndicator = LoadMoreActivityIndicator(scrollView: discoverTableView, spacingFromLastCell: 10, spacingFromLastCellWhenLoadMoreActionStart: 60)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableView), name: Notification.Name("didCreateMovie"), object: nil)
    }
    
    @objc func reloadTableView(){
        discoverTableView.reloadData()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        
        TMDBClient.getMoviePopular(pageNumber: DiscoverVC.pagenumber, completion: handleResponse(success:error:))
    
        
            
    }
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "overview" {
            let destination = segue.destination as! MovieDetailView
            switch selectedSection {
            case 0:
                destination.overviewText = ClassesModel.userMovies[selectedIndex].overview
            case 1:
                destination.overviewText = ClassesModel.searchList[selectedIndex].overview
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
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return ClassesModel.userMovies.count
        
        case 1: return ClassesModel.searchList.count
        default:
            return 0
        }
    }
    public func numberOfSections(in tableView: UITableView) -> Int {
       return 2
    }
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "User Movies"
        case 1:
            return "Disovered Movies"
        default:
            return ""
            
        }
    }

    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieCell
        
        cell.posterImage.image = UIImage()
        
        if indexPath.section == 0 {
            let movie = ClassesModel.userMovies[indexPath.row]
            if let posterImage = movie.posterImage{
                cell.posterImage.image = posterImage
                
            }
            else{
                cell.posterImage.image = UIImage(named: "placeholder")
            }
            cell.TitleDateLabel.text = "\(movie.title) - \(movie.releaseYear)"
            
            
            
            return cell
        }
        
        let movie = ClassesModel.searchList[indexPath.row]
        
        if let posterpath = movie.posterPath{
            TMDBClient.downloadPosterImage(path: posterpath) { (data, error) in
                       guard let data = data
                        else{
                            return
                }
                DispatchQueue.main.async {
                    let posterImage = UIImage(data: data)
                    cell.posterImage.image = posterImage
                }
                
                   }
        }
        else{
            cell.posterImage.image = UIImage(named: "placeholder")
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
    
  


//MARK:- Class for Activity Indicator
class LoadMoreActivityIndicator {

    private let spacingFromLastCell: CGFloat
    private let spacingFromLastCellWhenLoadMoreActionStart: CGFloat
    private weak var activityIndicatorView: UIActivityIndicatorView?
    private weak var scrollView: UIScrollView?

    private var defaultY: CGFloat {
        guard let height = scrollView?.contentSize.height else { return 0.0 }
        return height + spacingFromLastCell
    }

    deinit { activityIndicatorView?.removeFromSuperview() }

    init (scrollView: UIScrollView, spacingFromLastCell: CGFloat, spacingFromLastCellWhenLoadMoreActionStart: CGFloat) {
        self.scrollView = scrollView
        self.spacingFromLastCell = spacingFromLastCell
        self.spacingFromLastCellWhenLoadMoreActionStart = spacingFromLastCellWhenLoadMoreActionStart
        let size:CGFloat = 40
        let frame = CGRect(x: (scrollView.frame.width-size)/2, y: scrollView.contentSize.height + spacingFromLastCell, width: size, height: size)
        let activityIndicatorView = UIActivityIndicatorView(frame: frame)
        activityIndicatorView.color = .black
        activityIndicatorView.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin]
        activityIndicatorView.hidesWhenStopped = true
        scrollView.addSubview(activityIndicatorView)
        self.activityIndicatorView = activityIndicatorView
    }

    private var isHidden: Bool {
        guard let scrollView = scrollView else { return true }
        return scrollView.contentSize.height < scrollView.frame.size.height
    }

    func start(closure: (() -> Void)?) {
        guard let scrollView = scrollView, let activityIndicatorView = activityIndicatorView else { return }
        let offsetY = scrollView.contentOffset.y
        activityIndicatorView.isHidden = isHidden
        if !isHidden && offsetY >= 0 {
            let contentDelta = scrollView.contentSize.height - scrollView.frame.size.height
            let offsetDelta = offsetY - contentDelta

            let newY = defaultY-offsetDelta
            if newY < scrollView.frame.height {
                activityIndicatorView.frame.origin.y = newY
            } else {
                if activityIndicatorView.frame.origin.y != defaultY {
                    activityIndicatorView.frame.origin.y = defaultY
                }
            }

            if !activityIndicatorView.isAnimating {
                if offsetY > contentDelta && offsetDelta >= spacingFromLastCellWhenLoadMoreActionStart && !activityIndicatorView.isAnimating {
                    activityIndicatorView.startAnimating()
                    closure?()
                }
            }

            if scrollView.isDecelerating {
                if activityIndicatorView.isAnimating && scrollView.contentInset.bottom == 0 {
                    UIView.animate(withDuration: 0.3) { [weak self] in
                        if let bottom = self?.spacingFromLastCellWhenLoadMoreActionStart {
                            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: bottom, right: 0)
                        }
                    }
                }
            }
        }
    }

    func stop(completion: (() -> Void)? = nil) {
        guard let scrollView = scrollView , let activityIndicatorView = activityIndicatorView else { return }
        let contentDelta = scrollView.contentSize.height - scrollView.frame.size.height
        let offsetDelta = scrollView.contentOffset.y - contentDelta
        if offsetDelta >= 0 {
            UIView.animate(withDuration: 0.3, animations: {
                scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            }) { _ in completion?() }
        } else {
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            completion?()
        }
        activityIndicatorView.stopAnimating()
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
