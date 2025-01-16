sub init()
    m.top.functionName = "getHomeContent"
end sub

sub getHomeContent()
    m.contentService = ContentService()

    firstCarouselResponse = m.contentService.getProducts()
    secondCarouselResponse = m.contentService.getRecipes()

    contentNode = m.top.content

    pageNode = createObject("roSGNode", "ContentNode")
    productsCarousel = parseProducts(firstCarouselResponse)
    recipesCarousel = parseRecipes(secondCarouselResponse)
    ?"productsCarousel.horizontalPaginationData "productsCarousel.horizontalPaginationData
    ?"recipesCarousel.horizontalPaginationData "recipesCarousel.horizontalPaginationData
    pageNode.appendChild(productsCarousel)
    pageNode.appendChild(recipesCarousel)

    ?"first carousel "pageNode.getChild(0).getChildCount()
    ?"second carousel "pageNode.getChild(1).getChildCount()
    m.top.content = pageNode
end sub

sub getNextHorizontalPage()
    m.contentService = ContentService()

    carouselToPaginate = m.top.content
    carouselToPaginate.queueFields(true)

    if carouselToPaginate.type = ContentTypeEnums().PRODUCT
        response = m.contentService.getProducts(carouselToPaginate.horizontalPaginationData)
        carouselNode = parseProducts(response, carouselToPaginate.horizontalPaginationData)
        carouselToPaginate.appendChildren(carouselNode.getChildren(-1, 0))
        carouselToPaginate.horizontalPaginationData = carouselNode.horizontalPaginationData
    else if carouselToPaginate.type = ContentTypeEnums().RECIPE
        response = m.contentService.getRecipes(carouselToPaginate.horizontalPaginationData)
        carouselNode = parseRecipes(response, carouselToPaginate.horizontalPaginationData)
        carouselToPaginate.appendChildren(carouselNode.getChildren(-1, 0))
        carouselToPaginate.horizontalPaginationData = carouselNode.horizontalPaginationData
    end if

    carouselToPaginate.queueFields(false)
end sub