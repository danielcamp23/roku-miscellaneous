sub init()
    _bindComponents()
    _bindObservers()
    _initLocalVariables()
end sub

sub _bindComponents()
    m.rowList = m.top.findNode("rowList")
    m.hero = m.top.findNode("hero")
end sub

sub _bindObservers()
    m.top.observeField("content", "onContentChange")
    m.top.observeField("focusedChild", "onFocusedChildChange")
    m.rowList.observeField("focusedChild", "onFocusedChildChange")
    m.rowList.observeField("rowItemFocused", "onRowItemFocusedChange")
end sub

sub _initLocalVariables()
    m.contentRepo = m.global.contentRepo

    m.itemFocused = {
        previousFocusedRow: 0
        previousFocusedCol: 0
    }
end sub

sub onCreate()
    m.contentRepo.callFunc("getHomeContent", m.top)
end sub

sub onRowItemFocusedChange(event as object)
    rowItemFocused = event.getData()
    focusedRow = rowItemFocused[0]
    focusedCol = rowItemFocused[1]

    if m.itemFocused.previousFocusedRow = focusedRow
        focusedRowNode = m.rowList.content.getChild(focusedRow)
        if m.itemFocused.previousFocusedCol < focusedCol AND (focusedCol >= focusedRowNode.getChildCount() - 2)
            paginationData = focusedRowNode.horizontalPaginationData
            pageType = focusedRowNode.type
            m.contentRepo.callFunc("getNextHorizontalPage", m.top, paginationData, pageType, focusedRow)
        end if
    else if m.itemFocused.previousFocusedRow < focusedRow and false
        m.contentRepo.callFunc("getNextVerticalPage", m.rowList.content)
    end if

    m.itemFocused = {
        previousFocusedRow: focusedRow
        previousFocusedCol: focusedCol
    }

    m.hero.content = m.rowList.content.getChild(focusedRow).getChild(focusedCol)
end sub

sub onFocusedChildChange()
    if m.top.hasFocus() then m.rowList.setFocus(true)
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    if not press then return false

    handled = false
    if key = "back"
        ?"press back in home screen"
    end if

    ' TODO: handle all cases
    return handled
end function

sub onContentChange()
    prepareRowList(m.top.content)
end sub

sub prepareRowList(rowListContent as object)
    m.rowList.content = rowListContent
end sub
