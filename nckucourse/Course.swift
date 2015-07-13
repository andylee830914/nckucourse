//
//  Course.swift
//  nckucourse
//
//  Created by Lee Yu Hsun on 2015/7/14.
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
    @NSManaged var teacher: String
    @NSManaged var time: String
    @NSManaged var type: String

}
