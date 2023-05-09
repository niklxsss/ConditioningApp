import SwiftUI


struct ShortcutView: View {
    
    @State var selectedTab: Tabs = .home
    @State private var originalAppURL: URL? = URL(string: "dummyurl://")
    @State private var breathAnimationScale: CGFloat = 1.0
    
    @EnvironmentObject private var appState: AppState
    @EnvironmentObject private var settings: Settings
    
    var body: some View {
        NavigationView {
            VStack {
            
                Text("App")
                    .font(.title)
                    .padding()
                
                Spacer()
                
                if appState.selectedShortcut == .sayHello {
                        Text("Hello")
                            .font(.largeTitle)
                            .foregroundColor(.blue)
                }
                else if appState.selectedShortcut == .catchABreath {
                    breathAnimation()
                }
                else if appState.selectedShortcut == .shockPicture {
                    showSelectedImagesView()
                }
                
                Spacer()
                
                HStack{
                    CountdownButton(originalAppURL: $originalAppURL, timerDuration: settings.timerDuration)
                                    .padding()
                    
                    Spacer()
                    
                    VStack (alignment: .center, spacing: 4){
                        NavigationLink(destination: HomeView(selectedTab: $selectedTab)) {
                        Image(systemName: "house")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.black)
                        
                        Text("home")
                            .foregroundColor(.black)
                        }
                        
                        
                    }
                }
        
            }
            .navigationBarTitle(Text("shortcut"), displayMode: .inline)
            .edgesIgnoringSafeArea(.bottom)
            .padding()
            
        }
        
    }
    @ViewBuilder
        private func breathAnimation() -> some View {
            ZStack {
                Circle()
                    .stroke(lineWidth: 2.0)
                    .foregroundColor(.blue)
                    .scaleEffect(breathAnimationScale)

                Text("breathe")
                    .font(.title)
            }
            .onAppear {
                startBreathAnimation()
            }
        }

        func startBreathAnimation() {
            withAnimation(Animation.easeInOut(duration: 1.8).repeatForever(autoreverses: true)) {
                breathAnimationScale = breathAnimationScale == 1.0 ? 0.6 : 1.0
            }
        }
    
    @ViewBuilder
    private func showSelectedImagesView() -> some View {
        Group {
            VStack{
            if let randomImage = settings.selectedImages.randomElement() {
                Text("image")
                Image(randomImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                Text("No image selected")
            }
            }
        }
    }

}


struct ShortcutView_Previews: PreviewProvider {
    static var previews: some View {
        ShortcutView()
            .environmentObject(AppState.shared)
            .environmentObject(Settings())
    }
}

