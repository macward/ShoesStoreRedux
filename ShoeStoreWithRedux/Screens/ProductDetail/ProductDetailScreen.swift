//
//  ShoeDetailView.swift
//  ShoeStoreWithRedux
//
//  Created by Max Ward on 02/10/2023.
//

import SwiftUI

struct ProductDetailScreen: View {
    
    @Binding var product: Product?
    @Environment(\.dismiss) var dismiss
    @State private var appear = [false, false, false, false]
    @State private var selectedColor: ColorControlItem?
    @State private var selectedSize: SizeControlItem?
    @State private var dismissView: Bool = false
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            VStack {
                ScrollView {
                    VStack {
                        HStack {
                            VerticalSizeControlView(selected: $selectedSize)
                                .offset(x: appear[2] ? 0 : -80)
                            Spacer()
                        }
                        .background(
                            FeaturedProductImage(product: product)
                                .offset(x: appear[2] ? 0 : 100)
                                .opacity(appear[2] ? 1 : 0)
                        )
                        
                        HStack {
                            Text(product?.title ?? "")
                                .font(.title)
                                .fontWeight(.bold)
                            Spacer()
                        }
                        .padding(.top, 32)
                        .offset(y: appear[1] ? 0 : 80)
                        .opacity(appear[1] ? 1 : 0)
                        
                        HStack (alignment: .bottom) {
                            PriceView(price: product?.price ?? 199.99)
                                .offset(x: appear[0] ? 0 : -80)
                            Spacer()
                            InStockView(isInStock: true)
                                .offset(x: appear[0] ? 0 : 80)
                        }
                        .padding(.top, 36)
                        .opacity(appear[2] ? 1 : 0)
                    }
                    .background(
                        Image("nike")
                            .resizable()
                            .rotationEffect(.degrees(-60))
                            .scaledToFit()
                            .offset(x: 40, y: -40)
                            .scaleEffect(1.3)
                            .opacity(0.2)
                            .opacity(appear[0] ? 0.2 : 0)
                    )
                    .safeAreaPadding(.horizontal)
                }
                VStack {
                    // color control
                    HStack {
                        ColorControlView(selected: $selectedColor)
                            .padding(.bottom)
                            .offset(y: appear[2] ? 0 : 80)
                            .opacity(appear[2] ? 1 : 0)
                        Spacer()
                    }
                    Button("Add to Cart") {
                        print("sample")
                    }
                    .buttonStyle(GrayButton())
                    .offset(y: appear[0] ? 0 : 80)
                }
                .padding(.bottom, 32)
                .safeAreaPadding(.horizontal)
                
            }
            .padding(.top, 64)
            .coordinateSpace(name: "scroll")
            .ignoresSafeArea()
            .overlay (alignment: .topTrailing) {
                Image(systemName: "xmark.circle.fill")
                    .font(.system(size: 32))
                    .foregroundStyle(Color.grayMid)
                    .padding(.trailing, 20)
                    .onTapGesture {
                        dismissView.toggle()
                    }
            }
            .onAppear {
                fadeIn()
            }
            .onChange(of: dismissView) { _, _ in
                fadeOut()
            }
            .onDisappear() {
                product = nil
            }
        }
    }
    
    func fadeIn() {
        withAnimation(.easeOut.delay(0.2)) {
            appear[0] = true
        }
        
        withAnimation(.easeOut.delay(0.3)) {
            appear[1] = true
        }
        withAnimation(.easeOut.delay(0.4)) {
            appear[2] = true
        }
        withAnimation(.easeOut.delay(0.5)) {
            appear[3] = true
        }
    }
    
    func fadeOut() {
        appear[0] = false
        appear[1] = false
        appear[2] = false
        appear[3] = false
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 0.2) {
            dismiss()
        }
    }
}

struct ShoeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailScreen(product: .constant(Product.mock))
    }
    
}
