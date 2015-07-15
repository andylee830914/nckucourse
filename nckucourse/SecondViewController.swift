//
//  SecondViewController.swift
//  nckucourse
//
//  Created by Lee Yu Hsun on 2015/7/10.
//  Copyright (c) 2015年 Lee Yu Hsun. All rights reserved.
//

import UIKit
import Foundation
import CoreData


class SecondViewController: UIViewController,NSFetchedResultsControllerDelegate,UITableViewDataSource, UITableViewDelegate {
	let managedObjectContext: NSManagedObjectContext? = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext
	
	var fetchedResultsController: NSFetchedResultsController = NSFetchedResultsController()

	@IBOutlet weak var courselist: UITableView!
	override func viewDidLoad() {
		
		super.viewDidLoad()
		
		self.courselist.delegate = self
		self.courselist.dataSource = self

		
		
		fetchedResultsController.delegate = self
		// Do any additional setup after loading the view, typically from a nib.
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	override func viewWillAppear(animated: Bool) {
		var error:NSError? = nil
		let fetchRequest = NSFetchRequest(entityName: "Course")
		let sortDescriptor = NSSortDescriptor(key: "cid", ascending: true)
		fetchRequest.sortDescriptors = [sortDescriptor]
		fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
		fetchedResultsController.performFetch(&error)
		self.courselist.reloadData()
		
	}
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		print(fetchedResultsController.sections!.count)
		print("\n")
		return fetchedResultsController.sections!.count
	}
	func tableView(tableView: UITableView, numberOfRowsInSection section:Int) -> Int {
		let sectionInfo = fetchedResultsController.sections![section] as! NSFetchedResultsSectionInfo
		
		return sectionInfo.numberOfObjects
	}
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		print("hello2")
		let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
		let data = fetchedResultsController.objectAtIndexPath(indexPath) as! Course
		print(data)
		cell.textLabel?.text=data.name
		
		return cell
	}
	func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
		return true
	}
	
	func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
		if editingStyle == UITableViewCellEditingStyle.Delete {
				print("delete")
		}
	}
	
	let SegueID = "ShowDetail"
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == SegueID {
			//get destination controller
			var destViewController = segue.destinationViewController as! ShowCourseDetail;
			let indexPath = self.courselist?.indexPathForCell(sender as! UITableViewCell)
			let data = fetchedResultsController.objectAtIndexPath(indexPath!) as! Course
			destViewController.data=data
		}
		
	}

}

