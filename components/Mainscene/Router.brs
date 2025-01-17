' This components handles the navigation between screens, keeping only one screen rendered at a time,
' to avoid excesive graphic resources consumption, caching the views not shown
function router(screenContainer as object) as object
    if m.router <> invalid then return m.router

    return {
        screenContainer: screenContainer

        screenStack: []

        currentScreen: invalid

        navigateToScreen: _navigateToScreen

        navigateToEntryPoint: _navigateToEntryPoint

        goBackToPreviousScreen: _goBackToPreviousScreen
    }
end function

function _navigateToEntryPoint(entryPointOptions as object)
    initialSection = entryPointOptions.initialSection
    if initialSection = invalid then initialSection = "HomeTab"

    screenName = "MainTabScreen"
    screenOptions = {
        sectionToLoad: initialSection
    }

    navigateOptions = {
        screenName: screenName
        screenOptions: screenOptions
    }

    m.navigateToScreen(navigateOptions)
end function

function _navigateToScreen(navigateOptions as object) as object
    newScreen = createObject("roSGNode", navigateOptions.screenName)
    if newScreen = invalid then return invalid

    if m.screenContainer.getChildCount() > 0 then m.screenContainer.removeChildrenIndex(m.screenContainer.getChildCount(), 0)

    m.screenContainer.appendChild(newScreen)

    ' Pause current screen
    currentScreen = m.screenStack.peek()
    if currentScreen <> invalid then currentScreen._onPause = true

    newScreen.options = navigateOptions.screenOptions
    newScreen.setFocus(true)
    newScreen._onCreate = true

    m.screenStack.push(newScreen)

    return newScreen
end function

function _goBackToPreviousScreen(navigateOptions = {} as object) as object
    if m.screenContainer.getChildCount() > 0 then m.screenContainer.removeChildrenIndex(m.screenContainer.getChildCount(), 0)

    m.screenStack.pop()

    if m.screenStack.count() > 0
        screenToShow = m.screenStack.peek()
        m.screenContainer.appendChild(screenToShow)
        screenToShow._onResume = true
    end if

    ' Return true if there are still screens in the stack
    return m.screenStack.count() > 0
end function
