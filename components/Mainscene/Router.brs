function router(screenContainer as object) as object
    if m.router <> invalid then return m.router

    return {
        screenContainer: screenContainer

        screenStack: []

        currentScreen: invalid

        navigateToScreen: _navigateToScreen

        navigateToSection: _navigateToSection

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

function _navigateToSection(navigateOptions as object) as object
    newScreen = createObject("roSGNode", navigateOptions.screenName)
    if newScreen = invalid then return invalid

    if m.screenContainer.getChildCount() > 0 then m.screenContainer.removeChildrenIndex(m.screenContainer.getChildCount(), 0)

    m.screenContainer.appendChild(newScreen)
    newScreen.options = navigateOptions.screenOptions
    newScreen._onCreate = true

    newScreen.setFocus(true)

    return newScreen
end function

function _navigateToScreen(navigateOptions as object) as object
    newScreen = createObject("roSGNode", navigateOptions.screenName)
    if newScreen = invalid then return invalid

    if m.screenContainer.getChildCount() > 0 then m.screenContainer.removeChildrenIndex(m.screenContainer.getChildCount(), 0)

    m.screenContainer.appendChild(newScreen)
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
        screenToShow._onReattach = true
    end if

    ' Return true if there are still screens in the stack
    return m.screenStack.count() > 0
end function

' function _getCurrentScreen()