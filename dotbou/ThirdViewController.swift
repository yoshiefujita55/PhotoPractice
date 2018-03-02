//
//  ThirdViewController.swift
//  dotbou
//
//  Created by 藤田佳恵 on 2018/02/02.
//  Copyright © 2018年 藤田佳恵. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//      segueを使わない画面移動
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
              self.performSegue(withIdentifier: "backStart", sender: nil)
        }
        
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
