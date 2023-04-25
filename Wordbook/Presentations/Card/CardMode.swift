//
//  CardMode.swift
//  Wordbook
//
//  Created by Yu Takahashi on 2020/10/10.
//

import SwiftUI
import SwiftUIPager

struct CardMode: View {
    
    @Environment(\.presentationMode) var presentationMode
    let tapped = NotificationCenter.default.publisher(for: .init(rawValue: "tapped"))
    @Binding var wordbookIndex: Int
    @Binding var words: [Word]
    @State var currentPage = 0
    @State var isPrevDisabled = true
    @State var isNextDisabled = true
    @State var borderWidths: [CGFloat] = [3, 0, 0, 0]
    @State var flipped = false
    @State var pageAnimation = false
    
    var body: some View {
        
        GeometryReader { geo in
            Pager(page: $currentPage, data: words, id: \.id, content: { word in
                
                PageItem(id: word.id, originalWord: word.original, translatedWord: word.translated, geoSize: geo.size, missed: word.missed, priority: word.priority, count: words.count, wordbooks: .constant([]), wordbookIndex: $wordbookIndex, words: $words, currentPage: $currentPage, isPrevDisabled: $isPrevDisabled, isNextDisabled: $isNextDisabled, isNavBarHidden: .constant(false), presentationMode: presentationMode, pageAnimation: $pageAnimation)
            })
            .itemSpacing(20)
            .interactive(0.8)
            .onPageChanged() { _ in
                isPrevDisabled = false
                isNextDisabled = false
                if currentPage == 0 {
                    isPrevDisabled = true
                } else if currentPage == words.count {
                    isNextDisabled = true
                }
            }
            .animation(.easeInOut(duration: 0.4))
            .background(Color(.systemGroupedBackground))
            .edgesIgnoringSafeArea(.all)
            .navigationBarHidden(true)
        }
    }
}

extension View {
    func flipRotate(_ degrees : Double) -> some View {
          return rotation3DEffect(Angle(degrees: degrees), axis: (x: 0.0, y: 1.0, z: 0.0))
    }
}

struct PageItem: View {
    
    var id: UUID
    var originalWord: String
    var translatedWord: String
    var geoSize: CGSize
    var missed: Int
    var priority: Int
    var count: Int
    @Binding var wordbooks: [Wordbook]
    @Binding var wordbookIndex: Int
    @Binding var words: [Word]
    @Binding var currentPage: Int
    @Binding var isPrevDisabled: Bool
    @Binding var isNextDisabled: Bool
    @Binding var isNavBarHidden: Bool
    @Binding var presentationMode: PresentationMode
    @Binding var pageAnimation: Bool
    
    @State var borderWidths: [CGFloat] = [3, 0, 0, 0]
    @State var flipped = false
    @State var isPriorityViewHidden = true
    @State var animated = false
    //Priority
    @State var priorityIndex = 0
    
