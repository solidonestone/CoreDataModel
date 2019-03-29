//
//  ViewController.swift
//  CoreDataModel
//
//  Created by 宋璞 on 2019/3/29.
//  Copyright © 2019 宋璞. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mTableView: UITableView!
    @IBOutlet weak var mNameTF: UITextField!
    @IBOutlet weak var mAgeTF: UITextField!
    
    private let cellId = "cellID"
    var selPerson = Person(){
        didSet{
            mNameTF.text = selPerson.name
            mAgeTF.text = "\(selPerson.age)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableViewUI()
        
        getAllPerson()
    }
    
    // MARK: - UI ⚡️
    private func tableViewUI(){
        mTableView.register(UINib.init(nibName: "BasePersonCell", bundle: nil), forCellReuseIdentifier: cellId)
        mTableView.tableFooterView = UIView()
    }
    

    // MARK: - Method ⚡️
    private func addPerson(name: String, age: Int16) {
        CoreDataManager.shared.savePersonWith(name: name, age: age)
        getAllPerson()
    }
    
    private func delPerson(name: String) {
        CoreDataManager.shared.deleteWith(name: name);
        searchPerson(name: searchStr)
    }
    
    private func changePerson(name: String, newName: String, newAge: Int16){
        CoreDataManager.shared.changePersonWith(name: name, newName: newName, newAge: newAge)
        searchPerson(name: searchStr)
    }
    
    private func searchPerson(name: String) {
        if name.count == 0 {
            getAllPerson()
        } else {
            dataSource = CoreDataManager.shared.getPersonWith(name: name)
            mTableView.reloadData()
        }
    }
    
    private func getAllPerson(){
        dataSource = CoreDataManager.shared.getAllPerson()
        mTableView.reloadData()
    }
    
    

    // MARK: - Action ⚡️
    @IBAction func addBtnClick(_ sender: Any) {
        
        let count = mNameTF.text?.count
        if count! >= 0 {
            print("> 0")
        } else {
            print("< 0")
        }
        
        guard (mNameTF.text?.count)! > 0 else {
            return
        }
        addPerson(name: mNameTF.text!, age: Int16(mAgeTF.text!)!)
    }
    
    @IBAction func chageBtnClick(_ sender: Any) {
        guard (mNameTF.text?.count)! > 0 else {
            return
        }
        
        changePerson(name: selPerson.name!, newName: mNameTF.text!, newAge: Int16(mAgeTF.text!)!)
    }
    
    @IBAction func deleteBtnClick(_ sender: Any) {
        guard (mNameTF.text?.count)! > 0 else {
            return
        }
        
        delPerson(name: mNameTF.text!)
        mNameTF.text = nil
        mAgeTF.text = nil
    }
    
    @IBAction func findBtnClick(_ sender: Any) {
        searchPerson(name: mNameTF.text!)
    }
    
    // MARK: - Lazy ⚡️
    private lazy var dataSource : [Person] = {
        let dataSource = [Person]()
        
        return dataSource
    }()
    
    private lazy var searchStr : String = {
        let searchStr = String()
        
        return searchStr
    }()
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! BasePersonCell
        
        cell.person = dataSource[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selPerson = dataSource[indexPath.row]
    }
}
