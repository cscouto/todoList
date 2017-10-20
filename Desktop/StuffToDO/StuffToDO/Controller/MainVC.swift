//
//  MainVC.swift
//  StuffToDO
//
//  Created by Couto on 10/20/17.
//  Copyright © 2017 coutocode. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    //outlets
    @IBOutlet var dueTodayTable: UITableView!
    @IBOutlet var fiveDayTable: UITableView!
    @IBOutlet var mainTable: UITableView!
    @IBOutlet var dueTodayCount: UILabel!
    @IBOutlet var dueFiveDaysCount: UILabel!
    
    //vars
    var todoDueToday:[ToDos] = []
    var todos:[ToDos] = []
    var todoFiveDay:[ToDos] = []
    
    //syste
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //88, 101, 167
        navigationController?.navigationBar.barTintColor = UIColor(red: 88/255, green: 101/255, blue: 167/255, alpha: 1.0)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        
        dueTodayTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        fiveDayTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshData()
    }
    
    //custom functions
    func refreshData(){
        todos = CoreDataManager.getData(entityName: "ToDos") as! [ToDos]
        todoDueToday = CoreDataManager.getData(entityName: "ToDos", predicate: NSPredicate(format:"dueDate<=%@", (NSDate()))) as! [ToDos]
        
        var dayComponent = DateComponents()
        dayComponent.day = 5
        let theCalendar = NSCalendar.current
        let nextDate = theCalendar.date(byAdding: dayComponent, to: Date())
        todoFiveDay = CoreDataManager.getData(entityName: "ToDos", predicate: NSPredicate(format:"dueDate<%@", (nextDate)! as CVarArg)) as! [ToDos]
        
        dueTodayTable.reloadData()
        fiveDayTable.reloadData()
        mainTable.reloadData()
    }
    func formatDate(date:NSDate) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM/dd"
        return dateFormatter.string(from: date as Date)
    }
}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView == dueTodayTable){
            dueTodayCount.text = String(todoDueToday.count)
            return todoDueToday.count
        }
        else if (tableView == fiveDayTable){
            dueFiveDaysCount.text = String(todoFiveDay.count)
            return todoFiveDay.count
        }
        else {
            return todos.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(tableView == dueTodayTable){
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            let todo = todoDueToday[indexPath.row]
            cell.textLabel!.text = String(format: "%@: %@", todo.todoItem!, formatDate(date: todo.dueDate!))
            return cell
        }
        else if (tableView == fiveDayTable){
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            let todo = todoFiveDay[indexPath.row]
            cell.textLabel!.text = String(format: "%@: %@", todo.todoItem!, formatDate(date: todo.dueDate!))
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
            let todo = todos[indexPath.row]
            cell.todoItem.text = String(format: "%@: %@", todo.todoItem!, formatDate(date: todo.dueDate!))
            cell.checkbox.text = "⬜️"
            if(todo.complete == true){
                cell.checkbox.text = "✅"
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if (tableView.isEqual(mainTable)){
            let todo = todos[indexPath.row]
            let cell = tableView.cellForRow(at: indexPath) as! TableViewCell
            if (cell.checkbox.text == "✅"){
                cell.checkbox.text = "⬜️"
                todo.complete = false
            }
            else {
                cell.checkbox.text = "✅"
                todo.complete = true
            }
            
            CoreDataManager.update(todoItem: todo)
        }
        
        return indexPath
    }
}
