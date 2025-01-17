sub init()
    m.contentTask = createObject("roSGNode", "ContentTask")

    m.carouselIndex = 0
    m.sourceScreen = invalid
end sub

sub runTask(functionName as string, contentArgs as object)
    callbackMap = {
        "getHomeContent": "onHomeContentResponse"
        "getNextHorizontalPage": "onNextHorizontalPageResponse"
    }

    m.contentTask.unobserveField("content")
    m.contentTask.observeField("content", callbackMap[functionName])

    m.contentTask.functionName = functionName
    m.contentTask.contentArgs = contentArgs
    m.contentTask.control = "RUN"
end sub

sub getHomeContent(sourceScreen as object)
    m.sourceScreen = sourceScreen

    runTask("getHomeContent", {})
end sub

sub getNextHorizontalPage(sourceScreen as object, paginationData as object, pageType as object, carouselIndex as object)
    if m.contentTask.state = "run" then return
    if NOT TypeUtils_isValidString(pageType) then return
    if NOT TypeUtils_isValidInt(carouselIndex) then return
    if NOT paginationData.hasNextPage then return


    contentArgs = {
        pageType: pageType
        paginationData: paginationData
    }

    m.sourceScreen = sourceScreen
    m.carouselIndex = carouselIndex
    runTask("getNextHorizontalPage", contentArgs)
end sub

sub onHomeContentResponse()
    m.sourceScreen.content = m.contentTask.content
end sub

sub onNextHorizontalPageResponse()
    content = m.contentTask.content

    if content.getChildCount() > 0
        paginatedCarousel = m.sourceScreen.content.getChild(m.carouselIndex)
        paginatedCarousel.appendChildren(content.getChildren(-1, 0))
        paginatedCarousel.horizontalPaginationData = content.horizontalPaginationData
    end if
end sub
