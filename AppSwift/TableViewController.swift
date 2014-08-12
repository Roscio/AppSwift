//
//  TableViewController.swift
//  AppSwift
//
//  Created by Giulio Roscigno on 12/08/14.
//  Copyright (c) 2014 Roscigno. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, NSXMLParserDelegate {

    var parser = NSXMLParser ()
    var feeds = NSMutableArray ()
    var elements = NSMutableDictionary ()
    var element = NSString ()
    var ftitle = NSMutableString ()
    var link = NSMutableString ()
    var fdescription = NSMutableString()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.rowHeight = 70
        feeds = []
        var url: NSURL = NSURL.URLWithString ("http://www.formula1.com/rss/news/features.rss")
        parser = NSXMLParser (contentsOfURL: url)
        parser.delegate = self
        parser.shouldProcessNamespaces = false
        parser.shouldReportNamespacePrefixes = false
        parser.shouldResolveExternalEntities = false
        parser.parse()
        
    }
    
    func parser(parser: NSXMLParser!, didStartElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!, attributes attributeDict: [NSObject : AnyObject]!) {
    
    element = elementName
    
    if (element as NSString).isEqualToString("item") {
        elements = NSMutableDictionary.alloc()
        elements = [:]
        ftitle = NSMutableString.alloc ()
        ftitle = ""
        link = NSMutableString.alloc()
        link = ""
        fdescription = NSMutableString.alloc()
        fdescription = ""
        
        
        }
        
    }

    func parser(parser: NSXMLParser!, didEndElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!) {
    
       if (elementName as NSString).isEqualToString("item") {
       if ftitle != nil {
        elements.setObject(ftitle, forKey: "title")
        
     }
        
       if link != nil {
       elements.setObject(link, forKey: "link")
        
      }
        
        if fdescription != nil {
        elements.setObject(fdescription, forKey: "description")
            
      }

        feeds.addObject(elements)
        
    }
    
    func parser(parser: NSXMLParser!, foundCharacters string: String!) {
       
        
     if element.isEqualToString("title"){
        ftitle.appendString(string)
        
     }   else if  element.isEqualToString("link"){
        link.appendString(string)
        
     }   else if element.isEqualToString("description"){
         fdescription.appendString(string)
        
     }
    
    }
    
    func parserDidEndDocument(parser: NSXMLParser!) {
        self.tableView.reloadData()
   
    }
        }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    
    }

    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return feeds.count
    }

    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell

       
      cell.textLabel.text = feeds.objectAtIndex(indexPath.row).objectForKey ("title") as String
      cell.detailTextLabel.numberOfLines = 3
      cell.detailTextLabel.text = feeds.objectAtIndex(indexPath.row).objectForKey("description") as String
        
        return cell
    }
       
}
