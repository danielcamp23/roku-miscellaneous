function TabController(sectionContainer as object) as object
    if m.tabController <> invalid then return m.tabController

    return {
        sectionContainer: sectionContainer

        sectionStack: []

        navigateToSection: _navigateTosection

        getFocusedNode: _getFocusedNode

        reAttachSection: _reAttachSection
    }
end function

function _navigateTosection(navigateOptions as object)
    sectionName = navigateOptions.sectionToLoad

    m.sectionContainer.removeChildrenIndex(-1, 0)

    sectionToShow = invalid
    for each section in m.sectionStack
        if lCase(section.name) = lCase(sectionName)
            sectionToShow = section
            exit for
        end if
    end for

    if sectionToShow = invalid then sectionToShow = createObject("roSGNode", sectionName)
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
    if activeSection <> invalid then activeSection._onReattach = true
end sub
