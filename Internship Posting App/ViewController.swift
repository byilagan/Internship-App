//
//  ViewController.swift
//  Internship Posting App
//
//  Created by Bailey Ilagan on 7/17/17.
//  Copyright © 2017 Bailey Ilagan. All rights reserved.
//

import UIKit
import SwiftyJSON
import AFNetworking


class ViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var jobList: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        searchJobs(searchString: "python")
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        
        if let search = searchBar.text {
            searchJobs(searchString: search)
        }
    }
    
    func searchJobs (searchString:String) {
        
        let manager = AFHTTPSessionManager();
        
        let searchParameters:[String:Any] = ["description": searchString]
        
        manager.get("http://jobs.github.com/positions.json?",
                    parameters: searchParameters,
                    progress: nil,
                    success: {(operation: URLSessionDataTask, responseObject: Any?) in
                        
                        if let responseObject = responseObject {
                            print("Response: " + (responseObject as AnyObject).description)
                        }
                        
                        let json = JSON(responseObject as Any)
                        
                        
        })
    }

    override var prefersStatusBarHidden: Bool {
        
        return true
    }
}

