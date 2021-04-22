//
//  ContentView.swift
//  Cats-pictures
//
//  Created by Abdullah Alnutayfi on 20/04/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var stillLoding = true
    @StateObject var vm = CatsViewModel()
    var body: some View {
        ZStack(){
            Color.black.opacity(0.70)
            if stillLoding{
              ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                .scaleEffect(1)
                
            }
           
        ScrollView{
            Text("All images fetched from Tumblr")
                .font(.system(size: 15, weight: .bold, design: .rounded))
                .frame(width: 3000, height: 50)
                .foregroundColor(Color.black)
                .shadow(color:.white,radius: 10)
            VStack{
            Spacer()
       
            //Spacer()
            Button{
                stillLoding = true
                withAnimation(){
                vm.cats = []
                }
                vm.getCat()
                
            }label:{
               Text("Show new Kitty")
                .font(.system(size: 15, weight: .bold, design: .rounded))
                    .frame(width: 200, height: 35)
                .background(Color.green)
                .cornerRadius(10)
                .foregroundColor(Color.black)
                    .shadow(color:.white,radius: 10)
                .padding(.bottom,20)
            }
        
        
           
           // Spacer()
                
            ForEach(vm.cats){cat in
           
                Image(uiImage: UIImage(data: vm.loadImage(ImageUrl: cat.url ?? "") ?? Data()) ??  UIImage())
                    .resizable()
                    .scaledToFit().cornerRadius(10)
                    .frame(width: 400, height: 400)
                    
                    .shadow(radius: 10)
                
                // Spacer()
            }.onAppear{stillLoding = false}
                
        }.onAppear(){vm.getCat()}
          
        }.offset(y: 200)
            
          
            
        }.ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
