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


class ViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var jobList: UITableView!
    
    var jobArray: [Job] = []
    var savedJobs: [Job] = []
    
    var filePath: String {
        let manager = FileManager.default
        let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first
        return url!.appendingPathComponent("savedJobs").path
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        searchJobs(searchString: "")
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        /*for subview in self.jobList.subviews {
            subview.removeFromSuperview()
        }*/
        
        searchBar.resignFirstResponder()
        
        jobArray.removeAll()
        
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
                        
                        let jobs = JSON(responseObject as Any)
                        
                        for ( _ , subJson):(String, JSON) in jobs {
                            
                            let newJob = Job( title: subJson["title"].string,
                                              company: subJson["company"].string,
                                              date: subJson["created_at"].string,
                                              type: subJson["type"].string,
                                              jobDescription: subJson["description"].string,
                                              applyLink: subJson["how_to_apply"].string,
                                              logo: subJson["company_logo"].string)
                            
                            self.jobArray.append(newJob)
                            
                        }
                    self.jobList.reloadData()
                        
        })
    }
    
    func savedJob(jobToSave: Job) {
        
    }

    override var prefersStatusBarHidden: Bool {
        
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.jobList.dequeueReusableCell(withIdentifier: "Job Entry", for: indexPath) as! JobCell
        
        cell.jobTitle.text = jobArray[indexPath.row].title
        cell.companyName.text = jobArray[indexPath.row].company
        cell.postDate.text = jobArray[indexPath.row].date
        
        if let logoString = jobArray[indexPath.row].logo {
            if let url = URL(string: logoString) {
                cell.companyLogo.setImageWith(url)
            }
        }
        
        return cell
    }
}

