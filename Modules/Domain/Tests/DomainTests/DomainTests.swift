@testable import Domain
import XCTest

final class DomainTests: XCTestCase {
    func testGenreModelInitialization() {
        let genre = GenreModel(id: 1, name: "Action")
        XCTAssertEqual(genre.id, 1)
        XCTAssertEqual(genre.name, "Action")

        let genreCopy = GenreModel(id: 1, name: "Action")
        XCTAssertEqual(genre, genreCopy) // Hashable/Equatable
    }

    func testSpokenLanguageInitialization() {
        let language = SpokenLanguage(iso6391: "en", name: "English")
        XCTAssertEqual(language.iso6391, "en")
        XCTAssertEqual(language.name, "English")

        let languageNilIso = SpokenLanguage(iso6391: nil, name: "No ISO")
        XCTAssertNil(languageNilIso.iso6391)
        XCTAssertEqual(languageNilIso.name, "No ISO")
    }

    func testMovieModelInitializationAndHashable() {
        let date = Date()
        let movie = MovieModel(
            id: 42,
            title: "Test Movie",
            posterPath: "/poster.png",
            releaseDate: date,
            genreIds: [10, 20],
            popularity: 99.9
        )
        XCTAssertEqual(movie.id, 42)
        XCTAssertEqual(movie.title, "Test Movie")
        XCTAssertEqual(movie.posterPath, "/poster.png")
        XCTAssertEqual(movie.releaseDate, date)
        XCTAssertEqual(movie.genreIds, [10, 20])
        XCTAssertEqual(movie.popularity, 99.9)

        let movieCopy = MovieModel(
            id: 42,
            title: "Test Movie",
            posterPath: "/poster.png",
            releaseDate: date,
            genreIds: [10, 20],
            popularity: 99.9
        )
        XCTAssertEqual(movie, movieCopy) // Hashable & Equatable
    }

    func testMovieDetailModelInitialization() {
        let date = Date()
        let genres = [GenreModel(id: 1, name: "Action")]
        let language = SpokenLanguage(iso6391: "en", name: "English")

        let detail = MovieDetailModel(
            id: 100,
            title: "Detail Movie",
            overview: "Some overview",
            posterPath: "/poster.png",
            backdropPath: "/backdrop.png",
            releaseDate: date,
            genres: genres,
            homepage: "https://homepage.com",
            budget: 1_000_000,
            revenue: 5_000_000,
            spokenLanguages: [language],
            status: "Released",
            runtime: 120
        )
        XCTAssertEqual(detail.id, 100)
        XCTAssertEqual(detail.title, "Detail Movie")
        XCTAssertEqual(detail.genres.count, 1)
        XCTAssertEqual(detail.spokenLanguages.count, 1)
        XCTAssertEqual(detail.status, "Released")
        XCTAssertEqual(detail.runtime, 120)
    }

    func testPaginatedModelWithMovies() {
        let movie = MovieModel(
            id: 1,
            title: "Test",
            posterPath: "/poster.png",
            releaseDate: nil,
            genreIds: [1, 2],
            popularity: 5.0
        )
        let paginated = PaginatedModel(
            page: 2,
            results: [movie],
            totalPages: 10,
            totalResults: 100
        )

        XCTAssertEqual(paginated.page, 2)
        XCTAssertEqual(paginated.results.count, 1)
        XCTAssertEqual(paginated.results.first?.title, "Test")
        XCTAssertEqual(paginated.totalPages, 10)
        XCTAssertEqual(paginated.totalResults, 100)
    }
}
