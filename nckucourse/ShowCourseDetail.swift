//
//  ShowCourseDetail.swift
//  nckucourse
//
//  Created by Lee Yu Hsun on 2015/7/13.
//  Copyright (c) 2015年 Lee Yu Hsun. All rights reserved.
//

import UIKit

class ShowCourseDetail: UIViewController , UIWebViewDelegate {
	var data: Course?
	var page: String=""
	var url : NSURL?
	//var externalWindow: UIWindow!
	//var extrenalwebview :UIWebView!
	@IBOutlet weak var webview: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
		
		//print(data)
		//let screens = UIScreen.screens()
		//if screens.count > 1 {
		//	self.initializeExternalScreen(screens[1] as! UIScreen)
		//}
		
		switch page {
		case "syllabus" :
			self.title = data!.name
			var syear = data!.syear
			var sem = data!.sem
			var courseid = data!.cid
			var cclass = data!.cclass
			url = NSURL(string: "http://class-qry.acad.ncku.edu.tw/syllabus/online_display.php?syear="+syear+"&sem="+sem+"&co_no="+courseid+"&class_code="+cclass)
			break
			
		case "coursesearch" :
			self.title = "國立成功大學課程查詢系統"
			url = NSURL(string: "http://course-query.acad.ncku.edu.tw/qry/index.php?lang=zh_tw")
			break
			
		case "homepage" :
			self.title = "國立成功大學"
			url = NSURL(string: "http://www.ncku.edu.tw")
			break
			
		case "incku" :
			self.title = "成功入口"
			url = NSURL(string: "http://i.ncku.edu.tw")
			break
			
		case "report" :
			self.title = "問題回報"
			url = NSURL(string: "https://docs.google.com/forms/d/1BzZjjQ5EjcPH72uMBWf01rePPQnyJXhSbEBAcTm99TA/viewform?usp=send_form")
			break
			
		case "about" :
			self.title = "關於"
			url = NSURL(string: "http://andylee830914.github.io/nckucourse/")
			break
			
		default :
			self.title = "國立成功大學"
			url = NSURL(string: "http://www.ncku.edu.tw")
			break
			
			
			
		}
		let requestObj = NSURLRequest(URL: url!)
		webview.delegate = self
		webview.loadRequest(requestObj)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	func webViewDidStartLoad(webView: UIWebView) {
		UIApplication.sharedApplication().networkActivityIndicatorVisible = true
	}
	
	func webViewDidFinishLoad(webView: UIWebView) {
		UIApplication.sharedApplication().networkActivityIndicatorVisible = false
	}

	@IBAction func share(sender: UIBarButtonItem) {
		//UIApplication.sharedApplication().openURL(self.url!)
			
			if let myWebsite = self.url
			{
				let objectsToShare = [myWebsite]
				let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
				
				self.presentViewController(activityVC, animated: true, completion: nil)
			}
		
	}
	
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
	/*
	
	    // Initialize an external screen
	    func initializeExternalScreen(externalScreen: UIScreen) {
	
	        // Create a new window sized to the external screen's bounds
	        self.externalWindow = UIWindow(frame: externalScreen.bounds)
	
	        // Assign the screen object to the screen property of the new window
	        self.externalWindow.screen = externalScreen;
	
	        // Configure the MapView
	        var view = UIView(frame: self.externalWindow.frame)
			let screens = UIScreen.screens()
			let ext = screens[1] as! UIScreen
			self.extrenalwebview = UIWebView(frame: CGRectMake(0, 0, ext.bounds.width, ext.bounds.height))
			self.extrenalwebview.scalesPageToFit = true
			url = NSURL(string: "http://web.ncku.edu.tw/bin/home.php")
			let requestObj = NSURLRequest(URL: url!)
			
			view.addSubview(self.extrenalwebview!)
			self.extrenalwebview.delegate = self
			self.extrenalwebview.loadRequest(requestObj)
	        self.externalWindow.addSubview(view)
			
	        // Make the window visible
	        self.externalWindow.makeKeyAndVisible()
	
	        // Zoom in on the map in the external display
	    }
	
	*/


}
