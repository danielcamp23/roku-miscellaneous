sub init()
    _bindComponents()
    _bindObservers()
    initializeTabController()
end sub

sub _bindComponents()
    m.menu = m.top.findNode("menu")
    m.container = m.top.findNode("container")
end sub

sub _bindObservers()
    m.menu.observeField("itemSelected", "onMenuItemSelectedChange")
end sub

sub onMenuItemSelectedChange(event as object)
    itemSelected = event.getData()

    sectionOptions = {
        sectionToLoad: itemSelected.tabName
    }

    m.tabController.navigateToSection(sectionOptions)

end sub
sub initializeFocusedNode()
    m.menu.setFocus(true)
    m.focusedNode = m.menu
end sub

sub loadContent()
    sectionOptions = m.top.options
    contentRepo = m.global.contentRepo

    m.tabController.navigateToSection(sectionOptions)
end sub

' Override to make the tab controllor handle the reAttach event
sub onReattach()
    m.tabController.reAttachSection()
end sub

sub initializeTabController()
    m.tabController = TabController(m.container)
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    if not press then return false

    handled = false
    if key = "back"
        ?"press back in home screen"
    else if key = "left"
        if m.container.isInFocusChain()
            m.menu.setFocus(true)
        end if

        handled = true
    else if key = "right"
        ?"key is rigght"
        if m.menu.isInFocusChain()
            m.container.getChild(0).setFocus(true)
        end if
    end if

    ' TODO: handle all cases
    return handled
end function

function createContentNode() as object
    parentNode = createObject("roSGNode", "ContentNode")

    for i = 0 to 5
        carouselNode = parentNode.createChild("ContentNode")
        carouselNode.title = "carousel N " + i.toStr()
        for j = 0 to 9
            carouselItem = carouselNode.createChild("ContentNode")
            carouselItem.title = "Item N " + j.toStr()
        end for
    end for

    return parentNode
end function