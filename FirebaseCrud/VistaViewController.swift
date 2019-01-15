//
//  VistaViewController.swift
//  FirebaseCrud
//
//  Created by Tecnova on 1/14/19.
//  Copyright © 2019 Gabriel Soto Valenzuela. All rights reserved.
//

import UIKit
import FirebaseDatabase

class VistaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{

    @IBOutlet weak var control: UISegmentedControl!
    @IBOutlet weak var tabla: UITableView!
    
    var listaJuegos = [Juegos]()
    var ref: DatabaseReference!
    var handle: DatabaseHandle!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        tabla.delegate = self
        tabla.dataSource = self
        
        ref = Database.database().reference()
        
        plataformas(plat: "PLAYSTATION 4")
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaJuegos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tabla.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let juego : Juegos
        
        juego = listaJuegos[indexPath.row]
        cell.textLabel?.text = juego.nombre
        cell.detailTextLabel?.text = juego.genero
        
        return cell
    }
    
    func plataformas(plat: String)
    {
        handle = ref.child(plat).observe(DataEventType.value, with: { (snapshot) in
            self.listaJuegos.removeAll()
            
            for item in snapshot.children.allObjects as! [DataSnapshot]
            {
                let valores = item.value as! [String:AnyObject]
                
                let nombre = valores["nombre"] as? String
                let genero = valores["genero"] as? String
                
                let juegos = Juegos(nombre: nombre, genero: genero)
                self.listaJuegos.append(juegos)
                
            }
            self.tabla.reloadData()
        })
    
    }

    @IBAction func atras(_ sender: UIBarButtonItem)
    {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func controlButton(_ sender: Any)
    {
        if control.selectedSegmentIndex == 0{
            plataformas(plat: "PLAYSTATION 4")
        }else if control.selectedSegmentIndex == 1{
            plataformas(plat: "XBOX ONE")
        }else if control.selectedSegmentIndex == 2{
            plataformas(plat: "NINTENDO SWITCH")
        }else {
            plataformas(plat: "PC")
        }

    }
}
