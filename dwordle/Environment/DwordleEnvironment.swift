//
//  DwordleEnvironment.swift
//  dwordle
//
//  Created by Doug on 2/26/22.
//
import CombineSchedulers

struct DwordleEnvironment {
    var wordProvider: WordProvider
    var mainRunLoop: AnySchedulerOf<RunLoop>
}
