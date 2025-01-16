sub init()
    m.contentTask = createObject("roSGNode", "ContentTask")
end sub

sub getHomeContent(screenSection as object)
    m.contentTask.unobserveField("content")
    m.contentTask.observeField("content", "onHomeContentChange")

    m.screenSection = screenSection
    m.contentTask.functionName = "getHomeContent"
    m.contentTask.control = "RUN"
end sub

sub getNextHorizontalPage(carouselToPaginate as object)
    if NOT carouselToPaginate.horizontalPaginationData.hasNextPage then return

    m.contentTask.unobserveField("content")
    m.carouselToPaginate = carouselToPaginate

    m.contentTask.functionName = "getNextHorizontalPage"
    m.contentTask.content = carouselToPaginate
    m.contentTask.control = "RUN"
end sub

sub onHomeContentChange(event as object)
    m.screenSection.content = event.getData()
end sub

sub searchMovie(searchQuery as string)
    m.searchTask.functionName = "searchTaskMovie"
    m.searchTask.searchQuery = searchQuery
    m.searchTask.control = "RUN"
end sub
