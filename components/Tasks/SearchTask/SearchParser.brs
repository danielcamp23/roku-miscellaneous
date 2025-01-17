function parseMovies(rawContent as object, pageOffset as object)
    parentNode = createObject("roSGNode", "CarouselContentNode")
    if rawContent = invalid then return parentNode

    if pageOffset = invalid then pageOffset = 0

    horizontalPaginationData = {
        totalCount: 0
        hasNextPage: false
        nextPageIndex: 0
    }

    if rawContent.statusCode = 200
        response = rawContent.responseBody

        if response.error <> invalid
            ' 200 with an error means there are no results available
        else
            for each searchItem in response.search
                item = parentNode.createChild("RecipeContentNode")
                item.title = searchItem.title
                item.description = searchItem.year
                item.fhdPosterUrl = searchItem.poster
                item.id = searchItem.imdbID
                ' item.type = parentNode.type
            end for

            nextPageIndex = pageOffset + 1
            horizontalPaginationData = {
                totalCount: response.totalResults.toInt()
                nextPageIndex: nextPageIndex
                hasNextPage: response.totalResults.toInt() > nextPageIndex
            }
        end if
    else
        ' TODO: return error here
    end if

    parentNode.horizontalPaginationData = horizontalPaginationData

    return parentNode
end function

function parseMovie(rawContent as object) as object
    movideNode = createObject("roSGNode", "MovieContentNode")
    if rawContent = invalid then return movideNode

    if rawContent.statusCode = 200
        response = rawContent.responseBody

        movideNode.id = response.imdbID
        movideNode.title = response.title
        movideNode.description = response.plot
        movideNode.fhdPosterUrl = response.poster
        movideNode.actors = response.actors.split(",")
        movideNode.director = response.director

        movideNode.url = "https://test-streams.mux.dev/x36xhzz/x36xhzz.m3u8"
        movideNode.streamFormat = "hls"
    else
        ' return error node
    end if

    return movideNode
end function
