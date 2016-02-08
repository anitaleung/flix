//
//  DetailViewController.swift
//  Flix
//
//  Created by Anita on 2/1/16.
//  Copyright © 2016 Anita Leung. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
  
  @IBOutlet var posterImageView: UIImageView!
  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var overviewLabel: UILabel!
  @IBOutlet var scrollView: UIScrollView!
  @IBOutlet var infoView: UIView!
  @IBOutlet var releaseLabel: UILabel!
  
  var movie: NSDictionary!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let title = movie["title"] as? String
    titleLabel.text = title
    
    let releaseDate = movie["release_date"] as? String
    releaseLabel.text = releaseDate
    
    let overview = movie["overview"] as? String
    overviewLabel.text = overview
    
    // Auto size details label
    overviewLabel.sizeToFit()
    
    let infoHeight = overviewLabel.frame.size.height + titleLabel.frame.size.height + releaseLabel.frame.size.height
    
    // Set sizing for movie details and scroll view
    infoView.frame = CGRectMake(infoView.frame.origin.x, infoView.frame.origin.y, infoView.frame.size.width, infoHeight)
    scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: infoView.frame.origin.y + infoView.frame.size.height + 30)
    
    if let posterPath = movie["poster_path"] as? String {
      let baseUrl = "http://image.tmdb.org/t/p/w500"
      let imageUrl = NSURL(string: baseUrl + posterPath)
      
      posterImageView.setImageWithURL(imageUrl!)
    }
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  /*
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
  // Get the new view controller using segue.destinationViewController.
  // Pass the selected object to the new view controller.
  }
  */
}
