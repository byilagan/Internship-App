//
//  Job.swift
//  Internship Posting App
//
//  Created by Bailey Ilagan on 8/3/17.
//  Copyright © 2017 Bailey Ilagan. All rights reserved.
//

import UIKit

class Job: NSObject, NSCoding {
    
    struct Keys {
        static let _Id = "id"
        static let _Title = "title"
        static let _Company = "company"
        static let _Date = "date"
        static let _Type = "type"
        static let _JobDescription = "jobDescription"
        static let _ApplyLink = "applyLink"
        static let _Logo = "logo"
    }
    
    var id: String? // unique id
    var title: String? // position title
    var company: String? // company that the position is available for
    var date: String? // date the opening was posted
    var type: String? // indicates if job is full time or part time
    var jobDescription: String? // html markup for job description
    var applyLink: String? // html markup that holds link to application
    var logo: String? // logo image url
    
    init (id: String? = nil, title: String? = nil, company: String? = nil, date: String? = nil, type: String? = nil, jobDescription: String? = nil, applyLink: String? = nil, logo: String? = nil){
        
        self.id = id
        self.title = title
        self.company = company
        self.date = date
        self.type = type
        self.jobDescription = jobDescription
        self.applyLink = applyLink
        self.logo = logo
        
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        if let idObj = aDecoder.decodeObject(forKey: Keys._Id) as? String {
            id = idObj
        }
        if let titleObj = aDecoder.decodeObject(forKey: Keys._Title) as? String {
            title = titleObj
        }
        if let companyObj = aDecoder.decodeObject(forKey: Keys._Company) as? String {
            company = companyObj
        }
        if let dateObj = aDecoder.decodeObject(forKey: Keys._Date) as? String {
            date = dateObj
        }
        if let typeObj = aDecoder.decodeObject(forKey: Keys._Type) as? String {
            type = typeObj
        }
        if let descriptionObj = aDecoder.decodeObject(forKey: Keys._JobDescription) as? String {
            jobDescription = descriptionObj
        }
        if let linkObj = aDecoder.decodeObject(forKey: Keys._ApplyLink) as? String {
            applyLink = linkObj
        }
        if let logoObj = aDecoder.decodeObject(forKey: Keys._Logo) as? String {
            logo = logoObj
        }
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: Keys._Id)
        aCoder.encode(title, forKey: Keys._Title)
        aCoder.encode(company, forKey: Keys._Company)
        aCoder.encode(date, forKey: Keys._Date)
        aCoder.encode(type, forKey: Keys._Type)
        aCoder.encode(jobDescription, forKey: Keys._JobDescription)
        aCoder.encode(applyLink, forKey: Keys._ApplyLink)
        aCoder.encode(logo, forKey: Keys._Logo)
    }
}
