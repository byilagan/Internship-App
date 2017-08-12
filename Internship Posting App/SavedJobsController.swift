//
//  SavedJobsController.swift
//  Internship Posting App
//
//  Created by Bailey Ilagan on 8/11/17.
//  Copyright © 2017 Bailey Ilagan. All rights reserved.
//

import UIKit

class SavedJobsController: UIViewController {
    
    var savedJobs: [Job] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool {return true}
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
