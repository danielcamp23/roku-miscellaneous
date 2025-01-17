sub init()
    _bindComponents()
    _bindObservers()
end sub

sub _bindComponents()
    m.videoNode = m.top.findNode("videoNode")
end sub

sub _bindObservers()
    m.videoNode.observeField("position", "onPositionChange")
end sub

sub onPositionChange()
    progress = m.videoNode.position / m.videoNode.duration
    m.top.options.videoSource.videoProgress = progress
end sub

sub loadContent()
    videoContentNode = createObject("roSGNode", "ContentNode")
    videoContentNode.url = m.top.options.videoSource.url
    videoContentNode.streamFormat = m.top.options.videoSource.streamFormat

    m.videoNode.content = videoContentNode
    m.videoNode.control = "play"
end sub

sub initializeFocusedNode()
    m.videoNode.setFocus(true)
    m.focusedNode = m.videoNode
end sub