//
//  MovieDetailsView.swift
//  MoviesDB
//
//  Created by Vijaychandran Jayachandran on 28/2/22.
//

import SwiftUI

struct MovieDetailsView<ViewModel: MovieDetailsViewModelProtocol>: View {
    let viewModel: ViewModel
    
    var body: some View {
        return NavigationView {
            VStack {
                getPosterTitleView()
                getSubDetailsView()
                getSynopsisView()
                getMetricsView()
                getCreditsView()
            }
        }.navigationTitle(viewModel.pageTitle)
    }
    
    func getPosterTitleView() -> some View {
        ZStack {
            if let image = viewModel.poster {
                Image(uiImage: image)
            }
            
            HStack {
                VStack {
                    Text(viewModel.details?.title ?? "")
                    Text(viewModel.details?.year ?? "")
                }
            }
            
        }
    }
    
    func getSubDetailsView() -> some View {
        HStack {
            Text(viewModel.details?.categories ?? "")
            Text(viewModel.details?.runtime ?? "")
            Text(viewModel.details?.ratings ?? "")
        }
    }
    
    func getSynopsisView() -> some View {
        VStack {
            Text(viewModel.synopsisTitle)
            Text(viewModel.details?.synopsis ?? "")
        }
    }
    
    func getMetricsView() -> some View {
        HStack {
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
                Text(title)
            }
            if let value = value {
                Text(value)
            }
        }
    }
}

struct HorizontalValueView: View {
    let title: String?
    let value: String?
    
    var body: some View {
        HStack {
            if let title = title {
                Text(title)
            }
            if let value = value {
                Text(value)
            }
        }
    }
}

