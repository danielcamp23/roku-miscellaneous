sub init()
    _bindComponents()
end sub

sub _bindComponents()
    m.image = m.top.findNode("image")
    m.title = m.top.findNode("title")
    m.description = m.top.findNode("description")
end sub

sub onContentChange()
    content = m.top.content

    m.image.uri = content.fhdPosterUrl
    m.title.text = content.title
    m.description.text = content.description
end sub
