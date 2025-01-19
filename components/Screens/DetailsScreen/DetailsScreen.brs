sub init()
    _bindComponents()
    _bindObservers()
    _initLocalVariables()
end sub

sub _bindComponents()
    m.title = m.top.findNode("title")
    m.description = m.top.findNode("description")
    m.releaseDate = m.top.findNode("releaseDate")
    m.actorList = m.top.findNode("actorList")
    m.poster = m.top.findNode("poster")
    m.director = m.top.findNode("director")
    m.videoCTA = m.top.findNode("videoCTA")
end sub

sub _bindObservers()
    m.top.observeField("content", "onContentChange")
    m.videoCTA.observeField("buttonSelected", "onPlayButtonSelected")
end sub

sub _initLocalVariables()
    m.searchRepo = m.global.searchRepo
    m.currentVideoProgress = 0
end sub

' In the video player screen, the progress of the video is being continuely tracked.
' Avoid page updates while that is happening
sub onPause()
    m.top.unobserveField("content")
end sub

sub onResume()
    if m.top.content.videoProgress <> m.currentVideoProgress
        progress = ["(", left((m.top.content.videoProgress * 100).toStr(), 4), "%)"].join("")
        m.videoCTA.text = ["Continue Watching", progress].join(" ")
    end if

    m.videoCTA.setFocus(true)
end sub

sub loadContent()
    videoSource = m.top.options?.videoSource
    if videoSource = invalid then return

    m.title.text = videoSource.title
    m.description.text = videoSource.description
    m.poster.uri = videoSource.fhdPosterUrl

    startLoadingSpinner()
    getMovieDetails(videoSource.id)
end sub

sub getMovieDetails(movieId as object)
    if movieId = invalid then return

    m.searchRepo.callFunc("getMovieDetails", m.top, movieId)
end sub

sub onContentChange()
    content = m.top.content

    m.poster.uri = content.fhdPosterUrl
    m.title.text = content.title
    m.description.text = content.description
    m.actorList.text = content.actors.join(chr(10))
    m.director.text = content.director

    setContentLoaded()
    m.videoCTA.setFocus(true)
end sub

sub initializeFocusedNode()
    ' Do not set the focus until the content is loaded
    ' m.videoCTA.setFocus(true)
    m.focusedNode = m.videoCTA
end sub

sub onPlayButtonSelected()
    m.global.navigateTo = {
        screenName: "VideoPlayer"
        screenOptions: {
            videoSource: m.top.content
        }
    }
end sub
