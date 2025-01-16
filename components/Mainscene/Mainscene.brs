sub init()
    _bindComponents()
    initializeGlobalField()
    initializeRepos()
    initializeRouter()
    initializeApp()
end sub

sub _bindComponents()
    m.screenContainer = m.top.findNode("screenContainer")
end sub


sub initializeGlobalField()
    m.global.addField("contentRepo", "node", false)
    m.global.addField("searchRepo", "node", false)
    m.global.addField("navigateTo", "assocarray", false)

    ' Global field observers
    m.global.observeField("navigateTo", "onNavigateToChange")
end sub

sub initializeRepos()
    m.global.contentRepo = createObject("roSGNode", "ContentRepo")
    m.global.searchRepo = createObject("roSGNode", "searchRepo")
end sub


sub initializeRouter()
    m.router = router(m.screenContainer)
end sub

sub initializeApp()
    ' TODO: Add initialization step here. HTTP requst to get entry point, feature flags, etc

    ' initialSection = "SearchTab"
    initialSection = "SearchTab"
    screenConfig = {}
    navigateOptions = {
        initialSection: initialSection
        screenConfig: screenConfig
    }

    ' m.router.navigateToSection(navigateOptions)
    m.router.navigateToEntryPoint(navigateOptions)
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    if not press then return false

    handled = false
    if key = "back"
        ?"event got to main scene"
        handled = m.router.goBackToPreviousScreen()
    else if key = "left"
        ' if m.
    end if

    ' TODO: handle all cases
    return handled
end function

sub onNavigateToChange(event as object)
    navigateToOptions = event.getData()

    m.router.navigateToScreen(navigateToOptions)
end sub