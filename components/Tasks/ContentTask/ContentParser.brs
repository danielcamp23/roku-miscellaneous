function parseContentData(rawContent as object, parentNode as object)
    if parentNode = invalid then parentNode = createObject("roSGNode", "GridParentContentNode")
    if rawContent = invalid then return parentNode

    if rawContent.statusCode = 200
        response = rawContent.responseBody
        carousel = parentNode.createChild("CarouselContentNode")

        itemsToParse = response.recipes
        for each recipe in response.recipes
            item = carousel.createChild("ContentNode")
            item.title = recipe.name
            item.fhdPosterUrl = recipe.image
        end for

        horizontalPaginationData = {
            totalCount: response.total
            nextPageIndex: carousel.getChildCount()
            hasNextPage: response.total > carousel.getChildCount()
        }

        carousel.horizontalPaginationData = horizontalPaginationData
    else

    end if

    return parentNode
end function

function parseRecipes(rawContent as object, previousPageData = invalid as object)
    carouselNode = createObject("roSGNode", "CarouselContentNode")
    if rawContent = invalid then return carouselNode

    ?"previousPageData is "previousPageData
    pageOffset = previousPageData?.nextPageIndex
    if pageOffset = invalid then pageOffset = 0
    ?"pageOffset "pageOffset

    if rawContent.statusCode = 200
        response = rawContent.responseBody
        carouselNode.type = ContentTypeEnums().RECIPE

        for each recipe in response.recipes
            item = carouselNode.createChild("RecipeContentNode")
            item.title = recipe.name
            item.description = recipe.instructions.join(" ")
            item.fhdPosterUrl = recipe.image
            item.type = carouselNode.type
        end for

        nextPageIndex = pageOffset + carouselNode.getChildCount()
        horizontalPaginationData = {
            totalCount: response.total
            nextPageIndex: nextPageIndex
            hasNextPage: response.total > nextPageIndex
        }

        carouselNode.horizontalPaginationData = horizontalPaginationData
    else

    end if

    return carouselNode
end function

function parseProducts(rawContent as object, previousPageData = invalid as object)
    carouselNode = createObject("roSGNode", "CarouselContentNode")
    if rawContent = invalid then return carouselNode

    ?"previousPageData is "previousPageData
    pageOffset = previousPageData?.nextPageIndex
    if pageOffset = invalid then pageOffset = 0
    ?"pageOffset "pageOffset

    if rawContent.statusCode = 200
        response = rawContent.responseBody

        carouselNode.type = ContentTypeEnums().PRODUCT

        for each recipe in response.products
            item = carouselNode.createChild("ProductContentNode")
            item.title = recipe.title
            item.description = recipe.description
            item.fhdPosterUrl = recipe.thumbnail
            item.type = carouselNode.type
        end for

        nextPageIndex = pageOffset + carouselNode.getChildCount()
        horizontalPaginationData = {
            totalCount: response.total
            nextPageIndex: nextPageIndex
            hasNextPage: response.total > nextPageIndex
        }

        carouselNode.horizontalPaginationData = horizontalPaginationData
    else

    end if

    return carouselNode
end function