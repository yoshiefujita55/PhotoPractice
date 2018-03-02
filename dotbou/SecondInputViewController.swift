//
//  SecondInputViewController.swift
//  dotbou
//
//  Created by 藤田佳恵 on 2018/02/23.
//  Copyright © 2018年 藤田佳恵. All rights reserved.
//

import UIKit
import Photos

class SecondInputViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

//    var QuestionImageInput = ""
    var QuestionInput = ""
    var AnswerInput = ""
    
    @IBOutlet weak var QuestionImage: UIImageView!
    @IBOutlet weak var Question: UITextField!
    @IBOutlet weak var Answer: UITextField!
    @IBAction func Enter(_ sender: UIButton) {
        dismiss(animated: false, completion: nil)
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
        
//        QuestionImage.text = QuestionImageInput
        
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
