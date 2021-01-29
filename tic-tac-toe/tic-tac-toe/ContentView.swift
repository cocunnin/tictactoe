//
//  ContentView.swift
//  tic-tac-toe
//
//  Created by Cunningham, Cy on 1/26/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
   
        NavigationView {
            Home()
                .navigationTitle("Tic Tac Toe")
                .preferredColorScheme(.dark)
        }
    }
}

struct Home: View {
    //number of moves
    @State var moves : [String] = Array(repeating: "", count: 9)
    //to id the current player
    @State var isPlaying = true
    @State var gameOver = false
    @State var msg = ""
    @State var title = ""
    
    
    var body: some View {
        VStack {
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 15), count: 3), spacing:15) {
                
                ForEach(0..<9, id: \.self) {index in
                    
                    ZStack {
                        
                        Color.green
                        
                        Color.purple
                            .opacity(moves[index] == "" ? 1 : 0)
                        
                        Text(moves[index])
                            .font(.system(size: 77))
                            .fontWeight(.heavy)
                            .foregroundColor(.black)
                        
                    }
                    .frame(width: getWidth(), height: getWidth())
                    .cornerRadius(15)
                    .rotation3DEffect(
                    .init(degrees: moves[index] != "" ? 360 : 0),
                        axis: /*@START_MENU_TOKEN@*/(x: 0.0, y: 1.0, z: 0.0)/*@END_MENU_TOKEN@*/,
                        anchor: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/,
                        anchorZ: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/,
                        perspective: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/
                    )
                    
                    .onTapGesture(perform: {
                        withAnimation(Animation.easeIn(duration: 0.5)) {
                            
                            
                            if moves[index] == "" {
                                moves[index] = isPlaying ? "L" :
                                    "O"
                            }
                            isPlaying.toggle()
                    }
                })
        }
            }
        .padding(15)
    }
        .onChange(of: moves, perform: { value in
           
            checkWinner()
        })
        .alert(isPresented: $gameOver, content: {
           
            Alert(title: Text("Winner"), message: Text(msg), dismissButton: .destructive(Text("Play Again"), action: {
                
                withAnimation(Animation.easeIn(duration: 0.5)) {
                    
                    moves.removeAll()
                    moves = Array(repeating: "", count: 9)
                    isPlaying = true
                }
            }))
        })
}

func getWidth() -> CGFloat {
    let width = UIScreen.main.bounds.width - (30 + 30)
    
    return width / 3
}
    
    func checkWinner() {
       
          if checkMoves(player: "L") {
            
            title = "Winner!!"
            msg = "You have won L!!"
            gameOver.toggle()
        }
        
        else if checkMoves(player: "O") {
            
            title = "Winner!!"
            msg = "You have won O!!"
            gameOver.toggle()
            
            
        } else {
            let status = moves.contains { (value) -> Bool in
                
                return value == ""
            }
            
            if !status {
                
                msg = "Game Tied!!!"
                gameOver.toggle()
            }
        }
        
    }

    func checkMoves(player: String) -> Bool {
        //checking horiontal moves
        for contenstant in stride(from: 0, to: 9, by: 3) {
            if moves [contenstant] == player &&
                moves[contenstant+1] == player &&
                moves[contenstant+2] == player {
                return true
            }
        }
        //checking for vetical
        for contenstant in 0...2 {
            if moves [contenstant] == player &&
                moves[contenstant+3] == player &&
                moves[contenstant+6] == player {
                return true
            }
        }
        //checking for diagonal moves
        
            if moves [0] == player &&
                moves[4] == player &&
                moves[8] == player {
                return true
            }
        
        if moves [2] == player &&
            moves[4] == player &&
            moves[6] == player {
            return true
        }
        

        
        return false
        
    }
    
    
    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        }
    }
}
