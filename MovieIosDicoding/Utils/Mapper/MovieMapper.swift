//
//  MovieMapper.swift
//  MovieIosDicoding
//
//  Created by Putra on 15/11/21.
//

import Foundation

final class MovieMapper {
    
    static func mapMovieResponseToPopularEntities(input movieResorce: [MovieResource]) -> [PopularMovieEntity] {
        return movieResorce.map { result in
            let newPopularMovie = PopularMovieEntity()
            newPopularMovie.id = result.id ?? 0
            newPopularMovie.title = result.title ?? ""
            newPopularMovie.backdropPath = result.backdropPath ?? ""
            newPopularMovie.originalLanguage = result.originalLanguage ?? ""
            newPopularMovie.overview = result.overview ?? ""
            newPopularMovie.popularity = String(result.popularity ?? 0.0)
            newPopularMovie.releaseData = result.releaseDate ?? ""
            newPopularMovie.voteAverage = String(result.voteAverage ?? 0.0)
            newPopularMovie.voteCount = result.voteCount ?? 0
            
            return newPopularMovie
        }
    }
    
    static func mapMovieResponseToPlayingEntities(input playingMovies: [MovieResource]) -> [PlayingNowEntity] {
        return playingMovies.map { result in
            let newPlaying = PlayingNowEntity()
            newPlaying.id = result.id ?? 0
            newPlaying.title = result.title ?? ""
            newPlaying.backdropPath = result.backdropPath ?? ""
            newPlaying.originalLanguage = result.originalLanguage ?? ""
            newPlaying.overview = result.overview ?? ""
            newPlaying.popularity = String(result.popularity ?? 0.0)
            newPlaying.releaseData = result.releaseDate ?? ""
            newPlaying.voteAverage = String(result.voteAverage ?? 0.0)
            newPlaying.voteCount = result.voteCount ?? 0
            print("playing new : \(result.voteAverage)")
            return newPlaying
        }
    }
    
    static func mapPopularMovieEntitiesToDomain(input movieResource: [PopularMovieEntity]) -> [MovieModel] {
        return movieResource.map { result in
            return MovieModel(backdropPath: result.backdropPath,
                              id: result.id ,
                              originalLanguage: result.originalLanguage ,
                              overview: result.overview,
                              popularity: result.popularity,
                              releaseDate: result.releaseData,
                              title: result.title,
                              voteAverage: result.voteAverage,
                              voteCount: result.voteCount)
        }
    }
    
    static func mapPlayingMovieEntitiesToDomain(input movieResource: [PlayingNowEntity]) -> [MovieModel] {
        return movieResource.map { result in
            return MovieModel(backdropPath: result.backdropPath,
                              id: result.id ,
                              originalLanguage: result.originalLanguage ,
                              overview: result.overview,
                              popularity: result.popularity,
                              releaseDate: result.releaseData,
                              title: result.title,
                              voteAverage: result.voteAverage,
                              voteCount: result.voteCount)
        }
    }
    
    static func mapMovieResponseToDomain(input movieResource: [MovieResource]) -> [MovieModel] {
        return movieResource.map { result in
            return MovieModel(backdropPath: result.backdropPath ?? "Unknown",
                              id: result.id ?? 0,
                              originalLanguage: result.originalLanguage ?? "",
                              overview: result.overview ?? "Nothing review yet",
                              popularity: String(result.popularity ?? 0.0),
                              releaseDate: result.releaseDate ?? "",
                              title: result.title ?? "Unknown Title",
                              voteAverage: String(result.voteAverage ?? 0.0),
                              voteCount: result.voteCount ?? 0)
        }
    }
    
    static func mapMovieFavoriteToDomain(input movie: [FavoriteEntity]) -> [MovieModel] {
        return movie.map { result in
            return MovieModel(backdropPath: result.backdropPath,
                              id: result.id,
                              originalLanguage: result.originalLanguage,
                              overview: result.overview,
                              popularity: result.popularity,
                              releaseDate: result.releaseData,
                              title: result.title,
                              voteAverage: result.voteAverage,
                              voteCount: result.voteCount)
        }
    }
    

    
    
    
}
