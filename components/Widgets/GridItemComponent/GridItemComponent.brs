sub init()
    _bindComponents()
    _bindObservers()
    _setupView()
end sub

sub _bindComponents()
    m.thumbnail = m.top.findNode("thumbnail")
end sub

sub _bindObservers()

end sub

sub _setupView()

end sub

sub onItemContentChange(event as object)
    content = m.top.itemContent
    m.thumbnail.uri = content.fhdPosterUrl
end sub
