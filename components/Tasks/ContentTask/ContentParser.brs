function parseRecipes(rawContent as object, pageOffset = invalid as object)
    carouselNode = createObject("roSGNode", "CarouselContentNode")
    if rawContent = invalid then return carouselNode

    if pageOffset = invalid then pageOffset = 0

    if rawContent.statusCode = 200
        response = rawContent.responseBody
        carouselNode.type = ContentTypeEnums().RECIPE

        for each recipe in response.recipes
            item = carouselNode.createChild("RecipeContentNode")

            instructions = recipe.instructions
            if instructions = invalid then instructions = []

            ingredients = recipe.ingredients
            if ingredients = invalid then ingredients = []

            item.title = recipe.name
            item.instructions = instructions
            item.ingredients = ingredients
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

        for each product in response.products
            item = parentNode.createChild("ProductContentNode")

            reviews = product.reviews
            if reviews = invalid then reviews = []
            comments = []
            for each review in reviews
                comments.push(review.comment)
            end for

            item.title = product.title
            item.description = product.description
            item.fhdPosterUrl = product.thumbnail
            item.comments = comments
            item.availabilityStatus = product.availabilityStatus
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
