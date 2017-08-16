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


class ViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource, SaveButtonDelegate {
    
    @IBOutlet weak var jobList: UITableView!
    
    var jobArray: [Job] = []
    var savedJobs: [Job] = []
    
    override var prefersStatusBarHidden: Bool { return true }
    
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
                            
                            let newJob = Job( id: subJson["id"].string,
                                              title: subJson["title"].string,
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

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.jobList.dequeueReusableCell(withIdentifier: "Job Entry", for: indexPath) as! JobCell
        
        cell.jobTitle.text = jobArray[indexPath.row].title
        cell.companyName.text = jobArray[indexPath.row].company
        cell.postDate.text = jobArray[indexPath.row].date
        cell.delegate = self
        cell.index = indexPath
        
        if let logoString = jobArray[indexPath.row].logo {
            if let url = URL(string: logoString) {
                cell.companyLogo.setImageWith(url)
            }
        }
        
        return cell
    }
    
    func saveButtonClick (at index: IndexPath) {
        print(index)
        
        let newSavedJob = jobArray[index.row]
        
        // Unarchive savedJobs array
        if let data = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? [Job] {
            savedJobs = data
        }
        
        // Add job to array 
        savedJobs.append(newSavedJob)
        
        // Archive array 
        NSKeyedArchiver.archiveRootObject(savedJobs, toFile: filePath)
        
        // Change text of button to "Already Saved" and deactivate functionality
        (jobList.cellForRow(at: index) as? JobCell)?.saveButton.setTitle("Already Saved", for: .disabled)
    }

}

