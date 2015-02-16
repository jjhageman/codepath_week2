//
//  YelpClient.swift
//  Yelp
//
//  Created by Jeremy Hageman on 2/9/15.
//  Copyright (c) 2015 CodePath. All rights reserved.
//

import UIKit

class YelpClient: BDBOAuth1RequestOperationManager {
    var accessToken: String!
    var accessSecret: String!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(consumerKey key: String!, consumerSecret secret: String!, accessToken: String!, accessSecret: String!) {
        self.accessToken = accessToken
        self.accessSecret = accessSecret
        var baseUrl = NSURL(string: "http://api.yelp.com/v2/")
        super.init(baseURL: baseUrl, consumerKey: key, consumerSecret: secret);
        
        var token = BDBOAuth1Credential(token: accessToken, secret: accessSecret, expiration: nil)
        self.requestSerializer.saveAccessToken(token)
    }
    
    func searchWithTerm(term: String, params: Dictionary<String, String>, success: (AFHTTPRequestOperation!, AnyObject!) -> Void, failure: (AFHTTPRequestOperation!, NSError!) -> Void) -> AFHTTPRequestOperation! {
        // For additional parameters, see http://www.yelp.com/developers/documentation/v2/search_api
        var parameters = ["term": term, "ll" : "37.791412, -122.395606"]
        
        var combinedParams : NSMutableDictionary!
        
        combinedParams = NSMutableDictionary(dictionary: parameters)
        if !params.isEmpty {
            combinedParams.addEntriesFromDictionary(params)
        }
        return self.GET("search", parameters: combinedParams, success: success, failure: failure)
    }
    
}
