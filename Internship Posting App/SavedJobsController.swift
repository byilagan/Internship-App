//
//  SavedJobsController.swift
//  Internship Posting App
//
//  Created by Bailey Ilagan on 8/11/17.
//  Copyright © 2017 Bailey Ilagan. All rights reserved.
//

import UIKit
import SwiftyJSON
import AFNetworking

class SavedJobsController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var savedJobList: UITableView!

    var savedJobs: [Job] = []
    
    override var prefersStatusBarHidden: Bool {return true}
    
    var filePath: String {
        let manager = FileManager.default
        let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first
        return url!.appendingPathComponent("savedJobs").path
    }
    
    @IBAction func clearJobs(_ sender: Any) {
        if let data = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? [Job] {
            savedJobs = data
        }
        
        savedJobs.removeAll()
        
        NSKeyedArchiver.archiveRootObject(savedJobs, toFile: filePath)
        
        self.savedJobList.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let data = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? [Job] {
            savedJobs = data
        }
        
        print("Loaded Saved Jobs")
        self.savedJobList.reloadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        if let data = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? [Job] {
            savedJobs = data
        }
        
        print("Loaded Saved Jobs")
        self.savedJobList.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(savedJobs.count)
        return savedJobs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.savedJobList.dequeueReusableCell(withIdentifier: "Saved Job Entry", for: indexPath) as! JobCell
        
        cell.jobTitle.text = savedJobs[indexPath.row].title
        cell.companyName.text = savedJobs[indexPath.row].company
        cell.postDate.text = savedJobs[indexPath.row].date
        
        if let logoString = savedJobs[indexPath.row].logo {
            if let url = URL(string: logoString) {
                cell.companyLogo.setImageWith(url)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableView.dequeueReusableCell(withIdentifier: "Header")
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 88
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
