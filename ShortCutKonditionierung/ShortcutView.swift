import SwiftUI


struct ShortcutView: View {
    
    @Binding private var selectedTab: Tabs
    @State private var originalAppURL: URL? = URL(string: "dummyurl://")
    @State private var breathAnimationScale: CGFloat = 1.0
    
    @EnvironmentObject private var appState: AppState
    @EnvironmentObject private var settings: Settings
    
    init(selectedTab: Binding<Tabs>) {
        _selectedTab = selectedTab
    }
    
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
                    Spacer()
                    
                    CountdownButton(originalAppURL: $originalAppURL, timerDuration: settings.timerDuration)
                                
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Text("exit")
                            .frame(width: 150)
                            .padding()
                            .background(Color.white)
                            .foregroundColor(.red)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.red, lineWidth: 2)
                            )
                    }
                    
                    Spacer()

                    
                }
                .padding(.bottom, 5)
                
                NavigationBar(selectedTab: $selectedTab)
                   
            }
            .navigationBarTitle(Text("shortcut"), displayMode: .inline)
        
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
            .frame(width: 380)
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
                Image(randomImage)
                    .resizable()
                    .frame(width: 380, height: 350)
                    .cornerRadius(10)
            } else {
                Text("No image selected")
            }
            }
        }
    }

}


struct ShortcutView_Previews: PreviewProvider {
    static var previews: some View {
        ShortcutView(selectedTab: .constant(.shortcut))
            .environmentObject(AppState.shared)
            .environmentObject(Settings())
    }
}

