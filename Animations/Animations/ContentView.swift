//
//  ContentView.swift
//  Animations
//
//  Created by Nacho on 09/02/2024.
//

import SwiftUI

struct CornerRotateModifier: ViewModifier {
	let amount: Double
	let anchor: UnitPoint
	
	func body(content: Content) -> some View {
		content
			.rotationEffect(.degrees(amount), anchor: anchor)
			.clipped()
	}
}
extension AnyTransition {
	static var pivot: AnyTransition {
		.modifier(
			active: CornerRotateModifier(amount: -90, anchor: .topLeading),
			identity: CornerRotateModifier(amount: 0, anchor: .topLeading) )
	}
}


struct ContentView: View {
	
//	private var letters = Array("Hello SwiftUI")
//	@State private var enabled = false
//	@State private var dragAmount = CGSize.zero
//	@State private var isShowing = false
	@State private var isShowingRed = false
	
    var body: some View {
		
		ZStack{
			Rectangle()
				.fill(.blue)
				.frame(width: 200, height: 200)
			
			if isShowingRed {
				Rectangle()
					.fill(.red)
					.frame(width: 200, height: 200)
					.transition(.pivot)
			}
		}
		.onTapGesture {
			withAnimation {
				isShowingRed.toggle()
			}
			
		}
		
//		VStack{
//			Button("TAP ME"){
//				withAnimation {
//					isShowing.toggle()
//				}
//			}
//
//			if isShowing {
//				Rectangle()
//					.fill(.red)
//					.frame(width: 200, height: 200)
//					.transition(.asymmetric(insertion: .opacity, removal: .scale))
//			}
//
//		}
		
		
		
//		HStack(spacing: 0) {
//			ForEach(0..<letters.count, id: \.self) { num in
//				Text(String(letters[num]))
//					.padding(5)
//					.font(.title)
//					.background(enabled ? .blue : .red)
//					.offset(dragAmount)
//					.animation(.easeInOut.delay(Double(num) / 20), value: dragAmount)
//			}
//		}.gesture(
//			DragGesture()
//				.onChanged{ dragAmount = $0.translation }
//				.onEnded{ _ in
//					dragAmount = .zero
//					enabled.toggle()
//				}
//		)
	}
}
		


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
