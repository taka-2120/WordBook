//
//  OriginalLanguageView.swift
//  Wordbook
//
//  Created by Yu Takahashi on 2020/11/09.
//

import SwiftUI

struct LanguageCodes {
    var id = UUID()
    var name: String
    var code: String
    var tag: Int
}

struct ImportMethodView: View {
    @ObservedObject var expantionDetector = ExpantionDetector()
    let languages: [LanguageCodes] = [LanguageCodes(name: "English", code: "en-US", tag: 0),
                                      LanguageCodes(name: "French", code: "fr-FR", tag: 1),
                                      LanguageCodes(name: "Italian", code: "it-IT", tag: 2),
                                      LanguageCodes(name: "German", code: "de-DE", tag: 3),
                                      LanguageCodes(name: "Spanish", code: "es-ES", tag: 4),
                                      LanguageCodes(name: "Portuguese(Brazil)", code: "pt-BR", tag: 5),
                                      LanguageCodes(name: "Chinese (Simplified)", code: "zh-Hans", tag: 6),
                                      LanguageCodes(name: "Chinese (Traditional)", code: "zh-Hant", tag: 7),
                                      LanguageCodes(name: "Cantonese (Simplified, China)", code: "yue-Hans", tag: 8),
                                      LanguageCodes(name: "Cantonese (Traditional, China)", code: "yue-Hant", tag: 9),
                                      LanguageCodes(name: "Korean", code: "ko-KR", tag: 10),
                                      LanguageCodes(name: "Japanese", code: "ja-JP", tag: 11),
                                      LanguageCodes(name: "Ukrainian", code: "uk-UA", tag: 12),
                                      LanguageCodes(name: "Russian", code: "ru-RU", tag: 13)]
    
    @State var selectedLanguage = 0
    @State var imagePickerIsShown = false
    @State var camaraIsShown = false
    @State var detectorIsShown = false
    @State var continuing = true
    @State var originalWord = ""
    @State var translatedWord = ""
    @State var originalWords: [String] = []
    @State var image: UIImage? = nil
    @Binding var wordbooks: [WordBooks]
    @Binding var words: [Words]
    @Binding var wordbookIndex: Int
    @Environment(\.presentationMode) var presentationMode
    @State var error_photo = false
    @State var error_text = false
    let closeNotif = NotificationCenter.default.publisher(for: .init(rawValue: "closeNotif"))
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "xmark")
                            .font(.title2)
                            .fontWeight(.bold)
                    })
                    Spacer()
                    Text("Add Word")
                        .font(.title2)
                        .fontWeight(.bold)
                    Spacer()
                    Rectangle()
                        .opacity(0)
                        .frame(width: 25, height: 0)
                }
                //By Text
                DisclosureGroup("Text", isExpanded: $expantionDetector.byText) {
                    TextField("Original", text: $originalWord)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(15)
                        .padding()
                    
                    TextField("Translated", text: $translatedWord)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(15)
                        .padding()
                    
                    //Add Button
                    Button(action: {
                        if originalWord == "" || translatedWord == "" {
                            error_text = true
                            return
                        }
                        words.append(Words(originalWord: originalWord, translatedWord: translatedWord, priority: 0, missed: 0))
                        wordbooks[wordbookIndex].words = words
                        NotificationCenter.default.post(name: .init(rawValue: "closeNotif"), object: nil)
                    }, label: {
                        Text("Add")
                            .foregroundColor(Color(.systemBackground))
                            .frame(maxWidth: 250)
                            .padding(.vertical)
                            .font(.system(size: 16))
                    })
                    .background(Color(.label))
                    .cornerRadius(10)
                    .padding()
                    .alert(isPresented: $error_text) {
                        Alert(title: Text("Error"), message: Text("You can't empty these textfield."), dismissButton: .default(Text("OK")))
                    }
                }
                
                //By Photo
                DisclosureGroup("Photo", isExpanded: $expantionDetector.byPhoto) {
                    VStack {
                        //Select Language
                        VStack(alignment: .leading) {
                            Text("Translate from...")
                                .font(.title3)
                                .foregroundColor(Color(.secondaryLabel))
                                .padding([.leading, .bottom])
                            Picker(selection: $selectedLanguage, label: Text("")) {
                                ForEach(languages, id: \.id) { language in
                                    Text(language.name).tag(language.tag)
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                        }
                        .padding()
                        
                        //Take a Photo
                        Button(action: {
                            camaraIsShown = true
                            imagePickerIsShown = true
                        }, label: {
                            HStack {
                                Image(systemName: "camera")
                                Text("Take a Photo")
                            }
                            .foregroundColor(Color(.systemBackground))
                            .frame(maxWidth: 250)
                            .padding(.vertical)
                            .font(.system(size: 16))
                        })
                        .background(Color(.label))
                        .cornerRadius(10)
                        .padding()
                        
                        //Import from Library
                        Button(action: {
                            camaraIsShown = false
                            imagePickerIsShown = true
                        }, label: {
                            HStack {
                                Image(systemName: "photo")
                                Text("Import from Library")
                            }
                            .foregroundColor(Color(.systemBackground))
                            .frame(maxWidth: 250)
                            .padding(.vertical)
                            .font(.system(size: 16))
                        })
                        .background(Color(.label))
                        .cornerRadius(10)
                        .padding()
                    }
                }
                
                Spacer()
            }
            .padding()
            .sheet(isPresented: $imagePickerIsShown, onDismiss: {
                if continuing == true {
                    detectorIsShown = true
                }
            }, content: {
                SUImagePickerView(sourceType: camaraIsShown ? UIImagePickerController.SourceType.camera : UIImagePickerController.SourceType.photoLibrary, image: $image, isPresented: $imagePickerIsShown, continuing: $continuing)
            })
            .toolbar(.hidden, in: .navigationBar)
        }
        .sheet(isPresented: $detectorIsShown, onDismiss: {
            presentationMode.wrappedValue.dismiss()
        }, content: {
            DetectorView(image: $image, wordbooks: $wordbooks, words: $words, wordbookIndex: $wordbookIndex)
        })
        .alert(isPresented: $error_photo) {
            Alert(title: Text("Error"), message: Text("You can't empty the words."), dismissButton: .default(Text("OK")))
        }
        .onReceive(closeNotif, perform: { _ in
            presentationMode.wrappedValue.dismiss()
        })
    }
}

class ExpantionDetector: ObservableObject {
    @Published var byText = true {
        didSet {
            if byText == true {
                byPhoto = false
            }
        }
    }
    @Published var byPhoto = false {
        didSet {
            if byPhoto == true {
                byText = false
            }
        }
    }
}

struct SUImagePickerView: UIViewControllerRepresentable {
    
    var sourceType: UIImagePickerController.SourceType
    @Binding var image: UIImage?
    @Binding var isPresented: Bool
    @Binding var continuing: Bool
    
    func makeCoordinator() -> ImagePickerViewCoordinator {
        return ImagePickerViewCoordinator(image: $image, isPresented: $isPresented, continuing: $continuing)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let pickerController = UIImagePickerController()
        pickerController.sourceType = sourceType
        pickerController.delegate = context.coordinator
        return pickerController
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
    }

}

class ImagePickerViewCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @Binding var image: UIImage?
    @Binding var isPresented: Bool
    @Binding var continuing: Bool
    
    init(image: Binding<UIImage?>, isPresented: Binding<Bool>, continuing: Binding<Bool>) {
        self._image = image
        self._isPresented = isPresented
        self._continuing = continuing
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        self.isPresented = false
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        continuing = false
        self.isPresented = false
    }
    
}
