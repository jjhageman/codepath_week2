//
//  FiltersViewController.swift
//  Yelp
//
//  Created by Jeremy Hageman on 2/12/15.
//  Copyright (c) 2015 CodePath. All rights reserved.
//

import UIKit

class FiltersViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var filtersView: UITableView!
    
    var filterSections = [("Category", ["Category"]), ("Sort", ["Best Match", "Distance", "Highest Rated"]), ("Radius", ["Meters"]), ("Deals", ["On/Off"])]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleLabel = UILabel()
        titleLabel.text = "Filter"
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.sizeToFit()
        navigationItem.titleView = titleLabel

        self.filtersView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return filterSections.count
    }
    
    func tableView(filtersView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterSections[section].1.count
    }
    
    func tableView(filtersView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = filtersView.dequeueReusableCellWithIdentifier("filtersCellId", forIndexPath: indexPath) as FiltersTableViewCell
        let filtersInSection = filterSections[indexPath.section].1
        cell.filterLabel.text = filtersInSection[indexPath.row]
        return cell
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
