sub init()
    _bindComponents()
    _bindObservers()
end sub

sub _bindComponents()
    m.title = m.top.findNode("title")
    m.icon = m.top.findNode("icon")
end sub

sub _bindObservers()

end sub


sub onItemContentChange(event as object)
    content = event.getData()

    m.title.text = content.itemName
    m.icon.uri = content.itemLogo
end sub

sub onItemFocusChange(event as object)
    if m.top.itemHasFocus
        m.title.color = "#FFFFFF"
        m.icon.opacity = 1.0
    else
        m.title.color = "#777777"
        m.icon.opacity = 0.3
    end if
end sub
