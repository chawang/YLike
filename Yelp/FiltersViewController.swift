//
//  FiltersViewController.swift
//  YLike
//
//  Created by Charles Wang on 10/23/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol FiltersViewControllerDelegate{
    @objc optional func filtersViewController(filtersViewController: FiltersViewController, didUpdateFilters filters: [String:AnyObject])
}

class FiltersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SwitchCellDelegate {

    @IBOutlet weak var tableView: UITableView!
    var categories: [[String:String]]!
    var switchState = [Int:Bool]()
    var filters = Filters()
    
    weak var delegate: FiltersViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categories = yelpCategories()
        
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SwitchCell", for: indexPath) as! SwitchCell
        
        cell.categoryLabel.text = categories[indexPath.row]["name"]
        cell.delegate = self
        
        cell.categorySwitch.isOn = switchState[indexPath.row] ?? false
        
        return cell
    }
    
    func switchCell(switchCell: SwitchCell, didChangeValue value: Bool) {
        let indexPath = tableView.indexPath(for: switchCell)!
        switchState[indexPath.row] = value
    }
    
    @IBAction func onCancelButton(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onSearchButton(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
        
        var filters = [String:AnyObject]()
        var selectedCats = [String]()
        
        for (row, isSelected) in switchState {
            if isSelected {
                selectedCats.append(categories[row]["code"]!)
            }
        }
        
        if selectedCats.count > 0 {
            filters["categories"] = selectedCats as AnyObject?
        }
        
        delegate?.filtersViewController?(filtersViewController: self, didUpdateFilters: filters)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let width = UIScreen.main.bounds.size.width
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 50))
        headerView.backgroundColor = UIColor(red:1.00, green:0.97, blue:0.96, alpha:1.0)
        
        
        return headerView
    }
    
    func yelpCategories() -> [[String:String]] {
        return [["name" : "Afghan", "code" : "afghani"],
        ["name" : "American", "code" : "newamerican"],
        ["name" : "Arabian", "code" : "arabian"],
        ["name" : "Burgers", "code" : "burgers"],
        ["name" : "Dumplings", "code" : "dumplings"],
        ["name" : "Hot Pot", "code" : "hotpot"],
        ["name" : "Korean", "code" : "korean"],
        ["name" : "Pizza", "code" : "pizza"],
        ["name" : "Taiwanese", "code" : "taiwanese"],
        ["name" : "Vegetarian", "code" : "vegetarian"],
        ["name" : "Vietnamese", "code" : "vietnamese"]]
    }
}
