sub init()
    _bindComponents()
    _bindObservers()
end sub

sub _bindComponents()
    m.title = m.top.findNode("title")
end sub

sub _bindObservers()

end sub


sub onItemContentChange(event as object)
    content = event.getData()

    m.title.text = content.itemName
end sub

sub onItemFocusChange(event as object)
    if m.top.itemHasFocus
        m.title.color = "#FFFFFF"
    else
        m.title.color = "#777777"
    end if
end sub
