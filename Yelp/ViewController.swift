//
//  ViewController.swift
//  Yelp
//
//  Created by Jeremy Hageman on 2/9/15.
//  Copyright (c) 2015 CodePath. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UISearchResultsUpdating {
    
    @IBOutlet weak var restrauntView: UITableView!
    
    var client: YelpClient!
    var restrauntData: [NSDictionary]?
    var restrauntArray: NSArray?
    
    let restrauntCellId = "restrauntCellId"
    
    let yelpConsumerKey = "bi7aPcPpHZqcIsW20xaD2w"
    let yelpConsumerSecret = "KGK4-XwyP5Z4Fc_ZLM3agMrNxes"
    let yelpToken = "UMkM4gOguWEXxx8xc19xxv61inyW5FFh"
    let yelpTokenSecret = "aT8M5j1rsvryrE6GsxdhxadMtoc"
    
    var searchController: UISearchController!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        restrauntView.dataSource = self
        restrauntView.estimatedRowHeight = 81.0
        restrauntView.rowHeight = UITableViewAutomaticDimension
        performSearch("Thai")
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        navigationItem.titleView = searchController.searchBar
        definesPresentationContext = true
        searchController.hidesNavigationBarDuringPresentation = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = restrauntView.dequeueReusableCellWithIdentifier(restrauntCellId, forIndexPath: indexPath) as RestrauntTableViewCell
        if let restraunt = restrauntArray?[indexPath.row] as? NSDictionary {
            let name = restraunt["name"] as NSString
            cell.restrauntNameLabel.text = "\(indexPath.row + 1). \(name)"
            
            if let reviewCount = restraunt["review_count"] as? Int {
                cell.reviewCountLabel.text = "\(reviewCount) Reviews"
            }
            
            if let location = restraunt["location"] as? NSDictionary {
                if let address = location["address"] as? NSArray {
                    if var streetAddress = address[0] as? String {
                        if let neighborhoods = location["neighborhoods"] as? NSArray {
                            if let hood = neighborhoods[0] as? String {
                                streetAddress += ", \(hood)"
                            }
                        }
                        cell.streetAddressLabel.text = streetAddress
                    }
                }
            }
            
            if let categories = restraunt["categories"] as? NSArray {
                var cat = [String]()
                for category in categories {
                    if let c = category[0] as? String {
                        cat.append(c)
                    }
                }
                cell.categoriesLabel.text = ", ".join(cat)
            }
    
            if let dist = restraunt["distance"] as? NSString {
//                println(restraunt["distance"])
//                let miles = dist.bridgeToObjectiveC().floatValue
//                let m = miles. * 0.00062137
//                cell.distanceLabel.text = "\(miles) mi"
            }
            
            let imageUrl = restraunt["image_url"] as NSString
            let starUrl = restraunt["rating_img_url"] as NSString
            let placeholder = UIImage(named: "no_photo")
            
            let imageRequestSuccess = {
                (request : NSURLRequest!, response : NSHTTPURLResponse!, image : UIImage!) -> Void in
                cell.restrauntThumb.image = image;
                cell.restrauntThumb.alpha = 0
                cell.restrauntThumb.layer.cornerRadius = 4.0
                cell.restrauntThumb.clipsToBounds = true
                UIView.animateWithDuration(0.5, animations: {
                    cell.restrauntThumb.alpha = 1.0
                })
                
                cell.restrauntThumb.setImageWithURL(NSURL(string: imageUrl))
            }
            let imageRequestFailure = {
                (request : NSURLRequest!, response : NSHTTPURLResponse!, error : NSError!) -> Void in
                NSLog("imageRequrestFailure")
            }
            
            let urlRequest = NSURLRequest(URL: NSURL(string: imageUrl)!)
            
            cell.restrauntThumb.setImageWithURLRequest(urlRequest, placeholderImage: placeholder, success: imageRequestSuccess, failure: imageRequestFailure)
            
            let starUrlRequest = NSURLRequest(URL: NSURL(string: starUrl)!)
            
            let starImageSuccess = {
                (request : NSURLRequest!, response : NSHTTPURLResponse!, image : UIImage!) -> Void in
                cell.starImage.image = image;
                cell.starImage.alpha = 0
                UIView.animateWithDuration(0.5, animations: {
                    cell.starImage.alpha = 1.0
                })
                
                cell.starImage.setImageWithURL(NSURL(string: starUrl))
            }
            
            cell.starImage.setImageWithURLRequest(starUrlRequest, placeholderImage: placeholder, success: starImageSuccess, failure: imageRequestFailure)
            
        }
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let array = restrauntArray {
            return array.count
        } else {
            return 0
        }
    }
    
    func performSearch(term: NSString) {
        client = YelpClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret)
        
        client.searchWithTerm(term, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            self.restrauntArray = response["businesses"] as? NSArray
            self.restrauntView.reloadData()
            
            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println(error)
        }
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchText = searchController.searchBar.text
        if !searchText.isEmpty  && countElements(searchText) > 2 {
            performSearch(searchText)
        }
    }
    
}

