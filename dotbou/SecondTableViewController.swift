//
//  SecondTableViewController.swift
//  dotbou
//
//  Created by 藤田佳恵 on 2018/02/23.
//  Copyright © 2018年 藤田佳恵. All rights reserved.
//

import UIKit
import CoreData

class SecondTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBAction func secondNewInput(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "SecondInputStart", sender: nil)
//        let storyboard:UIStoryboard = self.storyboard!
//        let nextview = storyboard.instantiateViewController(withIdentifier: "secondNewCategory")
//        present(nextview, animated: false, completion: nil)
    }
    
    @IBOutlet weak var questionView: UITableView!
    
    //  変数名
    var QuestionText = ["１６をひくと、残りは？","①左と右の数を合体すると？","８をひくと、残りは？","４３をひくと、残りは？","②左と右の数を合体すると？","③左と右の数を合体すると？","④左と右の数を合体すると？","２００をひくと？","２４４をひくと？","ぜんぶでいくつ？"]
    
    var Answers = [18,34,66,29,33,82,95,20,78,407]
    
    var input1 = ""
    
    
    
//    行数を指定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return QuestionText.count
    }
    
//    値を表示
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        print(indexPath.row)
        cell.textLabel?.text = QuestionText[indexPath.row]
        return cell
    }
    
    //    TableViewの値の選択
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "SecondInputStart", sender: indexPath.row)
    }
    
    //    データの移動
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let guest = segue.destination as!SecondInputViewController
//        guest.QuestionInput = question[sender! as!Int]
        if segue.identifier == "SecondInputStart"{
            if sender != nil{
                let guest = segue.destination as!SecondInputViewController
                guest.QuestionInput = QuestionText[sender! as!Int]
                guest.AnswerInput = String(Answers[sender! as!Int])
                guest.input2 = input1
            }else{
                let guest = segue.destination as!SecondInputViewController
                guest.QuestionInput = ""
                guest.AnswerInput = ""
                guest.input2 = input1
            }
            
        }
    }
    
    //    データを取ります。
    func read(){
        //        カラの配列を用意します。
        
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
            QuestionText.append(text)
//            Answers.append(Int(answer)!)
            }
        }catch{
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        questionView.reloadData()
        
        read()
        
        
//        var a = "hyouji"
//        print(input1 + a)

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
