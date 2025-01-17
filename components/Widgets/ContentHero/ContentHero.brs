sub init()
    _bindComponents()
end sub

sub _bindComponents()
    m.image = m.top.findNode("image")
    m.title = m.top.findNode("title")
    m.description = m.top.findNode("description")
    m.ingredientList = m.top.findNode("ingredientList")
    m.instructionList = m.top.findNode("instructionList")
    m.firstColumnLabel = m.top.findNode("firstColumnLabel")
    m.secondColumnLabel = m.top.findNode("secondColumnLabel")
end sub

sub onContentChange()
    content = m.top.content

    ' m.image.uri = content.fhdPosterUrl
    m.title.text = content.title
    m.description.text = content.description

    if content.type = ContentTypeEnums().RECIPE
        m.firstColumnLabel.text = "Ingredients:"
        m.secondColumnLabel.text = "Instructions:"
        m.ingredientList.text = content.ingredients.join(chr(10))
        m.instructionList.text = content.instructions.join(chr(10))
    else
        m.firstColumnLabel.text = "Stock Info:"
        m.secondColumnLabel.text = "Reviews:"
        m.ingredientList.text = content.availabilityStatus
        m.instructionList.text = content.comments.join(chr(10))
    end if
end sub
