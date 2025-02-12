sub init()
    _bindComponents()
    _bindObservers()
    _setupView()
end sub

sub _bindComponents()
    m.menuList = m.top.findNode("menuList")
    m.container = m.top.findNode("container")
    m.trAnimation = m.top.findNode("trAnimation")
    m.trInterpolator = m.top.findNode("trInterpolator")
end sub

sub _bindObservers()
    m.top.observeField("focusedChild", "onFocusedChildChange")
    m.menuList.observeField("itemFocused", "onItemFocusedChange")
    m.menuList.observeField("itemSelected", "onMenuItemSelectedChange")
end sub

sub onItemFocusedChange(event as object)
    itemFocused = event.getData()
end sub


sub onMenuItemSelectedChange(event as object)
    itemSelected = event.getData()

    m.top.itemSelected = m.menuList.content.getChild(itemSelected)
end sub

sub _setupView()
    focusedTargetSet1 = createObject("roSGNode", "TargetSet")
    focusedTargetSet1.targetRects = getTargetRects(1)
    focusedTargetSet1.focusIndex = 0

    focusedTargetSet2 = createObject("roSGNode", "TargetSet")
    focusedTargetSet2.targetRects = getTargetRects(2)
    focusedTargetSet2.focusIndex = 1

    ' focusedTargetSet3 = createObject("roSGNode", "TargetSet")
    ' focusedTargetSet3.targetRects = getTargetRects(3)
    ' focusedTargetSet3.focusIndex = 2

    unfocusedTargetSet = createObject("roSGNode", "TargetSet")
    unfocusedTargetSet.targetRects = getTargetRects(100)


    m.menuList.focusedTargetSet = [ focusedTargetSet1, focusedTargetSet2 ]
    m.menuList.unfocusedTargetSet = unfocusedTargetSet
    m.menuList.targetSet = focusedTargetSet1
    ' m.menuList.showTargetRects = true

    m.menuList.content = setupMenuItems()
end sub

function getMenuConfig() as object
    menuOptions = [
        {
            index: 0
            itemName: "Home"
            tabName: "HomeTab"
            itemLogo: "home-icon"
        }
        {
            index: 1
            itemName: "Search"
            tabName: "SearchTab"
            itemLogo: "search-icon"
        }
        ' {
        '     index: 2
        '     itemName: "User"
        '     tabName: "UserTab"
        '     itemLogo: ""
        ' }
    ]

    return menuOptions
end function

function getTargetRects(targetSetIndex as integer)
    unfocusedWidth = 240
    unfocusedHeight = 134

    focusedWidth = 260
    focusedHeight = 150
    targetRect = []

    yAccum = 0
    for i = 0 to 7
        x = 0
        y = yAccum

        height = unfocusedHeight
        width = unfocusedWidth
        if i = targetSetIndex - 1
            height = focusedHeight
            width = focusedWidth
        end if

        yAccum += height

        targetRect.push( {x: x, y: y, height: height, width: width } )
    end for

    return targetRect
end function

function setupMenuItems() as object
    menuOptions = getMenuConfig()
    parentNode = createObject("roSGNode", "ContentNode")

    for each menuItem in menuOptions
        item = parentNode.createChild("MenuItemContentNode")
        item.update({
            itemName: menuItem.itemName
            tabName: menuItem.tabName
            itemLogo: ["pkg:/assets/images/icons/", menuItem.itemLogo, ".png"].join("")
        })
    end for

    return parentNode
end function

sub onFocusedChildChange()
    initialTranslation = m.container.translation
    finalTranslation = [-1, -1]

    if m.top.hasFocus()
        m.menuList.setFocus(true)
        finalTranslation = [0, 0]
    else
        finalTranslation = [-300, 0]
    end if

    m.trInterpolator.keyValue = [initialTranslation, finalTranslation]
    m.trAnimation.control = "start"
end sub
