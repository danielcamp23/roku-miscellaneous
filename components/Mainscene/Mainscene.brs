sub init()
    _bindComponents()
    initializeGlobalField()
    initializeRepos()
    initializeRouter()
    initializeApp()
end sub

sub _bindComponents()
    m.screenContainer = m.top.findNode("screenContainer")
    m.loadingIndicator = m.top.findNode("loadingIndicator")
end sub


sub initializeGlobalField()
    m.global.addField("contentRepo", "node", false)
    m.global.addField("searchRepo", "node", false)
    m.global.addField("navigateTo", "assocarray", false)
    m.global.addField("toggleLoadingSpinner", "boolean", false)

    ' Global field node observers
    m.global.observeField("navigateTo", "onNavigateToChange")
    m.global.observeField("toggleLoadingSpinner", "onLoadingSpinnerToggle")
end sub

sub initializeRepos()
    omdb = parseJson(readAsciiFile("pkg:/config/omdb.json"))

    m.global.contentRepo = createObject("roSGNode", "ContentRepo")
    m.global.searchRepo = createObject("roSGNode", "searchRepo")

    m.global.searchRepo.omdbApiKey = omdb.apiKey
end sub


sub initializeRouter()
    m.router = router(m.screenContainer)
end sub

sub initializeApp()
    ' TODO: Add initialization step here. HTTP requst to get entry point, feature flags, etc

    ' initialSection = "SearchTab"
    initialSection = "HomeTab"
    screenConfig = {}
    navigateOptions = {
        initialSection: initialSection
        screenConfig: screenConfig
    }

    m.router.navigateToEntryPoint(navigateOptions)
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    if not press then return false

    handled = false
    if key = "back"
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

sub onLoadingSpinnerToggle(event as object)
    toggleLoadingSpinner = event.getData()

    if toggleLoadingSpinner
        m.loadingIndicator.visible = true
        m.loadingIndicator.control = "start"
    else
        m.loadingIndicator.visible = false
        m.loadingIndicator.control = "stop"
    end if
end sub
