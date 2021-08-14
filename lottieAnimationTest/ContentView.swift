//
//  ContentView.swift
//  lottieAnimationTest
//
//  Created by Achintha Kahawalage on 2021-07-19.
//

import SwiftUI
import Lottie

struct ContentView: View {
    @State var buttonTapped: Bool = false
    @State var overText = false
    @StateObject var vm = ReactionVM()
    @State var imageName = "ic_post_reaction_like_small"
    
    
    var body: some View {
        ZStack {
            VStack{
                    Button(action: {
                        buttonTapped.toggle()
                    }, label: {
                        Image((self.vm.selectedRec != nil) ? self.vm.selectedRec!.image : self.imageName)
                            .resizable()
                            .frame(width: 40, height: 40)
                })
                  
            }
            .padding(.top,90)
            
            if buttonTapped{
                HStack {
                    ForEach(vm.reactionType, id: \.self){ anim in
                            Button(action: {
                                buttonTapped = false
                                vm.selectedRec = anim
                            }, label: {
                                VStack(spacing:0){
                                    LottieView(name: anim.animation!, loopMode: .loop)
                                        .frame(width: 30, height: 30)
                                }
                            })
                    }
                }
                .padding(.all)
                .background(Color.blue)
                .frame(height: 50)
                .cornerRadius(20)
            }
        }
    }
}

struct Reaction: Codable, Hashable{
    var id: String?
    var animation: String?
    var text: String
    var image: String
    
    public func hash(into hasher: inout Hasher){
        hasher.combine(self.id)
    }
}


class ReactionVM: ObservableObject{
    @Published var reactionType = [
        Reaction(id: "1", animation: "FurBaby_Emoji_Happy_V1", text: "Love", image: "ic_post_reaction_angry_small"),
        Reaction(id: "2", animation: "FurBaby_Emoji_Happy_V1", text: "Love", image: "ic_post_reaction_angry_small"),
        Reaction(id: "3", animation: "FurBaby_Emoji_Happy_V1", text: "Love", image: "ic_post_reaction_angry_small"),
        Reaction(id: "4", animation: "FurBaby_Emoji_Happy_V1", text: "Love", image: ""),
        Reaction(id: "5", animation: "FurBaby_Emoji_Happy_V1", text: "Love", image: ""),
    ]
    var selectedRec: Reaction? = nil
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct LottieView: UIViewRepresentable {
    var name: String
    var loopMode: LottieLoopMode = .loop
    var hover: HoverEffect = .lift
    
    var animationView = AnimationView()
    
    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        let view = UIView(frame: .zero)
        
        animationView.animation = Animation.named(name)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = loopMode
        animationView.play()
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieView>) {}
}
