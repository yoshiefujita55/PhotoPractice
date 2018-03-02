//
//  TableViewController.swift
//  dotbou
//
//  Created by 藤田佳恵 on 2018/02/23.
//  Copyright © 2018年 藤田佳恵. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBAction func newInput(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "InputStart", sender: nil)
//        let storyboard:UIStoryboard = self.storyboard!
//        let nextview = storyboard.instantiateViewController(withIdentifier: "newCategory")
//        present(nextview, animated: false, completion: nil)
    }
    
    
    var category = ["dotbou1","dotbou2","dotbou3"]
    
//    行数を指定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category.count
    }
    
//    値を表示
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        print(indexPath.row)
        cell.textLabel?.text = category[indexPath.row] 
        return cell
    }

//    TableViewの値の選択
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "InputStart", sender: indexPath.row)
    }
    
//    データの移動
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "InputStart"{
            if sender != nil{
                let guest = segue.destination as!InputViewController
                guest.input = category[sender! as!Int]
                }else{
                    let guest = segue.destination as!InputViewController
                    guest.input = ""
                    }
        }
    }

    
    override func viewDidLoad() {
        
      
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
