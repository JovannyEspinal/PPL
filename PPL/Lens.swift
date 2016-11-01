//
//  Lens.swift
//  PPL
//
//  Created by Jovanny Espinal on 10/21/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import Foundation

precedencegroup StarTwiddlePrecedence {
    associativity: left
    higherThan: PipeForwardPrecedence
}

infix operator *~ : StarTwiddlePrecedence
func *~ <Whole, Part> (lhs: Lens<Whole, Part>, rhs: Part) -> ((Whole) -> Whole) {
    return { whole in lhs.set(rhs, whole) }
}

precedencegroup PipeForwardPrecedence {
    associativity: left
}
infix operator |> : PipeForwardPrecedence
func |> <Whole, Part> (x: Whole, f: (Whole) -> Part) -> Part {
    return f(x)
}

func |> <Whole, Part, SubPart> (f:  @escaping (Whole) -> Part, g: @escaping (Part) -> SubPart) -> (Whole) -> SubPart {
    return { g(f($0)) }
}

func compose<Whole, Part, SubPart> (_ lhs: Lens<Whole, Part>, _ rhs: Lens<Part, SubPart>) -> Lens<Whole, SubPart> {
    return Lens<Whole, SubPart>(
        get: { whole in rhs.get(lhs.get(whole)) },
        set: { (c, whole) in lhs.set(rhs.set(c, lhs.get(whole)), whole)}
    )
}

func * <Whole, Part, SubPart> (lhs: Lens<Whole, Part>, rhs: Lens<Part, SubPart>) -> Lens<Whole, SubPart> {
    return compose(lhs, rhs)
}

struct Lens<Whole, Part> {
    let get: (Whole) -> Part
    let set: (Part, Whole) -> Whole
}
