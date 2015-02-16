//
//  Filters.swift
//  Yelp
//
//  Created by Jeremy Hageman on 2/14/15.
//  Copyright (c) 2015 CodePath. All rights reserved.
//

import Foundation

class Filters {
    var categoriesBrunch = false, categoriesIndian = false, categoriesJapanese = false, categoriesThai = true
    var sortBest = true, sortDistance = false, sortRated = false
    var radius2Blocks = true, radius6Blocks = false, radius1Mile = false, radius5Miles = false
    var deals = false
//    var categories = ["thai"]
    
    //0=Best matched (default), 1=Distance, 2=Highest Rated.
//    var sort = 0
    
    // 1 mile = 1,609.34 meters
    // 0=2 blocks, 1=6 blocks, 2=1 mile, 3=5 miles
    // 1 block ~ 100 meters
//    var radius = 200
    
    // On/Off
//    var deals = "false"
}