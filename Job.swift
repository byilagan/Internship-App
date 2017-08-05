//
//  Job.swift
//  Internship Posting App
//
//  Created by Bailey Ilagan on 8/3/17.
//  Copyright © 2017 Bailey Ilagan. All rights reserved.
//

import UIKit

class Job: NSObject {
    var title: String? // position title
    var company: String? // company that the position is available for
    var date: String? // date the opening was posted
    var type: String? // indicates if job is full time or part time
    var jobDescription: String? // html markup for job description
    var applyLink: String? // html markup that holds link to application
    var logo: String? // logo image url
    
    init (title: String? = nil, company: String? = nil, date: String? = nil, type: String? = nil,
          jobDescription: String? = nil, applyLink: String? = nil, logo: String? = nil) {
        self.title = title
        self.company = company
        self.date = date
        self.type = type
        self.jobDescription = jobDescription
        self.applyLink = applyLink
        self.logo = logo
        
        super.init()
    }
}
