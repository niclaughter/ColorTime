//
//  ColorListTableViewController.swift
//  ColorTime
//
//  Created by Nicholas Laughter on 6/27/16.
//  Copyright © 2016 Nicholas Laughter. All rights reserved.
//

import UIKit
import CoreData

class ColorListTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    var fetchedResultsController: NSFetchedResultsController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpFetchedResultsController()
    }
    
    @IBAction func addButtonTapped(sender: AnyObject) {
        ColorController.shared.createColor()
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = fetchedResultsController?.sections else { return 0 }
        let sectionInfo = sections[section]
        return sectionInfo.numberOfObjects
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("colorCell", forIndexPath: indexPath)
        if let color = fetchedResultsController?.objectAtIndexPath(indexPath) as? Color {
            cell.backgroundColor = color.color
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            guard let color = fetchedResultsController?.objectAtIndexPath(indexPath) as? Color else { return }
            ColorController.shared.deleteColor(color)
        }
    }
 
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let indexPath = tableView.indexPathForSelectedRow,
            color = fetchedResultsController?.objectAtIndexPath(indexPath) as? Color,
            destinationVC = segue.destinationViewController as? ColorDetailViewController else { return }
        destinationVC.color = color
    }
    
    // MARK: - NSFetchedResultsControllerDelegate
    
    func setUpFetchedResultsController() {
        let request = NSFetchRequest(entityName: Color.typeKey)
        let sortDescriptor = NSSortDescriptor(key: Color.timestampKey, ascending: false)
        request.returnsObjectsAsFaults = false
        request.sortDescriptors = [sortDescriptor]
        self.fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: Stack.sharedStack.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        do {
            try fetchedResultsController?.performFetch()
        } catch let error as NSError {
            print("Unable to perform fetch request = \(error.localizedDescription)")
        }
        fetchedResultsController?.delegate = self
    }
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        switch type {
        case .Delete:
            tableView.deleteSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Automatic)
        case .Insert:
            tableView.insertSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Automatic)
        default:
            break
        }
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case .Delete:
            guard let indexPath = indexPath else {return}
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        case .Insert:
            guard let newIndexPath = newIndexPath else {return}
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Automatic)
        case .Move:
            guard let indexPath = indexPath,
                newIndexPath = newIndexPath else {return}
            tableView.moveRowAtIndexPath(indexPath, toIndexPath: newIndexPath)
        case .Update:
            guard let indexPath = indexPath else {return}
            tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }
}