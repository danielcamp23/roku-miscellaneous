sub init()
    m.searchTask = createObject("roSGNode", "SearchTask")
    m.searchTask.omdbApiKey = m.top.omdbApiKey

    m.searchQuery = "" ' Keep track of search query for later pagination
    m.sourceScreen = invalid
end sub

sub runTask(functionName as string, searchArgs as object)
    callbackMap = {
        "searchMovies": "onSearchResponse"
        "getNextPage": "onNextPageResponse"
        "getMovieDetails": "onMovieDetailsResponse"
    }

    m.searchTask.unobserveField("content")
    m.searchTask.observeField("content", callbackMap[functionName])

    m.searchTask.omdbApiKey = m.top.omdbApiKey
    m.searchTask.functionName = functionName
    m.searchTask.searchArgs = searchArgs
    m.searchTask.control = "RUN"
end sub

sub searchMovies(sourceScreen as object, searchQuery as object)
    if NOT TypeUtils_isValidString(searchQuery) then return

    searchArgs = {
        searchQuery: searchQuery
    }

    m.searchQuery = searchQuery
    m.sourceScreen = sourceScreen
    runTask("searchMovies", searchArgs)
end sub

sub getNextPage(sourceScreen as object, paginationData as object)
    if m.searchTask.state = "run" then return
    if NOT paginationData.hasNextPage then return

    searchArgs = {
        searchQuery: m.searchQuery
        paginationData: paginationData
    }

    m.sourceScreen = sourceScreen
    runTask("getNextPage", searchArgs)
end sub

sub getMovieDetails(sourceScreen as object, movieId as object)
    if NOT TypeUtils_isValidString(movieId) then return

    m.searchTask.unobserveField("content")
    m.searchTask.observeField("content", "onMovieDetailsResponse")

    searchArgs = {
        movieId: movieId
    }

    m.sourceScreen = sourceScreen
    runTask("getMovieDetails", searchArgs)
end sub

sub onSearchResponse(event as object)
    m.sourceScreen.content = m.searchTask.content
end sub

sub onMovieDetailsResponse()
    m.sourceScreen.content = m.searchTask.content
end sub

sub onNextPageResponse()
    content = m.searchTask.content

    if content.getChildCount() > 0
        m.sourceScreen.content.appendChildren(content.getChildren(-1, 0))
        m.sourceScreen.content.horizontalPaginationData = content.horizontalPaginationData
    end if
end sub
