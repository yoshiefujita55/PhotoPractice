//
//  SecondInputViewController.swift
//  dotbou
//
//  Created by 藤田佳恵 on 2018/02/23.
//  Copyright © 2018年 藤田佳恵. All rights reserved.
//

import UIKit
import Photos
import CoreData

class SecondInputViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    var QuestionImageInput = ""
    var QuestionInput = ""
    var AnswerInput = ""
    
    var input2 = ""
    var timeNomber = ""
    
    @IBOutlet weak var QuestionImage: UIImageView!
    @IBOutlet weak var Question: UITextField!
    @IBOutlet weak var Answer: UITextField!
    @IBAction func Enter(_ sender: UIButton){
        
//      問題を新規作成
        if AnswerInput == ""{
            
        //UserDefaultから取り出す
        // ユーザーデフォルトを用意する
        let myDefault = UserDefaults.standard
        
        // データを取り出す
        let strURL = myDefault.string(forKey: "selectedPhotoURL")
        
        // イメージが選択されていない場合の処理　　　//イメージが選択された場合の処理
        if strURL == nil || strURL == ""{
            QuestionImageInput = "NoImage.jpg"
            }else{
                QuestionImageInput = strURL!
            }
        
        //問題を入力する
        QuestionInput = Question.text!
        
        // 答えが入力されている場合の処理
        if Answer.text != ""{
            AnswerInput = Answer.text!
        }else{
            // 答がカラもしくはスペースの時の処理
            var kara = Answer.text!
            var space = " "
            if Answer.text == "" || kara.contains(space){
                Answer.placeholder = "答えを入力"
            }
        }
        
         // 新規作成をコアデータに保存
        
        print(AnswerInput)
        print(QuestionInput)
        print(QuestionImageInput)
        
        if (AnswerInput != "" && QuestionInput != "") || (AnswerInput != "" && QuestionImageInput != "NoImage.jpg"){
//            if Question.text != QuestionInput || Answer.text != AnswerInput{
            
                    // 問題がカラの時はスペースを入力する処理     //問題が入力されている場合の処理
                    if Question.text == ""{
                        QuestionInput = " "
                    }
                
                    //        AppDelegateのインスタンスを用意しておく
                    let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
                    //        エンティティを操作するためのオブジェクト
                    let viewContext = appDelegate.persistentContainer.viewContext
                    //        Dotappエンティティオブジェクトを作成
                    let Dotbou = NSEntityDescription.entity(forEntityName: "Dotbou", in: viewContext)
                    //        ToDoエンティティにレコード(行)を挿入するためのオブジェクトを作成
                    let newRecord = NSManagedObject(entity: Dotbou!, insertInto: viewContext)
        
                        newRecord.setValue(QuestionInput, forKey: "questionText")
                        newRecord.setValue(AnswerInput, forKey: "questionAnswer")
                        newRecord.setValue(QuestionImageInput, forKey: "questionImage")
                        newRecord.setValue(input2, forKey: "category")
                        newRecord.setValue(Date(), forKey: "timeNow")
            
                        //        レコード(行)の即時保存
                        do{
                            try viewContext.save()
                        }catch{
                        }
                        ///ユーザーデフォルトの削除
                        let userDefaults = UserDefaults.standard
                        userDefaults.removeObject(forKey: "selectedPhotoURL")
                
                        dismiss(animated: false, completion: nil)
            }
        }else{
//          UserDefaultから取り出す
            // ユーザーデフォルトを用意する
            let myDefault = UserDefaults.standard
            
            // データを取り出す
            let strURL = myDefault.string(forKey: "selectedPhotoURL")
            
            // イメージが選択されていない場合の処理　　　//イメージが選択された場合の処理
            if strURL == nil || strURL == ""{
                QuestionImageInput = "NoImage.jpg"
            }else{
                QuestionImageInput = strURL!
            }
            
            //問題を入力する
            QuestionInput = Question.text!
            
            // 答えが入力されている場合の処理
            if Answer.text != ""{
                AnswerInput = Answer.text!
            }else{
                // 答がカラもしくはスペースの時の処理
                var kara = Answer.text!
                var space = " "
                if Answer.text == "" || kara.contains(space){
                    Answer.placeholder = "答えを入力"
                }
            }
            
//            //String型をDate型へ
//            let formatter = DateFormatter()
//            formatter.dateFormat = "yyyy-MM-dd- HH:mm:ss"
//            //Dateにしたい
//            let detastring:Date = formatter.date(from: input3)!
            
//            //データ型をString型へ
//            let formatter = DateFormatter()
//            formatter.dateFormat = "yyyy年MM月dd日 HH:mm:ss"
//            //Stringにしたい
//            let detastring:String = formatter.string(from: timeNow as Date)
            
            // 更新データをコアデータに保存
            
            print(AnswerInput)
            print(QuestionInput)
            print(QuestionImageInput)
           
//            print(detastring)
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy/MM/dd hh:mm:ss"
            let searchDate = dateFormatter.date(from: timeNomber)
            
            print(timeNomber)
            print(searchDate)
            
                let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
                let context:NSManagedObjectContext = appDelegate.persistentContainer.viewContext
                let fetchRequest:NSFetchRequest<Dotbou> = Dotbou.fetchRequest()
                let predicate = NSPredicate(format:"timeNow != %@", searchDate! as CVarArg)
                fetchRequest.predicate = predicate
                let fetchData = try! context.fetch(fetchRequest)
//                if(!fetchData.isEmpty){
                    for i in 0..<fetchData.count{
                        fetchData[i].questionImage = QuestionImageInput
                        fetchData[i].questionText = QuestionInput
                        fetchData[i].questionAnswer = AnswerInput
                    }
                    do{
                        try context.save()
                    }catch{
                    }
//                }
                dismiss(animated: false, completion: nil)
            
                ///ユーザーデフォルトの削除
                let userDefaults = UserDefaults.standard
                userDefaults.removeObject(forKey: "selectedPhotoURL")
        }
            QuestionImageInput = ""
            QuestionInput = ""
            AnswerInput = ""
    }
        
    
    @IBAction func QuestionImageInput(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {    //追記
            
            //写真ライブラリ(カメラロール)表示用のViewControllerを宣言
            let controller = UIImagePickerController()
            
            controller.delegate = self
            //新しく宣言したViewControllerでカメラとカメラロールのどちらを表示するかを指定
            controller.sourceType = UIImagePickerControllerSourceType.photoLibrary
            //トリミング
            controller.allowsEditing = true
            //新たに追加したカメラロール表示ViewControllerをpresentViewControllerにする
            self.present(controller, animated: false, completion: nil)
            //UserDefaultから取り出す
            // ユーザーデフォルトを用意する
            let myDefault = UserDefaults.standard
            
            // データを取り出す
            let strURL = myDefault.string(forKey: "selectedPhotoURL")
            
            
            
            if strURL != nil{
                let url = URL(string: strURL as String!)
                var options:PHImageRequestOptions = PHImageRequestOptions()
                options.deliveryMode = PHImageRequestOptionsDeliveryMode.fastFormat
                let fetchResult: PHFetchResult = PHAsset.fetchAssets(withALAssetURLs: [url!], options: nil)
                let asset: PHAsset = (fetchResult.firstObject! as PHAsset)
                let manager: PHImageManager = PHImageManager()
                manager.requestImage(for: asset,targetSize: PHImageManagerMaximumSize,contentMode: .aspectFill,options: options) { (image, info) -> Void in
                    self.QuestionImage.image = image
                }
            }
        }
    }
    
        //カメラロールで写真を選んだ後
        func imagePickerController(_ imagePicker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
            let assetURL:AnyObject = info[UIImagePickerControllerReferenceURL]! as AnyObject
            let strURL:String = assetURL.description
            print(strURL)
            // ユーザーデフォルトを用意する
            let myDefault = UserDefaults.standard
            // データを書き込んで
            myDefault.set(strURL, forKey: "selectedPhotoURL")
            // 即反映させる
            myDefault.synchronize()
            //閉じる処理
        
        
            if strURL != nil{
                let url = URL(string: strURL as String!)
                var options:PHImageRequestOptions = PHImageRequestOptions()
                options.deliveryMode = PHImageRequestOptionsDeliveryMode.fastFormat
                let fetchResult: PHFetchResult = PHAsset.fetchAssets(withALAssetURLs: [url!], options: nil)
                let asset: PHAsset = (fetchResult.firstObject! as PHAsset)
                let manager: PHImageManager = PHImageManager()
                manager.requestImage(for: asset,targetSize: PHImageManagerMaximumSize,contentMode: .aspectFill,options: options) { (image, info) -> Void in
                    self.QuestionImage.image = image
                }
            }
            imagePicker.dismiss(animated: false, completion: nil)
        }
    
    
    override func viewDidLoad() {
//        
//        QuestionImage.image = QuestionImageInput
        
        Question.text = QuestionInput
        
        Answer.text = AnswerInput
        
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
