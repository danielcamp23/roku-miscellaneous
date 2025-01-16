function TypeUtils_implementsInterface(value as object, iface as string) as boolean
    return value <> invalid AND getInterface(value, iface) <> invalid
end function

function TypeUtils_isString(value as object) as boolean
    return TypeUtils_implementsInterface(value, "ifString")
end function

function TypeUtils_isValidString(value as object) as boolean
    return TypeUtils_isString(value) AND value <> ""
end function

function TypeUtils_isStringable(value as object) as boolean
    return TypeUtils_implementsInterface(value, "ifToStr")
end function