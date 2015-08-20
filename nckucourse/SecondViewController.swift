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


class SecondViewController: UITableViewController,NSFetchedResultsControllerDelegate {
	let managedObjectContext: NSManagedObjectContext? = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext
	
	var fetchedResultsController: NSFetchedResultsController = NSFetchedResultsController()

	override func viewDidLoad() {
		
		super.viewDidLoad()
		
		//self.courselist.delegate = self
		//self.courselist.dataSource = self
		var error:NSError? = nil
		let fetchRequest = NSFetchRequest(entityName: "Course")
		let sortDescriptor = NSSortDescriptor(key: "cid", ascending: true)
		fetchRequest.sortDescriptors = [sortDescriptor]
		fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
		fetchedResultsController.delegate = self
		fetchedResultsController.performFetch(&error)
		tableView.reloadData()
		
		
		
		// Do any additional setup after loading the view, typically from a nib.
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	override func viewWillAppear(animated: Bool) {
		tableView.reloadData()
		
	}
	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		//print(fetchedResultsController.sections!.count)
		//print("\n")
		return fetchedResultsController.sections?.count ?? 0
	}
	override func tableView(tableView: UITableView, numberOfRowsInSection section:Int) -> Int {
		//let sectionInfo = fetchedResultsController.sections![section] as! NSFetchedResultsSectionInfo
		
		return fetchedResultsController.sections?[section].numberOfObjects ?? 0
	}
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		//print("hello2")
		let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
		let data = fetchedResultsController.objectAtIndexPath(indexPath) as! Course
		//print(data)
		cell.textLabel?.text=data.name
		
		return cell
	}
	//from github iMac239/CoreDataSegueDemo
	func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
		
		switch type {
		case NSFetchedResultsChangeType.Insert:
			tableView.insertSections(NSIndexSet(index: sectionIndex), withRowAnimation: UITableViewRowAnimation.Fade)
			break
		case NSFetchedResultsChangeType.Delete:
			tableView.deleteSections(NSIndexSet(index: sectionIndex), withRowAnimation: UITableViewRowAnimation.Left)
			break
		case NSFetchedResultsChangeType.Move:
			break
		case NSFetchedResultsChangeType.Update:
			break
		default:
			break
		}
	}
	
	override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
		if editingStyle == .Delete {
		}
		
		switch editingStyle {
		case .Delete:
			managedObjectContext?.deleteObject(fetchedResultsController.objectAtIndexPath(indexPath) as! Course)
			managedObjectContext?.save()
		case .Insert:
			break
		case .None:
			break
		}
		
	}
	
	func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
		
		switch type {
		case NSFetchedResultsChangeType.Insert:
			tableView.insertRowsAtIndexPaths(NSArray(object: newIndexPath!) as! [NSIndexPath], withRowAnimation: UITableViewRowAnimation.Fade)
			break
		case NSFetchedResultsChangeType.Delete:
			tableView.deleteRowsAtIndexPaths(NSArray(object: indexPath!) as! [NSIndexPath], withRowAnimation: UITableViewRowAnimation.Left)
			break
		case NSFetchedResultsChangeType.Move:
			tableView.deleteRowsAtIndexPaths(NSArray(object: indexPath!) as! [NSIndexPath], withRowAnimation: UITableViewRowAnimation.Fade)
			tableView.insertRowsAtIndexPaths(NSArray(object: newIndexPath!) as! [NSIndexPath], withRowAnimation: UITableViewRowAnimation.Fade)
			break
		case NSFetchedResultsChangeType.Update:
			tableView.cellForRowAtIndexPath(indexPath!)
			break
		default:
			break
		}
	}
	
	func controllerWillChangeContent(controller: NSFetchedResultsController) {
		tableView.beginUpdates()
	}
	
	func controllerDidChangeContent(controller: NSFetchedResultsController) {
		
		dispatch_async(dispatch_get_main_queue(),{
		self.tableView.endUpdates()
		self.tableView.reloadData()
		})
	}

	let SegueID = "ShowDetail"
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == SegueID {
			//get destination controller
			let destViewController = segue.destinationViewController as! ShowCourseDetail;
			let indexPath = self.tableView?.indexPathForCell(sender as! UITableViewCell)
			let data = fetchedResultsController.objectAtIndexPath(indexPath!) as! Course
			destViewController.data=data
			destViewController.page="syllabus"
		}
		
	}

}

