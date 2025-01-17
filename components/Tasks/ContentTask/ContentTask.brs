sub init()
    m.top.functionName = "getHomeContent"
end sub

sub getHomeContent()
    m.contentService = ContentService()
    contentArgs = m.top.contentArgs

    contentArgs["nextPageIndex"] = 0

    firstCarouselResponse = m.contentService.getProducts(contentArgs)
    secondCarouselResponse = m.contentService.getRecipes(contentArgs)

    pageNode = createObject("roSGNode", "ContentNode")
    productsCarousel = parseProducts(firstCarouselResponse, contentArgs.nextPageIndex)
    recipesCarousel = parseRecipes(secondCarouselResponse, contentArgs.nextPageIndex)

    pageNode.appendChild(productsCarousel)
    pageNode.appendChild(recipesCarousel)

    m.top.content = pageNode
end sub

sub getNextHorizontalPage()
    m.contentService = ContentService()
    contentArgs = m.top.contentArgs

    contentArgs["nextPageIndex"] = contentArgs.paginationData.nextPageIndex

    carouselNode = invalid
    if contentArgs.pageType = ContentTypeEnums().PRODUCT
        response = m.contentService.getProducts(contentArgs.paginationData)
        carouselNode = parseProducts(response, contentArgs.nextPageIndex)
    else if contentArgs.pageType = ContentTypeEnums().RECIPE
        response = m.contentService.getRecipes(contentArgs.paginationData)
        carouselNode = parseRecipes(response, contentArgs.nextPageIndex)
    end if

    m.top.content = carouselNode
end sub
