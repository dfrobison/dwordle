//
//  DwordleScoreView.swift
//  dwordle
//
//  Created by Doug on 3/9/22.
//

import ComposableArchitecture
import SwiftUI

struct DwordleScoreView: View {
    let store: Store<DwordleState, DwordleAction>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            HStack {
                HStack {
                    Text("Time: ")
                    timeFormatter.string(from: viewStore.duration).map {
                        Text($0)
                    }
                }
                
                Spacer()
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Wins:")
                        Text("Loses:")
                    }
                    VStack(alignment: .trailing) {
                        Text("\(viewStore.wins)")
                        Text("\(viewStore.loses)")
                    }
                }
            }
        }
        
    }
}

