//
//  RecognizerView.swift
//  Wordbook
//
//  Created by Yu Takahashi on 2020/10/25.
//

import SwiftUI
import Vision

struct Points {
    var id = UUID()
    var xCord: CGFloat
    var yCord: CGFloat
    var width: CGFloat
    var height: CGFloat
    var word: String
}

struct SelectedWords {
    var id = UUID()
    var word: String
}

struct DetectorView: View {
    
    @Binding var image: UIImage?
    @Binding var wordbooks: [WordBooks]
    @Binding var words: [Words]
    @Binding var wordbookIndex: Int
    @State var points: [Points] = []
    @State var requests = [VNRequest]()
    @State var detectedWords: [String] = []
    @Environment(\.presentationMode) var presentationMode
    @State var list = false
    @State var height: CGFloat = 0
    @State var width: CGFloat = 0
    @State var scale: CGFloat = 1.0
    @State var showDetectedWord = false
    @State var error = false
    @State var selectedWords: [SelectedWords] = []
    @State var originalWord = ""
    @State var originalWords: [String] = []
    
    var body: some View {
        
        GeometryReader { geo in
            ZStack(alignment: .topLeading) {
                ScrollView([.horizontal, .vertical]) {
                    
                    ZStack(alignment: .center) {
                        Image(uiImage: image!)
                            .resizable()
                        
                        ForEach(points, id: \.id) { point in
                            WordRectangle(width: point.width, height: point.height, xCord: point.xCord , yCord: point.yCord, word: point.word, showDetectedWord: $showDetectedWord, scale: $scale)
                        }
                    }
                    .frame(maxWidth: aspectRatioDetector(geo_w: width, geo_h: height).w * scale, maxHeight: aspectRatioDetector(geo_w: width, geo_h: height).h * scale)
                    .onAppear() {
                        width = geo.size.width
                        height = geo.size.height
                        detectedWords = recognizeText(from: (image?.cgImage)!)
                    }
                }
                .gesture(
                    MagnificationGesture()
                        .onChanged() { value in
                            withAnimation(.spring()) {
                                if value > 2 {
                                    scale = 2
                                } else if value < 1 {
                                    scale = 1
                                } else {
                                    scale = value
                                }
                            }
                        }
                )
                
                VStack {
                    HStack {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Image(systemName: "xmark")
                                .font(.system(size: 22))
                                .foregroundColor(.black)
                        })
                        .frame(maxWidth: 40, maxHeight: 40)
                        .background(Blur())
                        .cornerRadius(20)
                        
                        Spacer()
                        
                        Button(action: {
                            list.toggle()
                        }, label: {
                            Image(systemName: "list.bullet.rectangle")
                                .font(.system(size: 22))
                                .foregroundColor(.black)
                        })
                        .frame(maxWidth: 40, maxHeight: 40)
                        .background(Blur())
                        .cornerRadius(20)
                    }
                    .padding([.horizontal, .top], 30)
                    .sheet(isPresented: $list) {
                        DetectedWordsList(detectedWords: $detectedWords, wordbooks: $wordbooks, words: $words, wordbookIndex: $wordbookIndex)
                    }
                    HStack {
                        Spacer()
                        HStack {
                            Text("x\(String(format: "%.1f", scale))")
                            Stepper(value: $scale, in: 1...2, step: 0.2) { }
                                .frame(maxWidth: 100)
                        }
                        .frame(maxWidth: 160, maxHeight: 40)
                        .background(Blur())
                        .cornerRadius(7)
                    }
                    .padding(.top, 10)
                    .padding(.horizontal, 30)
                    HStack {
                        Spacer()
                        Text("Show Detected Word")
                        Toggle("", isOn: $showDetectedWord)
                            .frame(maxWidth: 50)
                    }
                    .hidden()
                    .padding(.top, 10)
                    .padding(.horizontal, 30)
                    Spacer()
                    HStack {
                        Spacer()
                        .background(Color(.systemBlue))
                        .frame(maxWidth: 50, maxHeight: 50)
                        .shadow(radius: 15)
                        .padding()
                        .onTapGesture {
                            error = true
                        }
                        .alert(isPresented: $error) {
                            Alert(title: Text("Error"), message: Text("Please select words that you want to translate."), dismissButton: .default(Text("OK")))
                        }
                    }
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    fileprivate func recognizeText(from image: CGImage) -> [String] {
        var recognizedText: [String] = []
        let recognizeTextRequest = VNRecognizeTextRequest { (request, error) in
            guard error == nil else { return }
            
            guard let observations = request.results else { return }
            guard let observations2 = observations as? [VNRecognizedTextObservation] else { return }
            
            let maximumRecognitionCandidates = 1
            for observation in observations2 {
                guard let candidate = observation.topCandidates(maximumRecognitionCandidates).first else { continue }
                
                recognizedText.append(candidate.string)
            }
            
            let result = observations.map({$0 as? VNRecognizedTextObservation})
            var index = 0
            for region in result {
                guard let rg = region else {
                    continue
                }
                
                self.highlightWord(box: rg, word: recognizedText[index])
                index = index + 1
            }
        }
        
        recognizeTextRequest.recognitionLevel = .accurate
        recognizeTextRequest.recognitionLanguages = ["ja-JP"]
        recognizeTextRequest.usesLanguageCorrection = true
        let requestHandler = VNImageRequestHandler(cgImage: image, options: [:])
        try? requestHandler.perform([recognizeTextRequest])
        return recognizedText
    }
    
    func highlightWord(box: VNRecognizedTextObservation, word: String) {
            
        var maxX: CGFloat = 9999.0
        var minX: CGFloat = 0.0
        var maxY: CGFloat = 9999.0
        var minY: CGFloat = 0.0
        
        if box.bottomLeft.x < maxX {
            maxX = box.bottomLeft.x
        }
        if box.bottomRight.x > minX {
            minX = box.bottomRight.x
        }
        if box.bottomRight.y < maxY {
            maxY = box.bottomRight.y
        }
        if box.topRight.y > minY {
            minY = box.topRight.y
        }
        
        let width = ((minX - maxX) * image!.size.width) / aspectRatioDetector(geo_w: self.width, geo_h: self.height).mag
        let height = ((minY - maxY) * image!.size.height) / aspectRatioDetector(geo_w: self.width, geo_h: self.height).mag
        let xCord = box.topLeft.x * aspectRatioDetector(geo_w: self.width, geo_h: self.height).w + (width / 2)
        let yCord = (1 - box.topLeft.y) * aspectRatioDetector(geo_w: self.width, geo_h: self.height).h + (height / 2)
        points.append(Points(xCord: xCord, yCord: yCord, width: width, height: height, word: word))
    }
    
    func aspectRatioDetector(geo_w: CGFloat, geo_h: CGFloat) -> (w: CGFloat, h: CGFloat, mag: CGFloat) {
        let im_w = image!.size.width
        let im_h = image!.size.height
        
        //How many times the size of the image is the size of the screeen.
        let mag_w = im_w / geo_w
        let mag_h = im_h / geo_h
        
        //Let the edge that has the greater value of the magnification suit to the screen.
        if mag_w > mag_h {
            return (geo_w, im_h / mag_w, mag_w)
        } else {
            return (im_w / mag_h, geo_h, mag_h)
        }
    }
}

struct WordRectangle: View {
    
    var width: CGFloat
    var height: CGFloat
    var xCord: CGFloat
    var yCord: CGFloat
    var word: String
    @Binding var showDetectedWord: Bool
    @Binding var scale: CGFloat
    @State var background_on = Color(.black).opacity(0.8)
    @State var background_off = Color(.white).opacity(0.01)
    @State var tapped = false
    
    var body: some View {
        ZStack {
            Rectangle()
                .stroke(Color.blue, lineWidth: 2)
                .frame(maxWidth: width * scale, maxHeight: height * scale)
                .background(tapped ? background_on : background_off)
                .position(x: xCord * scale, y: yCord * scale)
                .onTapGesture() {
                    tapped.toggle()
                }
            Text(word)
                .position(x: xCord * scale, y: yCord * scale)
                .opacity(showDetectedWord ? 1 : 0)
                .onTapGesture() {
                    tapped.toggle()
                }
                .foregroundColor(.white)
        }
    }
}

struct DetectedWordsList: View {
    
    @Binding var detectedWords: [String]
    @Environment(\.presentationMode) var presentationMode
    @Binding var wordbooks: [WordBooks]
    @Binding var words: [Words]
    @Binding var wordbookIndex: Int
    
    var body: some View {
        NavigationView {
            List {
                ForEach(detectedWords, id: \.self) { detectedWord in
                    DetectedWordsListItem(original: detectedWord)
                }
                .onDelete { indexSet in
                    detectedWords.remove(atOffsets: indexSet)
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle("Detected Words")
            .navigationBarItems(leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "xmark.circle.fill")
                    .font(.system(size: 28))
                    .foregroundColor(Color(.systemGray2).opacity(0.8))
            }))
        }
        
    }
}

struct DetectedWordsListItem: View {
    
    var original: String
    @State var text = ""
    
    var body: some View {
        TextField(original, text: $text)
            .onAppear() {
                text = original
            }
    }
}

struct Blur: UIViewRepresentable {
    var style: UIBlurEffect.Style = .systemMaterial
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}
