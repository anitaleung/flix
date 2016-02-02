//
//  MoviesViewController.swift
//  Flix
//
//  Created by Anita on 1/25/16.
//  Copyright © 2016 Anita Leung. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD

class MoviesViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var networkErrorView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet var navi: UIView!
    
    var movies: [NSDictionary]?
    var filteredMovies: [NSDictionary]?
    var endpoint: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.networkErrorView.alpha = 0.0
        
        collectionView.dataSource = self
        collectionView.delegate = self
        searchBar.delegate = self
        
        // Shadow on navigation
        navi.layer.shadowColor = UIColor.blackColor().CGColor
        navi.layer.shadowOpacity = 0.3
        navi.layer.shadowOffset = CGSizeZero
        navi.layer.shadowRadius = 3
        navi.layer.shadowPath = UIBezierPath(rect: navi.bounds).CGPath
        navi.layer.shouldRasterize = true
        
        // Display HUD right before the request is made
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
    
        // Initialize a UIRefreshControl
        let refreshControl = UIRefreshControl()
        
        refreshControl.bounds = CGRectMake(0, 90, refreshControl.bounds.size.width, refreshControl.bounds.size.height)
        refreshControl.addTarget(self, action: "refreshControlAction:", forControlEvents: UIControlEvents.ValueChanged)
        collectionView.insertSubview(refreshControl, atIndex: 0)
        refreshControlAction(refreshControl)
    }
    
    // Refresh and retrieve data to display in collection view
    func refreshControlAction(refreshControl: UIRefreshControl) {
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = NSURL(string: "https://api.themoviedb.org/3/movie/\(endpoint)?api_key=\(apiKey)")
        let request = NSURLRequest(
            URL: url!,
            cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData,
            timeoutInterval: 5
        )
        
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate: nil,
            delegateQueue: NSOperationQueue.mainQueue()
        )
        
        let task: NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
                            // Hide HUD once the network request comes back (must be done on main UI thread)
                            MBProgressHUD.hideHUDForView(self.view, animated: true)
                            
                            // Hide network error
                            self.networkErrorView.alpha = 0.0
                            
                            self.movies = responseDictionary["results"] as? [NSDictionary]
                            self.filteredMovies = self.movies
                            
                            // Reload the collection view now that there is new data
                            self.collectionView.reloadData()
                            
                            // Tell the refreshControl to stop spinning
                            refreshControl.endRefreshing()
                    }
                }
                // Network error
                if let _ = error {
                    refreshControl.endRefreshing()
                    UIView.animateWithDuration(0.2, animations: {() -> Void in
                        self.networkErrorView.alpha = 1.0
                    })
                }
        })
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Behavior for searchbar
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredMovies = movies
        } else {
            filteredMovies = movies?.filter({(movie: NSDictionary) -> Bool in
                if (movie["title"] as! String).rangeOfString(searchText, options: .CaseInsensitiveSearch) != nil {
                    return true
                } else {
                    return false
                }
            })
        }
        collectionView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        self.searchBar.setShowsCancelButton(true, animated: true)
    }
    
    // Clear search bar when cancel is hit
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
        searchBar.text = ""
        filteredMovies = movies
        collectionView.reloadData()
    }
    
    // Return appropriate number of movies
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let movies = filteredMovies {
            return movies.count
        } else {
            return 0
        }
    }
    
    // Populate collection cell with movie posters
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("codepath.MovieCollectionCell", forIndexPath: indexPath) as! MovieCollectionCell
        let movie = filteredMovies![indexPath.row]
//
//        //cell.titleLabel.text = title
//        //cell.overviewLabel.text = overview
//        cell.moviePoster.setImageWithURL(imageUrl!)
        
        if let posterPath = movie["poster_path"] as? String {
            let baseUrl = "http://image.tmdb.org/t/p/w500"
            if let imageUrl = NSURL(string: baseUrl + posterPath){
                let imageRequest = NSURLRequest(URL: imageUrl)
                
                // Fade movie poster in
                cell.moviePoster.setImageWithURLRequest(imageRequest, placeholderImage: nil, success: {(imagerequest, imageResponse, image) -> Void in
                    if imageResponse != nil{
                        cell.moviePoster.alpha = 0.0
                        cell.moviePoster.image = image
                        UIView.animateWithDuration(0.3, animations: {() -> Void in
                            cell.moviePoster.alpha = 1.0
                        })
                    } else{
                        cell.moviePoster.image = image
                    }},
                    failure: nil
                )
            }
        }
        return cell
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let cell = sender as! UICollectionViewCell
        let indexPath = collectionView.indexPathForCell(cell)
        let movie = movies![indexPath!.row]
        
        let detailViewController = segue.destinationViewController as! DetailViewController
        detailViewController.movie = movie
        
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }


}

