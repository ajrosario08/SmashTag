//
//  TweetTableViewController.swift
//  SmashTag
//
//  Created by Anthony Rosario on 11/15/15.
//  Copyright © 2015 Anthony Rosario. All rights reserved.
//

import UIKit

class TweetTableViewController: UITableViewController {

    var tweets = [[Tweet]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let request = TwitterRequest(search: "#stanford", count: 100)
        request.fetchTweets { (newTweets) -> Void in
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                if newTweets.count > 0 {
                    self.tweets.insert(newTweets, atIndex: 0)
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return tweets.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets[section].count
    }
    
    private struct Storyboard {
        static let CellReuseIdentifier = "Tweet"
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.CellReuseIdentifier, forIndexPath: indexPath) as UITableViewCell
        
        
        let tweet = tweets[indexPath.section][indexPath.row]
        cell.textLabel?.text = tweet.text
        cell.detailTextLabel?.text = tweet.user.name
        
        return cell
    }
    
}
