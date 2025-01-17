sub init()

end sub

sub searchMovies()
    searchService = SearchService()
    searchArgs = m.top.searchArgs

    ' Add page argument to the search
    searchArgs["nextPageIndex"] = 1

    moviesResponse = searchService.searchMovies(searchArgs)

    pageNode = createObject("roSGNode", "CarouselContentNode")
    moviesContentNode = parseMovies(moviesResponse, searchArgs.nextPageIndex)
    pageNode.appendChildren(moviesContentNode.getChildren(-1, 0))
    pageNode.horizontalPaginationData = moviesContentNode.horizontalPaginationData

    m.top.content = pageNode
end sub

sub getNextPage()
    searchService = SearchService()
    searchArgs = m.top.searchArgs

    searchArgs = {
        nextPageIndex: searchArgs.paginationData.nextPageIndex
        searchQuery: searchArgs.searchQuery
    }

    moviesResponse = searchService.searchMovies(searchArgs)
    moviesContentNode = parseMovies(moviesResponse, searchArgs.nextPageIndex)
    m.top.content = moviesContentNode
end sub

sub getMovieDetails()
    searchService = SearchService()
    searchArgs = m.top.searchArgs

    detailsResponse = searchService.getMovieDetails(searchArgs)
    movieDetailsNode = parseMovie(detailsResponse)
    m.top.content = movieDetailsNode
end sub
