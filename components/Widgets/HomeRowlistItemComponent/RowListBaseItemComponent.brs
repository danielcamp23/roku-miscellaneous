sub init()
    _bindComponents()
    _bindObservers()
    _setupView()
end sub

sub _bindComponents()
    m.container = m.top.findNode("container")
end sub

sub _bindObservers()

end sub

sub _setupView()

end sub

sub onItemContentChange(event as object)
    m.container.removeChildrenIndex(m.container.getChildCount(), 0)

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
    poster = m.container.createChild("Poster")
    title = m.container.createChild("AppLabel")
    description = m.container.createChild("AppLabel")

    itemContent = m.top.itemContent
    poster.uri = itemContent.fhdPosterUrl
    poster.width = 300
    poster.height = 300
    poster.loadDisplayMode = "scaleToFit"

    title.text = itemContent.title
    title.fontUri = "pkg:/fonts/SofiaSans-Bold.ttf"
    title.fontSize = 24
    title.width = 300

    description.text = itemContent.description
    description.fontUri = "pkg:/fonts/SofiaSans-Regular.ttf"
    description.fontSize = 18
    description.width = 300
    description.maxLines = 3
    description.wrap = true
    description.lineSpacing = -3
end sub

sub createSeriesItem()
    poster = m.container.createChild("Poster")
end sub

sub createHubItem()
    poster = m.container.createChild("Poster")
end sub
