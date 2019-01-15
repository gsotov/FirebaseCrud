//
//  Celda.swift
//  FirebaseCrud
//
//  Created by Tecnova on 1/15/19.
//  Copyright © 2019 Gabriel Soto Valenzuela. All rights reserved.
//

import UIKit

class Celda: UITableViewCell {

    
    @IBOutlet weak var imagenFirebase: UIImageView!
    @IBOutlet weak var nombreFirebase: UILabel!
    @IBOutlet weak var generoFirebase: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
