function parseMovies(rawContent as object, previousPageData = invalid as object)
    parentNode = createObject("roSGNode", "CarouselContentNode")
    if rawContent = invalid then return parentNode

    ?"previousPageData is "previousPageData
    pageOffset = previousPageData?.nextPageIndex
    if pageOffset = invalid then pageOffset = 0
    ?"pageOffset "pageOffset

    if rawContent.statusCode = 200
        response = rawContent.responseBody
        ' parentNode.type = ContentTypeEnums().RECIPE

        for each searchItem in response.search
            item = parentNode.createChild("RecipeContentNode")
            item.title = searchItem.title
            item.description = searchItem.year
            item.fhdPosterUrl = searchItem.poster
            ' item.type = parentNode.type
        end for

        nextPageIndex = pageOffset + 1
        horizontalPaginationData = {
            totalCount: response.totalResults.toInt()
            nextPageIndex: nextPageIndex
            hasNextPage: response.totalResults.toInt() > nextPageIndex
        }

        parentNode.horizontalPaginationData = horizontalPaginationData
    else

    end if

    return parentNode
end function
