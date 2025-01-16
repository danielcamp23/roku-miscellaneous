sub init()
    _bindComponents()
    _bindObservers()
end sub

sub _bindComponents()
    m.title = m.top.findNode("title")
    m.description = m.top.findNode("description")
    m.poster = m.top.findNode("poster")
end sub

sub _bindObservers()

end sub

sub loadContent()
    videoSource = m.top.options?.videoSource
    if videoSource = invalid then return

    m.title.text = videoSource.title
    m.description.text = videoSource.description
    m.poster.uri = videoSource.fhdPosterUrl
end sub

sub initializeFocusedNode()
    m.title.setFocus(true)
    m.focusedNode = m.title
end sub