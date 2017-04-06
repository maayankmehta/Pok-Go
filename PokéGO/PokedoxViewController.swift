//
//  PokedoxViewController.swift
//  PokéGO
//
//  Created by Mayank Mehta on 06/04/17.
//  Copyright © 2017 Mayank Mehta. All rights reserved.
//

import UIKit

class PokedoxViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    

    @IBOutlet weak var tableView: UITableView!
    @IBAction func backToMapButton(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    var caughtPokemon : [Pokemon] = []
    var uncaughtPokemon : [Pokemon] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        caughtPokemon = getAllCaughtPokemon()
        uncaughtPokemon = getAllUncaughtPokemon()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    
    //tableview functions
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Caught Pokemon"
        } else {
            return "Uncaught Pokemon"
        }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if section == 0 {
            return caughtPokemon.count
        }else {
            return uncaughtPokemon.count
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        var pokemon : Pokemon
        
        if indexPath.section == 0{
            pokemon = self.caughtPokemon[indexPath.row]
        }else{
            pokemon = self.uncaughtPokemon[indexPath.row]
        }
        
        cell.textLabel?.text = pokemon.name
        cell.imageView?.image = UIImage(named: pokemon.imageFileName!)
        return cell
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
