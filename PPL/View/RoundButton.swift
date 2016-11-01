//
//  RoundButton.swift
//  PPL
//
//  Created by Jovanny Espinal on 10/27/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import UIKit

@IBDesignable public class RoundButton: UIButton {
    @IBInspectable var borderColor: UIColor = UIColor.lightGray {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 1.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = self.bounds.size.width / 2.0
        layer.masksToBounds = true
        clipsToBounds = true
    }
}

extension RoundButton {
    func disable(){
        isHidden = true
        isEnabled = false
    }
    
    func enable() {
        isHidden = false
        isEnabled = true
    }
    
    func format(with exerciseSet: ExerciseSet) {
        if exerciseSet.firstAttempt {
            if !(exerciseSet.numberOfRepsCompleted == exerciseSet.numberOfReps){
                self.initialButtonState()
            } else {
                self.ongoingButtonState(with: exerciseSet)
            }
        } else {
            self.ongoingButtonState(with: exerciseSet)
        }
    }
    
    func initialButtonState() {
        self.setTitle("", for: .normal)
        backgroundColor = UIColor.white
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1.0
    }
    
    
    func ongoingButtonState(with exerciseSet: ExerciseSet) {
        updateLabel(with: exerciseSet)
        backgroundColor = UIColor(red: 8/255.0, green: 74/255.0, blue: 131/255.0, alpha: 1)
        layer.borderWidth = 0
        tintColor = UIColor.white
    }
    
    func updateLabel(with exerciseSet: ExerciseSet) {
        setTitle("\(exerciseSet.numberOfRepsCompleted)", for: .normal)
    }
}
