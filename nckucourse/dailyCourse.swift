//
//  dailyCourse.swift
//  nckucourse
//
//  Created by Lee Yu Hsun on 2015/7/14.
//  Copyright (c) 2015年 Lee Yu Hsun. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class dailyCourse: UITableViewController ,NSFetchedResultsControllerDelegate,UITableViewDataSource, UITableViewDelegate{
	
	
	let managedObjectContext: NSManagedObjectContext? = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext
	
	var fetchedResultsController: NSFetchedResultsController = NSFetchedResultsController()
	var weekday:Int?
	var nowweekday:Int = 1
	@IBOutlet var dailylist: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
		self.dailylist.delegate = self
		self.dailylist.dataSource = self
		fetchedResultsController.delegate = self
		        // Do any additional setup after loading the view.
    }
	override func viewWillAppear(animated: Bool) {
		
		let vc = self.parentViewController
		
		weekday=vc?.valueForKey("nowweek") as? Int
		print("MY:\(weekday)")
		if weekday != nil{
			nowweekday = weekday!
		}
		print(nowweekday)
		var error:NSError? = nil
		let fetchRequest = NSFetchRequest(entityName: "Course")
		let sortDescriptor = NSSortDescriptor(key: "time", ascending: true)
		let cidsearch = NSPredicate(format: "time CONTAINS %@","[\(nowweekday)]")
		fetchRequest.sortDescriptors = [sortDescriptor]
		fetchRequest.predicate=cidsearch
		fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
		fetchedResultsController.performFetch(&error)
		self.dailylist.reloadData()
		
		//print("hello1")
		
	}
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return fetchedResultsController.sections!.count
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section:Int) -> Int {
		let sectionInfo = fetchedResultsController.sections![section] as! NSFetchedResultsSectionInfo
		return sectionInfo.numberOfObjects

	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		//print("hello2")
		let cell = tableView.dequeueReusableCellWithIdentifier("Daily", forIndexPath: indexPath) as! UITableViewCell
		let data = fetchedResultsController.objectAtIndexPath(indexPath) as! Course
		//print(data)
		
		cell.textLabel?.text=data.time+data.name
		
		return cell
	}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
