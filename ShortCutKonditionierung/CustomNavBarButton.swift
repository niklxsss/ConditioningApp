import SwiftUI

struct CustomNavBarButton: View {
    
    var buttonText: String
    var imageName: String
    var isAcitve: Bool
    
    var body: some View {
        
        GeometryReader{geo in
            
            if isAcitve {
                
            Rectangle()
                .foregroundColor(.black)
                .frame(width: geo.size.width/2, height: 4)
                .padding(.leading, geo.size.width/4)
            }
            
        
        VStack (alignment: .center, spacing: 4){
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .foregroundColor(.black)
            
            Text(buttonText)
                //.font(Font.tabBar)
                .foregroundColor(.black)
            
            
        }
        .frame(width: geo.size.width, height: geo.size.height)
            
        }
    }
}

struct CustomNavBarButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavBarButton(buttonText: "home", imageName: "house", isAcitve: true)
    }
}
