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
	var ListArray: NSArray = ["Hello world", "Swift", "UITableView", "媽!我在這裡"]

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
		print("hello")
		var error:NSError? = nil
		let fetchRequest = NSFetchRequest(entityName: "Course")
		let sortDescriptor = NSSortDescriptor(key: "cid", ascending: true)
		fetchRequest.sortDescriptors = [sortDescriptor]
		fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
		fetchedResultsController.performFetch(&error)
		self.courselist.reloadData()
		
	}
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		print("numberOfSections:")
		//print(fetchedResultsController.sections!.count)
		print("\n")
		return fetchedResultsController.sections!.count
	}
	func tableView(tableView: UITableView, numberOfRowsInSection section:Int) -> Int {
		let sectionInfo = fetchedResultsController.sections![section] as! NSFetchedResultsSectionInfo
		print("numberOfObjects")
		//print(sectionInfo.numberOfObjects)
		print("\n")
		return sectionInfo.numberOfObjects
	}
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
		let data: AnyObject = fetchedResultsController.objectAtIndexPath(indexPath)
		print(data)
		cell.textLabel?.text=data.name
		
		return cell
	}

	/*
	func tableView(tableView: UITableView!, numberOfRowsInSection section:Int) -> Int {

		return ListArray.count

	}

	

	//填充UITableViewCell中文字標簽的值

	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

		let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")

		cell.textLabel!.text = "\(ListArray.objectAtIndex(indexPath.row))"
		return cell
	}
*/


}

