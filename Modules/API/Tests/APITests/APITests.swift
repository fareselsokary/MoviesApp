@testable import API
import XCTest

final class APITests: XCTestCase {
    func testPaginatedResponseDecodes() throws {
        let json = """
        {
          "page": 1,
          "results": [
            {
              "id": 42,
              "title": "Test Movie",
              "poster_path": "/poster.png",
              "release_date": "2022-06-01",
              "genre_ids": [12, 99],
              "popularity": 8.9
            }
          ],
          "total_pages": 10,
          "total_results": 100
        }
        """.data(using: .utf8)!

        let decoder = JSONDecoder()
        let page = try decoder.decode(APIPaginatedResponse<MovieResponse>.self, from: json)
        XCTAssertEqual(page.page, 1)
        XCTAssertEqual(page.totalPages, 10)
        XCTAssertEqual(page.totalResults, 100)
        XCTAssertEqual(page.results.count, 1)
        XCTAssertEqual(page.results.first?.title, "Test Movie")
    }

    func testGenreListResponseDecodes() throws {
        let json = """
        {
          "genres": [
            { "id": 1, "name": "Action" },
            { "id": 2, "name": "Comedy" }
          ]
        }
        """.data(using: .utf8)!

        let decoder = JSONDecoder()
        let list = try decoder.decode(GenreListResponse.self, from: json)
        XCTAssertEqual(list.genres.count, 2)
        XCTAssertEqual(list.genres[1].name, "Comedy")
    }

    func testGenreResponseDecodesAndIsIdentifiableAndHashable() throws {
        let json = """
        { "id": 123, "name": "Sci-Fi" }
        """.data(using: .utf8)!

        let decoder = JSONDecoder()
        let genre = try decoder.decode(GenreResponse.self, from: json)
        XCTAssertEqual(genre.id, 123)
        XCTAssertEqual(genre.name, "Sci-Fi")
    }

    func testMovieDetailResponseDecodesFullFields() throws {
        let json = """
        {
          "id": 10,
          "title": "Detail Movie",
          "overview": "Great movie",
          "poster_path": "/poster.png",
          "backdrop_path": "/backdrop.png",
          "release_date": "2021-12-25",
          "genres": [{ "id": 1, "name": "Drama" }],
          "homepage": "https://example.com",
          "budget": 5000,
          "revenue": 10000,
          "spoken_languages": [{ "iso_639_1": "en", "name": "English" }],
          "status": "Released",
          "runtime": 90
        }
        """.data(using: .utf8)!

        let decoder = JSONDecoder()
        let movie = try decoder.decode(MovieDetailResponse.self, from: json)
        XCTAssertEqual(movie.id, 10)
        XCTAssertEqual(movie.title, "Detail Movie")
        XCTAssertEqual(movie.genres.count, 1)
        XCTAssertEqual(movie.spokenLanguages.count, 1)
        XCTAssertNotNil(movie.releaseDate)
        XCTAssertEqual(movie.runtime, 90)
    }

    func testMovieDetailResponseDecodesWithMissingOptionals() throws {
        let json = """
        {
          "id": 10,
          "title": "No Optional Fields",
          "genres": [],
          "spoken_languages": []
        }
        """.data(using: .utf8)!

        let decoder = JSONDecoder()
        let movie = try decoder.decode(MovieDetailResponse.self, from: json)
        XCTAssertEqual(movie.title, "No Optional Fields")
        XCTAssertEqual(movie.genres.count, 0)
        XCTAssertNil(movie.homepage)
        XCTAssertNil(movie.releaseDate)
        XCTAssertNil(movie.runtime)
    }

    func testMovieResponseDecodes() throws {
        let json = """
        {
          "id": 101,
          "title": "Test Movie",
          "poster_path": "/image.png",
          "release_date": "2023-01-01",
          "genre_ids": [99, 42],
          "popularity": 7.5
        }
        """.data(using: .utf8)!

        let decoder = JSONDecoder()
        let movie = try decoder.decode(MovieResponse.self, from: json)
        XCTAssertEqual(movie.id, 101)
        XCTAssertEqual(movie.posterPath, "/image.png")
        XCTAssertEqual(movie.genreIds, [99, 42])
        XCTAssertNotNil(movie.releaseDate)
        XCTAssertEqual(movie.popularity, 7.5)
    }

    func testSpokenLanguageResponseDecodes() throws {
        let json = """
        { "iso_639_1": "es", "name": "Spanish" }
        """.data(using: .utf8)!

        let decoder = JSONDecoder()
        let language = try decoder.decode(SpokenLanguageResponse.self, from: json)
        XCTAssertEqual(language.iso6391, "es")
        XCTAssertEqual(language.name, "Spanish")
    }

    func testDateParsingWithInvalidDate() throws {
        let json = """
        {
          "id": 202,
          "title": "Bad Date",
          "poster_path": "",
          "release_date": "not_a_date",
          "genre_ids": [],
          "popularity": 0.0
        }
        """.data(using: .utf8)!

        let decoder = JSONDecoder()
        let movie = try decoder.decode(MovieResponse.self, from: json)
        XCTAssertNil(movie.releaseDate)
    }
}
