//
//  SearchBar.swift
//  MovieList
//
//  Created by Can Bas on 3.04.2023.
//

import Combine
import SwiftUI

struct SearchBar: UIViewRepresentable {
    @Binding var text: String
    var onSearchButtonChanged: ((String) -> Void)?

    func makeCoordinator() -> Coordinator {
        Coordinator(self, onSearchButtonChanged: onSearchButtonChanged)
    }

    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.text = text
    }

    class Coordinator: NSObject, UISearchBarDelegate {
        var parent: SearchBar
        var onSearchButtonChanged: ((String) -> Void)?
        private let searchPublisher = PassthroughSubject<String, Never>()
        private var searchCancellable: AnyCancellable?
        private var previousSearchTextLength: Int = 0

        init(_ parent: SearchBar, onSearchButtonChanged: ((String) -> Void)?) {
            self.parent = parent
            self.onSearchButtonChanged = onSearchButtonChanged

            searchCancellable = searchPublisher
                .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
                .sink { searchText in
                    onSearchButtonChanged?(searchText)
                }
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            let isDeleting = searchText.count < previousSearchTextLength
            previousSearchTextLength = searchText.count

            if !isDeleting {
                        parent.text = searchText
                        searchPublisher.send(searchText)
                    }
        }

        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
        }
    }
}
