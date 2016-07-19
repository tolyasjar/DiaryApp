//
//  PostListingTableViewController.swift
//  Diary_App
//
//  Created by Toleen Jaradat on 7/19/16.
//  Copyright © 2016 Toleen Jaradat. All rights reserved.
//

import UIKit
import CoreData

class PostListingTableViewController: UITableViewController, AddingNewPost, NSFetchedResultsControllerDelegate {
    
    var managedObjectContext :NSManagedObjectContext!
    
    var fetchedResultsController :NSFetchedResultsController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController!.navigationBar.barTintColor = UIColor.blueColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        let fetchRequest = NSFetchRequest(entityName: "Post")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        self.fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        self.fetchedResultsController.delegate = self
        
        try! self.fetchedResultsController.performFetch()
    
    }
    
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        
        switch(type) {
            
        case .Insert:
            self.tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Automatic)
            break
            
        case .Delete:
            self.tableView.deleteRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Automatic)
            break
            
        case .Update:
            break
            
        case .Move:
            break
            
        }
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func addNewPostDidSave(enteredPost: String) {
        
    print("Firing the delegate")
        
         let post = NSEntityDescription.insertNewObjectForEntityForName("Post", inManagedObjectContext: self.managedObjectContext)
        
        post.setValue(enteredPost, forKey: "title")
        
        try! self.managedObjectContext.save()

        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
            let addNewPostViewController: AddNewPostViewController = segue.destinationViewController as! AddNewPostViewController
            
            addNewPostViewController.addingNewPostdelegate = self
        
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let sections = self.fetchedResultsController.sections else {
            fatalError("")
        }
        
        return sections[section].numberOfObjects
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let post = self.fetchedResultsController.objectAtIndexPath(indexPath)

        cell.textLabel?.text = post.valueForKey("title") as? String
        
        return cell
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            print("Should Delete the row")

            // remove the deleted item from the `UITableView`
            //self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
            
            return
        }
    }

}
