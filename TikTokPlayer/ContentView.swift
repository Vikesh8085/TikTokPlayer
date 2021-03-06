//
//  ContentView.swift
//  TikTokPlayer
//
//  Created by Vikesh Prasad on 29/05/20.
//  Copyright © 2020 Learning. All rights reserved.
//

import SwiftUI
import AVKit

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home: View {
   @State var index = 0
   @State var top = 0
    @State var VideoData = [
        
        Video(id: 0, player: AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "video4", ofType: "mp4")!)), isReplay: false),
        Video(id: 1, player: AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "video1", ofType: "mp4")!)), isReplay: false),
        Video(id: 2, player: AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "video2", ofType: "mp4")!)), isReplay: false),
        Video(id: 3, player: AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "video5", ofType: "mp4")!)), isReplay: false),
        Video(id: 4, player: AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "video3", ofType: "mp4")!)), isReplay: false),
        Video(id: 5, player: AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "video6", ofType: "mp4")!)), isReplay: false)
    ]

    var body: some View {
        ZStack {
            PlayerScrollView(videoContent: self.$VideoData)
            VStack() {
                HStack() {
                    
                    Button(action: {
                        self.top = 0
                    }) {
                        Text("Following")
                            .foregroundColor(self.top == 0 ? .white : Color.white.opacity(0.5))
                            .padding(.vertical)
                    }
                    Button(action: {
                        self.top = 1
                    }) {
                        Text("For You")
                            .foregroundColor(self.top == 1 ? .white : Color.white.opacity(0.5))
                            .padding(.vertical)
                    }
                }
                Spacer()
                HStack {
                    Spacer()
//                    Text("vikesh :P")
//                        .foregroundColor(.white)
//                        .font(.largeTitle)
                    VStack (spacing: 32){
                        Button(action: {
                            
                        }) {
                            Image("pic")
                            .resizable()
                            .renderingMode(.original)
                            .frame(width: 55, height: 55)
                            .clipShape(Circle())
                        }
                        Button(action: {
                            
                        }) {
                            VStack (spacing : 10){
                                Image(systemName: "suit.heart.fill")
                                .font(.title)
                                .foregroundColor(.white)
                                
                                Text("22K")
                                .foregroundColor(.white)
                                
                              }
                        }
                        Button(action: {
                            
                        }) {
                            VStack (spacing : 10) {
                                Image(systemName: "message.fill")
                                    .font(.title)
                                    .foregroundColor(.white)
                                
                                Text("1012")
                                    .foregroundColor(.white)
                                
                            }
                        }
                        
                        Button(action: {
                            
                        }) {
                            VStack (spacing : 10) {
                                Image(systemName: "arrowshape.turn.up.right.fill")
                                    .font(.title)
                                    .foregroundColor(.white)
                                
                                Text("Share")
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    .padding(.bottom,55)
                }
                HStack (spacing: 0) {
                    Button(action: {
                        self.index = 0
                    }) {
                        Image("home")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(self.index == 0 ? .white : Color.white.opacity(0.5) )
                            .padding(.horizontal)
                    }
                    Spacer(minLength: 0)
                    Button(action: {
                        self.index = 1
                    }) {
                        Image("search")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(self.index == 1 ? .white : Color.white.opacity(0.5) )
                            .padding(.horizontal)
                    }
                    Spacer(minLength: 0)
                    Button(action: {
                    }) {
                        Image("upload")
                            .renderingMode(.original)
                            .resizable()
                            .frame(width: 50, height: 35)
                            .padding(.horizontal)
                    }
                    Spacer(minLength: 0)
                    Button(action: {
                             self.index = 2
                    }) {
                        Image("comment")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(self.index == 2 ? .white : Color.white.opacity(0.5) )
                            .padding(.horizontal)

                    }
                    Spacer(minLength: 0)
                    Button(action: {
                             self.index = 3
                    }) {
                        Image("profile")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(self.index == 3 ? .white : Color.white.opacity(0.5) )
                            .padding(.horizontal)
                        
                    }
                }
                .padding(.horizontal)
            }
            .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
            .padding(.bottom, (UIApplication.shared.windows.first?.safeAreaInsets.bottom)! + 5)
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .edgesIgnoringSafeArea(.all)
    }
}

class Host: UIHostingController<ContentView> {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

struct PlayerView: View {
    @Binding var videoContents: [Video]
    var body: some View {
        VStack(spacing: 0) {
                ForEach(0..<self.videoContents.count){i in
                
                ZStack {
                    Player(player: self.videoContents[i].player)
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                        .offset(y: -5)
                    
                    if self.videoContents[i].isReplay {
                        Button(action: {
                            self.videoContents[i].isReplay = false
                            self.videoContents[i].player.seek(to: .zero)
                            self.videoContents[i].player.play()
                        }, label: {
                            Image(systemName: "goforward")
                                .resizable()
                                .frame(width: 55, height: 55)
                                .foregroundColor(.white)
                        })
                    }
                }
                .onAppear {
                    self.videoContents[0].player.play()
                    self.videoContents[0].player.actionAtItemEnd = .none
                    NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object:  self.videoContents[0].player.currentItem, queue: .main) { (_) in
                        self.videoContents[0].isReplay = true
                    }
            }
            }
        }
    }
}

struct Player: UIViewControllerRepresentable {
    var player: AVPlayer
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let view = AVPlayerViewController()
        view.player = player
        view.showsPlaybackControls = false
        view.videoGravity = .resizeAspectFill
        return view
    }
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        
    }

}

struct Video: Identifiable {
    var id: Int
    var player: AVPlayer
    var isReplay: Bool
}

struct PlayerScrollView: UIViewRepresentable {
    @Binding var videoContent: [Video]
    func makeCoordinator() -> Coordinator {
        return PlayerScrollView.Coordinator(superview: self)
    }
    
    func makeUIView(context: Context) -> UIScrollView {
        let scrollView = UIScrollView()
        let childView = UIHostingController(rootView: PlayerView(videoContents: self.$videoContent))
        childView.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * CGFloat( videoContent.count ))
        scrollView.contentSize = CGSize( width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * CGFloat( videoContent.count ))
        scrollView.addSubview(childView.view)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.isPagingEnabled = true
        scrollView.delegate = context.coordinator
        return scrollView
    }
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        uiView.contentSize = CGSize( width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * CGFloat( videoContent.count ))
        for view in uiView.subviews {
            view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * CGFloat( videoContent.count ))
        }
    }

    class Coordinator : NSObject, UIScrollViewDelegate {
        var scrollerViewObjct : PlayerScrollView
        var index = 0
        init(superview: PlayerScrollView) {
            scrollerViewObjct = superview
        }
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            let currentIndex = Int(scrollView.contentOffset.y / UIScreen.main.bounds.height)
            if index != currentIndex {
                index = currentIndex
                for i in 0..<scrollerViewObjct.videoContent.count {
                    scrollerViewObjct.videoContent[i].player.seek(to: .zero)
                    scrollerViewObjct.videoContent[i].player.pause()
                }
                scrollerViewObjct.videoContent[index].player.play()
                scrollerViewObjct.videoContent[index].player.actionAtItemEnd = .none
                NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object:  scrollerViewObjct.videoContent[index].player.currentItem, queue: .main) { (_) in
                    self.scrollerViewObjct.videoContent[self.index].isReplay = true
                }
            }
        }
    }
}
