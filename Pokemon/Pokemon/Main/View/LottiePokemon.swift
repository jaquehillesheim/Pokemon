//
//  LottiePokemon.swift
//  Pokemon
//
//  Created by Jaqueline Hillesheim on 11/01/23.
//

import Foundation
import Lottie

class LottiePokemon: ViewController {
    
    private var animationView: LottieAnimationView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animationView = .init(name: "Pokemon")
        animationView?.frame = view.bounds
        animationView?.contentMode = .scaleAspectFill
        animationView?.loopMode = .loop
        animationView?.animationSpeed = 0.5
        view.addSubview(animationView!)
        animationView!.play()
    }
}
