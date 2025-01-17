sub init()
    _bindComponents()
end sub

sub _bindComponents()
    m.container = m.top.findNode("container")
    m.thumbnail = m.top.findNode("thumbnail")
    m.title = m.top.findNode("title")
end sub

sub onItemContentChange(event as object)
    content = event.getData()
    typeEnums = ContentTypeEnums()

    if content.type = typeEnums.MOVIE
        createMovieItem()
    else if content.type = typeEnums.SERIES
        createSeriesItem()
    else if content.type = typeEnums.HUB
        createHubItem()
    else
        createMovieItem()
    end if
end sub

sub createMovieItem()
    itemContent = m.top.itemContent

    m.thumbnail.uri = itemContent.fhdPosterUrl
    m.title.text = itemContent.title
end sub

sub createSeriesItem()
    poster = m.container.createChild("Poster")
end sub

sub createHubItem()
    poster = m.container.createChild("Poster")
end sub
