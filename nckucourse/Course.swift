//
//  Course.swift
//  nckucourse
//
//  Created by Lee Yu Hsun on 2015/7/16.
//  Copyright (c) 2015年 Lee Yu Hsun. All rights reserved.
//

import Foundation
import CoreData

class Course: NSManagedObject {

    @NSManaged var cclass: String
    @NSManaged var cid: String
    @NSManaged var credit: String
    @NSManaged var csn: String
    @NSManaged var dep: String
    @NSManaged var depname: String
    @NSManaged var name: String
    @NSManaged var place: String
    @NSManaged var sem: String
    @NSManaged var syear: String
    @NSManaged var teacher: String
    @NSManaged var time: String
    @NSManaged var type: String
    @NSManaged var d1: NSNumber
    @NSManaged var d2: NSNumber
    @NSManaged var d3: NSNumber
    @NSManaged var d4: NSNumber
    @NSManaged var d5: NSNumber
    @NSManaged var d6: NSNumber
    @NSManaged var d7: NSNumber

}
