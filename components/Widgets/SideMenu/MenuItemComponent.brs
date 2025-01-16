sub init()
    _bindComponents()
    ' _bindObservers()
    ' _setupView()
end sub

sub _bindComponents()
    m.title = m.top.findNode("title")
end sub

sub _bindObservers()

end sub

sub _setupView()

end sub

sub onItemContentChange(event as object)
    content = event.getData()

    m.title.text = content.itemName
end sub
