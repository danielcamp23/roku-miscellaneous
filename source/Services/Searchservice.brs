function SearchService()
    return {
        httpComponent: HttpComponent()

        baseUrl: "https://www.omdbapi.com/"

        apiKey: "41a58682"

        genericError: {
            statusCode: 400
            responseBody: invalid
        }

        searchMovies: function(args = {} as object)
            nextPageIndex = args.nextPageIndex
            if nextPageIndex = invalid then nextPageIndex = 1

            searchQuery = args.searchQuery
            if searchQuery = invalid then searchQuery = ""

            headers = {}

            qParams = {
                page: nextPageIndex
                apikey: m.apiKey
                s: searchQuery
            }

            return m.httpComponent.get(m.baseUrl, headers, qParams)
        end function

        getMovieDetails: function(args = {} as object)
            movieId = args.movieId
            if NOT TypeUtils_isValidString(movieId) then return m.genericError

            headers = {}

            qParams = {
                apikey: m.apiKey
                i: movieId
                plot: "full"
            }

            return m.httpComponent.get(m.baseUrl, headers, qParams)
        end function
    }
end function