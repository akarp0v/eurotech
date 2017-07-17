//
//  MenuTableVC.swift
//  Eurotech
//
//  Created by Артем Карпов on 10.07.17.
//  Copyright © 2017 Артем Карпов. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import RealmSwift

class MenuTableVC: UITableViewController {
    
    var menuList: [Menu] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //let realm = try! Realm()
        let url = "http://shop.eurotechservice.ru/jmenu.php"
        //var cityName: String = ""
        Alamofire.request(url).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
//                print("json: \(json)")
//                for object in json.arrayValue {
//                    let menu object.dictionaryObject
//                    let menu = Menu.makeMenu(fromDictionary: object.dictionaryObject)
//                }
//                [1, 2, 3, nil, 5].flatMap({ (number) -> Int? in
//                    guard let n = number else {
//                        return nil
//                    }
//                    print(n)
//                    return n*2
//                    if let n = number {
//                        return n*2
//                    }
//                    return nil
//                })
//                .none
                let result = json.arrayValue.flatMap({ (object) -> Menu? in
                    return Menu.makeMenu(fromDictionary: object.dictionaryObject)
                })
                self.menuList = result
                self.tableView.reloadData()
                //print("result: \(result)")
                
                //let onlineWeather = WeatherData()
                //onlineWeather.city_name = json["city"]["name"].stringValue
                //print("City2: \(cityName)")
                //                try! realm.write {
                //                    realm.add(onlineWeather)
                //                }
                
            case .failure(let error):
                print(error)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UITableViewDelegate
    
    override public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //let item = menuList[indexPath.section].subMenu?[indexPath.row]
        //navigationController?.pushViewController(ListCollectionVC(item), animated: true)
       // let viewContr = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ident")
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mySegue" ,
            let nextVC = segue.destination as? GoodsCollectionVC,
            let indexPath = self.tableView.indexPathForSelectedRow {
                let item = menuList[indexPath.section].subMenu?[indexPath.row]
                nextVC.item = item
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return menuList.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return menuList[section].subMenu?.count ?? 0
    }

    public override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return menuList[section].title
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let item = menuList[indexPath.section]
        //cell.textLabel?.text = item.subMenu?[indexPath.row]["title"] as? String
        
       
        cell.textLabel?.text = item.subMenu?[indexPath.row].title
        //print(result)

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
