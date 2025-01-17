function parseRecipes(rawContent as object, pageOffset = invalid as object)
    carouselNode = createObject("roSGNode", "CarouselContentNode")
    if rawContent = invalid then return carouselNode

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

function parseProducts(rawContent as object, pageOffset as object)
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

        parentNode.type = ContentTypeEnums().PRODUCT

        for each recipe in response.products
            item = parentNode.createChild("ProductContentNode")
            item.title = recipe.title
            item.description = recipe.description
            item.fhdPosterUrl = recipe.thumbnail
            item.type = parentNode.type
        end for

        nextPageIndex = pageOffset + parentNode.getChildCount()
        horizontalPaginationData = {
            totalCount: response.total
            nextPageIndex: nextPageIndex
            hasNextPage: response.total > nextPageIndex
        }
    else
        ' TODO: return error here
    end if

    parentNode.horizontalPaginationData = horizontalPaginationData

    return parentNode
end function
