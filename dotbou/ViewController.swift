//
//  ViewController.swift
//  dotbou
//
//  Created by 藤田佳恵 on 2018/01/26.
//  Copyright © 2018年 藤田佳恵. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{

    @IBOutlet weak var categoryPicker: UIPickerView!
    
    @IBOutlet weak var myPicker: UIPickerView!
    
//    segueを設定して画面移動
    @IBAction func ListLink(_ sender: UIBarButtonItem) {
         performSegue(withIdentifier: "CategoryLink", sender: nil)
    }
    
    //カテゴリーの値の配列
    var Category = [""]
    //    タイマーの値の配列
    var min = ["180","300","600"]
    //    選択した配列の値
    var targetMin = ""
    
    var targetCategory = ""
    
    override func viewWillAppear(_ animated: Bool) {
        
        read()
        categoryPicker.reloadAllComponents()

    }
    
    //    列数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    //    行数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1{
            return Category.count
        }else{
            return min.count
        }
    }
    //    表示する文字
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1{
            return Category[row]
        }else{
            return min[row]
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
            query.sortDescriptors = [NSSortDescriptor(key: "timeNow",ascending: true)]
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
                                //            Answers.append(Int(answer)!)
                
            }
        }catch{
        }
    }
    
//    PickerViewが選択された時の処理
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1{
        targetCategory = Category[row]
        }else{
        print (min[row])
        targetMin = min[row]
        print (targetMin)
        }
    }
    
//    segueを設定して画面移動
    @IBAction func buttonStart(_ sender: UIButton) {
        performSegue(withIdentifier: "start", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "start"{
            var dvc = segue.destination as! SecondViewController
            if targetMin == nil || targetMin == "" {
                targetMin = min[0]
            }
            dvc.takeTime = targetMin
            
            if targetCategory == nil || targetCategory == ""{
                targetCategory = Category[0]
            }
            dvc.takeCategory = targetCategory
            }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func viewDidLoad() {
        
        read()
        
        categoryPicker.delegate = self
        categoryPicker.dataSource = self
        myPicker.delegate = self
        myPicker.dataSource = self
        
        categoryPicker.selectedRow(inComponent: 0)
        
        
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
}

