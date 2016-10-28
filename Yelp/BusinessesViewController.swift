//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, FiltersViewControllerDelegate {
    
    var businesses: [Business]!
    var searchedBusinesses : [Business]!
    private var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        Business.searchWithTerm(term: "Thai", completion: { (businesses: [Business]?, error: Error?) -> Void in
            self.businesses = businesses
            self.searchedBusinesses = businesses
            self.tableView.reloadData()
            
            if let businesses = businesses {
                    for business in businesses {
                        print(business.name!)
                        print(business.address!)
                    }
                }
            }
        )
        
        /* Example of Yelp search with more search options specified
         Business.searchWithTerm("Restaurants", sort: .Distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]!, error: NSError!) -> Void in
         self.businesses = businesses
         
         for business in businesses {
         print(business.name!)
         print(business.address!)
         }
         }
         */
        
        searchBar = UISearchBar()
//        searchBar.backgroundImage = UIImage()
//        searchBar.sizeToFit()
        searchBar.placeholder = "Restaurants"
        searchBar.delegate = self
        navigationItem.titleView = searchBar

        definesPresentationContext = true
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedBusinesses?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessCell", for: indexPath) as! BusinessCell
        
        cell.business = searchedBusinesses[indexPath.row]
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func filtersViewController(filtersViewController: FiltersViewController, didUpdateFilters filters: [String : AnyObject]) {
        
        let cats = filters["categories"] as? [String]
        
        Business.searchWithTerm(term: "Restaurants", sort: nil, categories: cats, deals: false, completion: {(businesses: [Business]?, error: Error?) -> Void in
                self.businesses = businesses
                self.searchedBusinesses = businesses
                self.tableView.reloadData()
            }
        )
    }
    
    @objc(searchBar:textDidChange:) func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchedBusinesses = searchText.isEmpty ? businesses : businesses.filter({($0.name?.lowercased().contains(searchText.lowercased()))!
        })
        self.tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchedBusinesses = businesses
        searchBar.resignFirstResponder()
        self.tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
        self.tableView.reloadData()
    }
   
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navController = segue.destination as! UINavigationController
        let filtersViewController = navController.topViewController as! FiltersViewController
        
        filtersViewController.delegate = self
    }
}
