sub init()
    _bindComponents()
    _bindObservers()
    _initLocalVariables()
    initializeFocusedNode()
end sub

sub _bindComponents()
    m.hero = m.top.findNode("hero")
    m.keyboard = m.top.findNode("keyboard")
    m.markupGrid = m.top.findNode("markupGrid")
    m.errorLabel = m.top.findNode("errorLabel")
end sub

sub _bindObservers()
    m.keyboard.observeField("text", "onTextChange")
    m.markupGrid.observeField("itemFocused", "onItemFocusedChange")
    m.markupGrid.observeField("itemSelected", "onItemSelectedChange")
end sub

sub _initLocalVariables()
    m.searchRepo = m.global.searchRepo

    m.searchTimer = createObject("roSGNode", "Timer")
    m.searchTimer.duration = 3
    m.searchTimer.observeField("fire", "onTimerEvent")

    m.lastItemfocused = 0
end sub

sub initializeFocusedNode()
    m.keyboard.setFocus(true)
    m.focusedNode = m.keyboard
end sub

sub onTimerEvent()
    m.searchRepo.callFunc("searchMovies", m.top, m.keyboard.text)
end sub

sub onItemFocusedChange(event as object)
    itemfocused = event.getData()

    availableRows = cInt(m.markupGrid.content.getChildCount() / m.markupGrid.numColumns)
    focusedRow = cInt(itemFocused / m.markupGrid.numColumns)

    if focusedRow >= availableRows - 1 ' If we are 3 rows above the last one, get next page
        m.lastItemfocused = itemfocused
        m.searchRepo.callFunc("getNextPage", m.top, m.markupGrid.content.horizontalPaginationData)
    end if

    m.hero.content = m.markupGrid.content.getChild(itemfocused)
end sub

sub onItemSelectedChange(event as object)
    itemSelected = event.getData()

    m.global.navigateTo = {
        screenName: "DetailsScreen"
        screenOptions: {
            videoSource: m.markupGrid.content.getChild(itemSelected)
        }
    }

    m.focusedNode = m.markupGrid
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    if not press then return false

    handled = false
    if key = "back"
        if m.markupGrid.isInFocusChain()
            m.keyboard.setFocus(true)
            m.focusedNode = m.keyboard
            handled = true
        end if
    else if key = "right"
        if m.keyboard.isInFocusChain()
            m.markupGrid.setFocus(true)
            m.focusedNode = m.markupGrid
        end if
        handled = true
    else if key = "left"
        if m.markupGrid.isInFocusChain()
            m.keyboard.setFocus(true)
            m.focusedNode = m.keyboard
            handled = true
        end if
    end if

    ' TODO: handle all cases
    return handled
end function

sub onTextChange()
    text = m.keyboard.text
    m.searchTimer.control = "stop"

    if len(text) > 3 then m.searchTimer.control = "start"
end sub

sub onContentChange()
    m.markupGrid.content = m.top.content
    m.markupGrid.jumpToItem = m.lastItemfocused

    showNoMoviesError = m.top.content = invalid OR m.top.content.getChildCount() = 0
    m.errorLabel.visible = showNoMoviesError
    if showNoMoviesError then m.hero.content = createObject("roSGNode", "ContentNode")
end sub
