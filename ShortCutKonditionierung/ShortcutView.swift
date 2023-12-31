import SwiftUI


struct ShortcutView: View {
    
    @Binding private var selectedTab: Tabs
    @State private var breathAnimationScale: CGFloat = 1.0
    
    @EnvironmentObject private var appState: AppState
    @EnvironmentObject private var settings: Settings
    
    init(selectedTab: Binding<Tabs>) {
        _selectedTab = selectedTab
    }
    
    var body: some View {
        NavigationView {
            VStack {
                
                if appState.selectedShortcut == .catchABreath {
                    Spacer()
                    breathAnimation()
                }
                else if appState.selectedShortcut == .shockPicture {
                    showSelectedImagesView()
                }
                else if appState.selectedShortcut == .warningByText {
                    Spacer()
                    showRandomWarningTextView()
                }
                
                Spacer()
                
                HStack{
                    Spacer()
                    
                    
                    CountdownButton(appInfo: appState.appInfo, timerDuration: settings.timerDuration)
                    
                    Spacer()
                    
                    Button(action: {exit(0)}) {
                        Text("exit")
                            .frame(width: 180, height: 55)
                            .background(Color.white)
                            .foregroundColor(.red)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.red, lineWidth: 2)
                            )
                    }
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                    
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
            .frame(width: 375)
        }

        func startBreathAnimation() {
            withAnimation(Animation.easeInOut(duration: 2.1).repeatForever(autoreverses: true)) {
                breathAnimationScale = breathAnimationScale == 1.0 ? 0.6 : 1.0
            }
        }
    
    @ViewBuilder
    private func showSelectedImagesView() -> some View {
        Group {
            VStack{
                if let randomImage = settings.allImages.randomElement() {
                Image(randomImage)
                    .resizable()
                    .frame(width: 370, height: 555)
                    .cornerRadius(10)
                    
            } else {
                Text("No image selected")
            }
            }
        }
        Spacer()
    }
    
    @ViewBuilder
    private func showRandomWarningTextView() -> some View {
        if let randomInfoText = settings.infoTextsShortcut.randomElement() {
            
            ZStack {
                Color.white
                    .frame(width: 375, height: 375)
                    .cornerRadius(10)
                
                Text(randomInfoText)
                    .font(.title2)
                    .padding()
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
            }
        } else {
            ZStack {
                Color.white
                    .frame(width: 375, height: 375)
                    .cornerRadius(10)
                
                Text("No info text available")
                    .font(.title2)
                    .padding()
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
            }
        }
    }


}