    var body: some View {
            let flipDegrees = flipped ? 180.0 : 0
            
            ZStack {
                
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            isNavBarHidden = false
                            $presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(Color(.black))
                                .font(.title)
                        })
                    }
                    .padding()
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        Text(originalWord)
                            .font(.system(size: 42, weight: .bold, design: .rounded))
                        Spacer()
                    }
                    
                    Spacer()
                    
                    HStack {
                        VStack {
                            Text("Missed: \(missed)")
                                .font(.title2)
                        }
                        Spacer()
                        
                        Button(action: {
                            updateMissCount()
                            isPriorityViewHidden = true
                            animated = true
                            flipped.toggle()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                                animated = false
                            }
                        }, label: {
                            Image(systemName: "questionmark.circle.fill")
                                .foregroundColor(Color(.black))
                                .font(.title)
                        })
                    }
                    .padding()
                }
                .background(Color(.white).opacity(0.7))
                .cornerRadius(15)
                .flipRotate(flipDegrees)
                .opacity(flipped ? 0.0 : 1.0)
                
                ZStack(alignment: .topLeading) {
                    VStack {
                        HStack {
                            Button(action: {
                                isPriorityViewHidden.toggle()
                            }, label: {
                                Image(systemName: "star.circle.fill")
                                    .foregroundColor(priorityColor())
                                    .font(.title)
                            })
                            Spacer()
                            Button(action: {
                                isNavBarHidden = false
                                saveAction()
                                $presentationMode.wrappedValue.dismiss()
                            }, label: {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(Color(.black))
                                    .font(.title)
                            })
                        }
                        .padding()
                        
                        Spacer()
                        
                        HStack {
                            Spacer()
                            Text(translatedWord)
                                .font(.system(size: 42, weight: .bold, design: .rounded))
                            Spacer()
                        }
                        
                        Spacer()
                        
                        HStack {
                            VStack {
                                Text("Missed: \(missed)")
                                    .font(.title2)
                            }
                            Spacer()
                            
                            Button(action: {
                                pageAnimation = true
                                isPrevDisabled = false
                                currentPage = currentPage + 1
                                if count - 1 == currentPage {
                                    isNextDisabled = true
                                }
                                priorityDetector()
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    pageAnimation = false
                                }
                            }, label: {
                                Image(systemName: "arrow.forward.circle.fill")
                                    .foregroundColor(isNextDisabled ? Color(.darkGray) : Color(.black))
                                    .font(.title)
                            })
                            .disabled(isNextDisabled)
                        }
                        .padding()
                    }
                    .background(Color(.white).opacity(0.7))
                    .cornerRadius(15)
                    
                    Rectangle()
                        .fill(Color(.systemBackground).opacity(0.01))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .isHidden(isPriorityViewHidden, remove: true)
                        .onTapGesture {
                            isPriorityViewHidden = true
                        }
                    
                    HStack(spacing: 10) {
                        Circle()
                            .fill(Color(.black))
                            .frame(maxWidth: 30, maxHeight: 30)
                            .overlay(
                                Circle()
                                    .stroke(Color.white, lineWidth: borderWidths[0])
                                    .frame(maxWidth: 30, maxHeight: 30)
                            )
                            .padding(.vertical)
                            .padding(.leading, 10)
                            .onTapGesture {
                                priorityIndex = 0
                                borderWidths = [3, 0, 0, 0]
                            }
                        Circle()
                            .fill(Color(.systemBlue))
                            .frame(maxWidth: 30, maxHeight: 30)
                            .overlay(
                                Circle()
                                    .stroke(Color.white, lineWidth: borderWidths[1])
                                    .frame(maxWidth: 30, maxHeight: 30)
                            )
                            .padding(.vertical)
                            .onTapGesture {
                                priorityIndex = 1
                                borderWidths = [0, 3, 0, 0]
                            }
                        Circle()
                            .fill(Color(.systemOrange))
                            .frame(maxWidth: 30, maxHeight: 30)
                            .overlay(
                                Circle()
                                    .stroke(Color.white, lineWidth: borderWidths[2])
                                    .frame(maxWidth: 30, maxHeight: 30)
                            )
                            .padding(.vertical)
                            .onTapGesture {
                                priorityIndex = 2
                                borderWidths = [0, 0, 3, 0]
                            }
                        Circle()
                            .fill(Color(.systemRed))
                            .frame(maxWidth: 30, maxHeight: 30)
                            .overlay(
                                Circle()
                                    .stroke(Color.white, lineWidth: borderWidths[3])
                                    .frame(maxWidth: 30, maxHeight: 30)
                            )
                            .padding(.vertical)
                            .padding(.trailing, 10)
                            .onTapGesture {
                                priorityIndex = 3
                                borderWidths = [0, 0, 0, 3]
                            }
                    }
                    .background(Color(.black))
                    .cornerRadius(10)
                    .padding(.leading)
                    .padding(.top, 50)
                    .isHidden(isPriorityViewHidden, remove: true)
                    .onTapGesture { }
                }
                .flipRotate(-180 + flipDegrees)
                .opacity(flipped ? 1.0 : 0.0)
            }
            .foregroundColor(.black)
            .padding(.horizontal, orientationDetector(size: geoSize).x)
            .padding(.vertical, orientationDetector(size: geoSize).y)
            .shadow(radius: 7)
            .animation(animated ? .easeInOut(duration: 0.7) : .none)
            .onTapGesture {
                isPriorityViewHidden = true
                animated = true
                flipped.toggle()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                    animated = false
                }
            }
            .onAppear() {
                priorityIndex = priority
            }
    }
    
    func updateMissCount() {
        let wordIndex = getWordIndex(words: words, id: id)
        wordbooks[wordbookIndex].words[wordIndex].missed = missed + 1
        words[wordIndex].missed = missed + 1
    }
    
    func orientationDetector(size: CGSize) -> (x: CGFloat, y: CGFloat) {
        if size.height < size.width {
            return (50, 15)
        } else {
            return (15, 45)
        }
    }
    
    func priorityDetector() {
        switch priorityIndex {
        case 1: borderWidths = [0, 3, 0, 0]
        case 2: borderWidths = [0, 0, 3, 0]
        case 3: borderWidths = [0, 0, 0, 3]
        default: borderWidths = [3, 0, 0, 0]
        }
    }
    
    func priorityColor() -> Color {
        switch priorityIndex {
        case 1: return Color(.systemBlue)
        case 2: return Color(.systemOrange)
        case 3: return Color(.systemRed)
        default: return .black
        }
    }
    
    func saveAction() {
        if priority != priorityIndex {
            let wordIndex = getWordIndex(words: words, id: id)
            wordbooks[wordbookIndex].words[wordIndex].priority = priorityIndex
            words[wordIndex].priority = priorityIndex
        }
    }
    
    struct PriorityMenu: MenuStyle {
        @State var priorityIndex: Int
        
        func makeBody(configuration: Configuration) -> some View {
            Menu(configuration)
                .font(.title)
                .foregroundColor(priorityColor())
        }
        
        func priorityColor() -> Color {
            switch priorityIndex {
            case 1: return Color(.systemBlue)
            case 2: return Color(.systemOrange)
            case 3: return Color(.systemRed)
            default: return .black
            }
        }
    }
}
