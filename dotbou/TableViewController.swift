//
//  TableViewController.swift
//  dotbou
//
//  Created by 藤田佳恵 on 2018/02/23.
//  Copyright © 2018年 藤田佳恵. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBAction func newInput(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "InputStart", sender: nil)
    }
    
    @IBOutlet weak var CategoryView: UITableView!
    
    var Category = ["dotbou1","dotbou2","dotbou3"]
    
//    行数を指定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Category.count
    }
    
//    値を表示
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        print(indexPath.row)
        cell.textLabel?.text = Category[indexPath.row]
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
                guest.input = Category[sender! as!Int]
                }else{
                    let guest = segue.destination as!InputViewController
                    guest.input = ""
                    }
        }
    }

    //    データを取ります。
    func read(){
        //        カラの配列を用意します。
        Category = []
        //        AppDelegateを使う準備
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        //        エンティティを操作するためのオブジェクト
        let viewContext = appDelegate.persistentContainer.viewContext
        //        どのエンティティからデータを取得してくるか設定
        let query: NSFetchRequest<Dotbou> = Dotbou.fetchRequest()
        
        do{
            query.sortDescriptors = [NSSortDescriptor(key: "timeNow",ascending: false)]
            //            データを一括取得
            let fetchResults = try viewContext.fetch(query)
            //            データの取得
            for result: AnyObject in fetchResults {
                let text: String! = result.value(forKey: "questionText") as! String
                let IMG: String! = result.value(forKey: "questionImage") as! String
                let answer: String! = result.value(forKey: "questionAnswer") as! String
                let category:String!  = result.value(forKey: "category") as! String
                //            データの追加
                if Category.index(of: category) != nil{
                    print(Category)
                }else{
                    Category.append(category)
                }
            }
        }catch{
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        read()
        
        self.CategoryView.reloadData()
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
