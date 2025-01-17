sub init()
    _bindComponents()
    _bindObservers()
end sub

sub _bindComponents()
    m.videoNode = m.top.findNode("videoNode")
end sub

sub loadContent()
    m.videoNode.content = m.top.options.videoSource
    m.videoNode.control = "play"
end sub

sub initializeFocusedNode()
    m.videoNode.setFocus(true)
    m.focusedNode = m.videoNode
end sub