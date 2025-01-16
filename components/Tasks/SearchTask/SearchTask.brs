sub init()
    m.top.functionName = "searchMovie"
end sub

sub searchMovie()
    searchService = SearchService()
    searchQuery = m.top.searchQuery

    searchArgs = {
        nextPageIndex: 1
        searchQuery: searchQuery
    }

    moviesResponse = searchService.searchMovies(searchArgs)

    pageNode = createObject("roSGNode", "CarouselContentNode")
    moviesContentNode = parseMovies(moviesResponse)
    pageNode.appendChildren(moviesContentNode.getChildren(-1, 0))
    pageNode.horizontalPaginationData = moviesContentNode.horizontalPaginationData

    m.top.content = pageNode
end sub

sub getNextPage()
    searchService = SearchService()
    searchQuery = m.top.searchQuery

    gridContent = m.top.content

    searchArgs = {
        nextPageIndex: gridContent.horizontalPaginationData.nextPageIndex
        searchQuery: searchQuery
    }

    moviesResponse = searchService.searchMovies(searchArgs)
    moviesContentNode = parseMovies(moviesResponse, gridContent.horizontalPaginationData)
    gridContent.appendChildren(moviesContentNode.getChildren(-1, 0))
    gridContent.horizontalPaginationData = moviesContentNode.horizontalPaginationData
end sub
