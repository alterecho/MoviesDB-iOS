//
//  MovieDetailsView.swift
//  MoviesDB
//
//  Created by Vijaychandran Jayachandran on 28/2/22.
//

import SwiftUI

struct MovieDetailsView<ViewModel: MovieDetailsViewModelProtocol>: View {
    @StateObject var viewModel: ViewModel
    
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        ScrollView {
            ZStack {
                VStack(spacing: 20.0) {
                    getPosterTitleView()
                    getSubDetailsView()
                    getSynopsisView()
                    getMetricsView()
                    getCreditsView()
                }
                if viewModel.isLoading {
                    ProgressView().frame(maxWidth: .infinity, maxHeight: .infinity).background(Color.black.opacity(0.25))
                }
            }.padding()
        }.navigationTitle(viewModel.pageTitle).onAppear {
            viewModel.onAppear()
        }
        .alert(isPresented: $viewModel.alert.isShowing) {
            Alert(title: Text(viewModel.alert.title ?? ""), message: Text(viewModel.alert.message ?? ""),
                  dismissButton: .default(Text(viewModel.alert.buttonTitle ?? "")) {
                
            })
        }
    }
    
    func getPosterTitleView() -> some View {
        ZStack(alignment: .bottom) {
            let screenSize = UIScreen.main.bounds.size
            if let image = viewModel.poster {
                Image(uiImage: image).resizable().frame(maxWidth: .infinity, maxHeight: screenSize.height / 2.0).background(Color.black).scaledToFit()
            }
            
            HStack {
                VStack(alignment: .leading) {
                    Text(viewModel.details?.title ?? "").foregroundColor(.white).fontWeight(.heavy).frame(maxWidth: .infinity, alignment: .leading)
                    Text(viewModel.details?.year ?? "").foregroundColor(.white).fontWeight(.light)
                }//.frame(maxWidth: .infinity).background(Color.black.opacity(0.5))
            }.padding()
        }.background(Color.black)
    }
    
    func getSubDetailsView() -> some View {
        HStack(spacing: 20.0) {
            Text(viewModel.details?.categories ?? "")
            Text(viewModel.details?.runtime ?? "")
            Text(viewModel.details?.ratings ?? "")
        }.frame(maxWidth: .infinity).font(.callout)
    }
    
    func getSynopsisView() -> some View {
        VStack {
            Text(viewModel.synopsisTitle).font(.title).fontWeight(.bold).frame(maxWidth: .infinity, alignment: .leading)
            Text(viewModel.details?.synopsis ?? "").font(.body)
        }
    }
    
    func getMetricsView() -> some View {
        HStack(spacing: 20.0) {
            VerticalValueView(title: viewModel.scoreTitle, value: viewModel.details?.score)
            VerticalValueView(title: viewModel.reviewTitle, value: viewModel.details?.reviews)
            VerticalValueView(title: viewModel.popularityTitle, value: viewModel.details?.popularity)
        }
    }
    
    func getCreditsView() -> some View {
        VStack {
            HorizontalValueView(title: viewModel.directorTitle, value: viewModel.details?.director)
            HorizontalValueView(title: viewModel.writerTitle, value: viewModel.details?.writer)
            HorizontalValueView(title: viewModel.actorsTitle, value: viewModel.details?.actors)
        }
    }
    
}

struct VerticalValueView: View {
    let title: String?
    let value: String?
    
    var body: some View {
        VStack {
            if let title = title {
                Text(title).font(.subheadline)
            }
            if let value = value {
                Text(value).font(.title).fontWeight(.bold)
            }
        }
    }
}

struct HorizontalValueView: View {
    let title: String?
    let value: String?
    
    var body: some View {
        HStack(alignment:.top, spacing: 20.0) {
            if let title = title {
                Text(title).font(.body)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            if let value = value {
                Text(value).font(.headline).frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

struct MovieDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailsView(viewModel: MovieDetailsViewModel(imdbID: "tt4154664")).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
