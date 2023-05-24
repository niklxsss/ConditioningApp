import SwiftUI
import Charts

struct HomeView: View {
    
    @Binding private var selectedTab: Tabs
    @EnvironmentObject private var appState: AppState
    
    let utils = Utils()
        
    init(selectedTab: Binding<Tabs>) {
        _selectedTab = selectedTab
    }
    
    var url: String {
            if appState.showShortcutView {
                return utils.urlStringToAlphabeticString(url: appState.openAppUrl)
            } else {
                return UserDefaults.standard.string(forKey: "lastUpdatedTimeDataAppkey") ?? ""
            }
        }
        
    var body: some View {
            NavigationView {
                VStack {
                   
                    ChartView(url: url)
                    
                    Spacer()
                    
                    GroupBox {
                        VStack {
                            HStack {
                                Text("Info")
                                    .fontWeight(.bold)
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                Spacer()
                            }
                            .padding(.horizontal)
                            
                            Divider()
                            
                            VStack {
                                Text("Die Funktionen unserer App wurden durch eine umfangreiche wissenschaftliche Studie validiert. Link zur Studie: .....")
                                    .fontWeight(.medium)
                                    .font(.body)
                                    .foregroundColor(.secondary)
                                    .multilineTextAlignment(.leading)
                                    .padding(.top)
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .padding(.horizontal)
                        }
                        
                    }.frame(width: 375, height: 390)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        .padding(.bottom)
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)

                    
                    NavigationBar(selectedTab: $selectedTab)
                    
                }
                .navigationBarTitle(Text("home"), displayMode: .inline)
                
            }
        }
}

//https://medium.com/@contact.jmeyers/complete-list-of-ios-url-schemes-for-apple-apps-and-services-always-updated-800c64f450f
