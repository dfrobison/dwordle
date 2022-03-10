//
//  DwordleView.swift
//  dwordle
//
//  Created by Doug on 2/26/22.
//

import SwiftUI
import ComposableArchitecture

struct DwordleView: View {
    let store: Store<DwordleState, DwordleAction>
    @ObservedObject var viewStore: ViewStore<DwordleState, DwordleAction>
    @State var degrees: CGFloat = 0
    
    init(store: Store<DwordleState, DwordleAction>) {
        self.store = store
        self.viewStore = ViewStore(self.store)
    }
    
    var body: some View {
        ZStack {
            Color(.systemGray6)
                .ignoresSafeArea()
            
            VStack {
                DwordleScoreView(store: store)
                
                DwordleGridView(
                    width: viewStore.columns,
                    height: viewStore.rows,
                    spacing: 8
                ) { row, column in
                    DwordleCellView(cell: viewStore.dwordleGrid[row][column])
                        .if(viewStore.row == row && viewStore.canPlay && viewStore.isValidatedWord) { view in
                            view.rotation3DEffect(.degrees(degrees), axis: (x: 1, y: 0, z: 0), perspective: 0.04)
                        }
                }
                .frame(maxHeight: .infinity)
                .alert(
                    self.store.scope(state: \.alert),
                    dismiss: .cancelTapped
                )
                
                DwordleKeyboardView(viewStore: viewStore, degrees: $degrees)
            }
            .padding([.leading, .trailing, .bottom], 12)
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Button("New Game") {
                        withAnimation {
                            viewStore.send(.newGame)
                        }
                    }
                    Spacer()
                }
            }
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
    }
}

struct DwordleView_Previews: PreviewProvider {
    static var previews: some View {
        DwordleView( store: Store(initialState: DwordleState(columns: 5, rows: 6),
                                  reducer: dwordleReducer,
                                  environment: DwordleEnvironment(wordProvider: WordProvider(), mainRunLoop: .main)))
    }
}

