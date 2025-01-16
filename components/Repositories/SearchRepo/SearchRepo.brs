sub init()
    m.searchTask = createObject("roSGNode", "SearchTask")
end sub

sub searchMovie(searchQuery as string, tabSection as object)
    m.tabSection = tabSection
    m.searchTask.functionName = "searchMovie"
    m.searchTask.searchQuery = searchQuery
    m.searchTask.control = "RUN"

    m.searchTask.unobserveField("content")
    m.searchTask.observeField("content", "onHomeContentChange")
end sub

sub getNextPage(gridContent as object)
    if NOT gridContent.horizontalPaginationData.hasNextPage then return
    if m.searchTask.state = "run" then return

    m.searchTask.unobserveField("content")

    m.searchTask.functionName = "getNextPage"
    m.searchTask.content = gridContent
    m.searchTask.control = "RUN"
end sub

sub onHomeContentChange(event as object)
    content = event.getData()
    ' ?"onHomeContentChange "content
    ' for each carousel in content.getChildren(-1, 0)
    '     for each item in carousel.getChildren(-1, 0)
    '         ?"parsing "item.title
    '     end for
    ' end for

    ?"initial content "content
    m.tabSection.content = content
end sub
