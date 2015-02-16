//
//  FiltersViewController.swift
//  Yelp
//
//  Created by Jeremy Hageman on 2/12/15.
//  Copyright (c) 2015 CodePath. All rights reserved.
//

import UIKit

enum FilterSectionIdentifier : String {
    case Category = "Category"
    case Sort = "Sort"
    case Radius = "Radius"
    case Deals = "Deals"
}

enum CategoryId : String {
    case BreakfastBrunch = "Breakfast & Brunch"
    case Indian = "Indian"
    case Japanese = "Japanese"
    case Thai = "Thai"
}

enum SortId : String {
    case BestMatch = "Best Match"
    case Distance = "Distance"
    case HighestRated = "Highest Rated"
}

enum RadiusId : String {
    case TwoBlocks = "2 Blocks"
    case SixBlocks = "6 Blocks"
    case OneMile = "1 Mile"
    case FiveMiles = "5 Miles"
}

enum FilterRowId : String {
    case CategoriesBrunch = "Breakfast & Brunch"
    case CategoriesIndian = "Indian"
    case CategoriesJapanese = "Japanese"
    case CategoriesThai = "Thai"
    case SortBest = "Best Match"
    case SortDistance = "Distance"
    case SortRated = "Highest Rated"
    case Radius2Blocks = "2 Blocks"
    case Radius6Blocks = "6 Blocks"
    case Radius1Mile = "1 Mile"
    case Radius5Miles = "5 Miles"
    case Deals = "On/Off"
}

class FiltersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, FiltersSwitchCellDelegate {
    
    @IBOutlet weak var filtersView: UITableView!
    
    let CellId = "filtersCellId", HeaderId = "TableViewHeaderViewId"

    let tableStructure: [[FilterRowId]] = [[.CategoriesBrunch, .CategoriesIndian, .CategoriesJapanese, .CategoriesThai], [.SortBest, .SortDistance, .SortRated], [.Radius2Blocks, .Radius6Blocks, .Radius1Mile, .Radius5Miles], [.Deals]]
    var filterValues: [FilterRowId: Bool] = [:]
    
    var filtersStructure = [("Category", ["Thai", "Japanese", "Indian", "Breakfast & Brunch"]), ("Sort", ["Best Match", "Distance", "Highest Rated"]), ("Radius", ["2 Blocks", "6 Blocks", "1 Mile", "5 Miles"]), ("Deals", ["On/Off"])]
    
    var currentFilters: Filters! {
        didSet {
            filterValues[.CategoriesBrunch] = currentFilters.categoriesBrunch
            filterValues[.CategoriesIndian] = currentFilters.categoriesIndian
            filterValues[.CategoriesJapanese] = currentFilters.categoriesJapanese
            filterValues[.CategoriesThai] = currentFilters.categoriesThai
            filterValues[.SortBest] = currentFilters.sortBest
            filterValues[.SortDistance] = currentFilters.sortDistance
            filterValues[.SortRated] = currentFilters.sortRated
            filterValues[.Radius2Blocks] = currentFilters.radius2Blocks
            filterValues[.Radius6Blocks] = currentFilters.radius6Blocks
            filterValues[.Radius1Mile] = currentFilters.radius1Mile
            filterValues[.Radius5Miles] = currentFilters.radius5Miles
            filterValues[.Deals] = currentFilters.deals
            filtersView?.reloadData()
        }
    }
    
    func filtersFromTableData() -> Filters {
        let ret = Filters()
        ret.categoriesBrunch = filterValues[.CategoriesBrunch] ?? ret.categoriesBrunch
        ret.sortBest = filterValues[.SortBest] ?? ret.sortBest
        ret.sortDistance = filterValues[.SortDistance] ?? ret.sortDistance
        return ret
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentFilters = currentFilters ?? Filters()
        
        let titleLabel = UILabel()
        titleLabel.text = "Filter"
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.sizeToFit()
        navigationItem.titleView = titleLabel

        filtersView.dataSource = self
        filtersView.delegate = self
        
        filtersView.registerClass(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: HeaderId)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func searchButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func cancelButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return tableStructure.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableStructure[section].count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = filtersView.dequeueReusableCellWithIdentifier(CellId, forIndexPath: indexPath) as FiltersTableViewCell
        
        // change the default margin of the table divider length
        if (cell.respondsToSelector(Selector("setPreservesSuperviewLayoutMargins:"))){
            cell.preservesSuperviewLayoutMargins = false
        }
        if (cell.respondsToSelector(Selector("setSeparatorInset:"))){
            cell.separatorInset = UIEdgeInsetsMake(0, 4, 0, 0)
        }
        if (cell.respondsToSelector(Selector("setLayoutMargins:"))){
            cell.layoutMargins = UIEdgeInsetsZero
        }

        let filterIdentifier = tableStructure[indexPath.section][indexPath.row]
        cell.filterRowIdentifier = filterIdentifier
        cell.filterSwitch.on = filterValues[filterIdentifier]!
        cell.delegate = self
        
        return cell
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = filtersView.dequeueReusableHeaderFooterViewWithIdentifier(HeaderId) as UITableViewHeaderFooterView
        header.textLabel.text = filtersStructure[section].0
        
        return header
    }
    
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        let header:UITableViewHeaderFooterView = view as UITableViewHeaderFooterView
        
        header.textLabel.font = UIFont(name: "Ubuntu-Medium", size: 15.0)
        header.textLabel.textColor = UIColor.darkTextColor()
        header.textLabel.sizeToFit()
        header.textLabel.frame = header.frame
        header.textLabel.frame = CGRectMake(header.frame.origin.y+8, 8, 0, 0)
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func filterSwitchCellDidToggle(cell: FiltersTableViewCell, newValue: Bool) {
        filterValues[cell.filterRowIdentifier] = newValue
    }
}
