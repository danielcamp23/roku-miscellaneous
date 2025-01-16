sub init()
    _bindComponents()
    _bindObservers()
    _setupView()
end sub

sub _bindComponents()
    m.image = m.top.findNode("image")
    m.title = m.top.findNode("title")
    m.description = m.top.findNode("description")

    m.image.uri = "https://m.media-amazon.com/images/M/MV5BNWYxYzA4ZmItZGFjMS00ZTlmLWFkZDMtZDQ0MTE0MGNkYjcwXkEyXkFqcGc@._V1_SX300.jpg"
end sub

sub _bindObservers()

end sub

sub _setupView()

end sub

sub onContentChange()
    content = m.top.content

    m.image.uri = content.fhdPosterUrl
    m.title.text = content.title
    m.description.text = content.description
end sub
