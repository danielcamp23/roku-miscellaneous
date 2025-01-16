function SearchService()
    return {
        httpComponent: HttpComponent()

        searchMovies: function(args = {} as object)
            nextPageIndex = args.nextPageIndex
            if nextPageIndex = invalid then nextPageIndex = 1

            searchQuery = args.searchQuery
            if searchQuery = invalid then searchQuery = ""

            url = "https://www.omdbapi.com/"
            headers = {}
            qParams = {
                page: nextPageIndex
                apikey: "41a58682"
                s: searchQuery
            }

            ?"page to request "nextPageIndex

            return m.httpComponent.get(url, headers, qParams)
        end function
    }
end function