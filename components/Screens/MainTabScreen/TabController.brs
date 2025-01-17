' The tab controller's stack is not an actual stack as the router's
' The purpose of this "stack" is to recycle/cache the tabs created

function TabController(sectionContainer as object) as object
    if m.tabController <> invalid then return m.tabController

    return {
        sectionContainer: sectionContainer

        sectionStack: []

        navigateToSection: _navigateTosection

        getFocusedNode: _getFocusedNode

        reAttachSection: _reAttachSection

        pauseSection: _pauseSection
    }
end function

function _navigateTosection(navigateOptions as object)
    sectionName = navigateOptions.sectionToLoad

    m.sectionContainer.removeChildrenIndex(m.sectionContainer.getChildCount(), 0)

    sectionToShow = invalid
    for each section in m.sectionStack
        if lCase(section.subtype()) = lCase(sectionName)
            sectionToShow = section
            exit for
        end if
    end for

    if sectionToShow = invalid
        sectionToShow = createObject("roSGNode", sectionName)
        if sectionToShow = invalid then return invalid

        m.sectionStack.push(sectionToShow)
    end if

    m.sectionContainer.appendChild(sectionToShow)
    sectionToShow._onCreate = true
    sectionToShow.setFocus(true)

    return sectionToShow
end function

function _getFocusedNode()
    activeSection = m.sectionContainer.getChild(0)
    if activeSection <> invalid then return activeSection.focusedNode

    return invalid
end function

sub _reAttachSection()
    activeSection = m.sectionContainer.getChild(0)
    if activeSection <> invalid then activeSection._onResume = true
end sub

sub _pauseSection()
    activeSection = m.sectionContainer.getChild(0)
    if activeSection <> invalid then activeSection._onPause = true
end sub
