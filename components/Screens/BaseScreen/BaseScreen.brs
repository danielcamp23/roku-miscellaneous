sub init()
    m.top.observeField("focusedChild", "onFocusedChildChange")
end sub


sub _bindComponents()
    ?"bind components in BaseScreen"
end sub

sub _initializeFocus()
    ?"initialize Focus"
end sub

sub _bindObservers()
    m.top.observeField("focusedChild", "onFocusedChildChange")
end sub

sub onFocusedChildChange()
    if NOT m.top.hasFocus() then return

    if m.focusedNode <> invalid
        m.focusedNode.setFocus(true)
    else
        initializeFocusedNode()
    end if
end sub

sub onCreate()
    loadContent()
end sub

sub onReattach()
    if m.focusedNode <> invalid then m.focusedNode.setFocus(true)
end sub

' Override in extended screens
sub loadContent()

end sub

' Override in extended screens
sub initializeFocusedNode()

end sub