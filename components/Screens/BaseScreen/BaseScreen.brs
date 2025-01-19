sub init()
    ' Do not call _bindObservers since it will invoke the functions in extended screens, resulting in a crash
    ' due to the initialization order of components.
    m.top.observeField("focusedChild", "onFocusedChildChange")
end sub

sub _bindObservers()

end sub

sub onFocusedChildChange()
    if NOT m.top.hasFocus() then return

    if m.focusedNode <> invalid
        m.focusedNode.setFocus(true)
    else
        initializeFocusedNode()
    end if
end sub

' Called when a screen is just created.
' This should start loading the content when needed.
sub onCreate()
    loadContent()
end sub

' Called when navigating back to a previous screen.
' If overriden in extended screens, make sure to handle the focus
sub onResume()
    if m.focusedNode <> invalid then m.focusedNode.setFocus(true)
end sub

' Callec when navigating to a new screen, the current page should use this to unobserve fields and do proper handling.
' Override in extended screens
sub onPause()

end sub

' Override in extended screens if needed
sub loadContent()
    startLoadingSpinner()
end sub

' Override in extended screens if needed
sub setContentLoaded()
    stopLoadingSpinner()
end sub

' Override in extended screens
sub initializeFocusedNode()

end sub

sub startLoadingSpinner()
    m.global.toggleLoadingSpinner = true
end sub

sub stopLoadingSpinner()
    m.global.toggleLoadingSpinner = false
end sub