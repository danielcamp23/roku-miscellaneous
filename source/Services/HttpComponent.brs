function HttpComponent()
    return {
        xTransfer: createObject("roUrlTransfer")

        port: createObject("roMessagePort")

        get: function(url as object, headers = {} as object, qParams = {} as object) as object
            response = invalid
            m.xTransfer.setMessagePort(m.port)
            m.xTransfer.setUrl(url + "?" + m._buildQueryString(qParams))
            m.xTransfer.setHeaders(headers)
            m.xTransfer.setCertificatesFile("common:/certs/ca-bundle.crt")
            m.xTransfer.initClientCertificates()

            m.xTransfer.asyncGetToString()
            while true
                msg = wait(0, m.port)
                if msg <> invalid
                    reqUrl = url + "?" + m._buildQueryString(qParams)
                    ?"req to "reqUrl
                    if msg.getResponseCode() = 200
                        response = {
                            "statusCode": msg.getResponseCode()
                            "responseBody": parseJson(msg.getString())
                        }
                    else
                        response = {
                            "statusCode": msg.getResponseCode()
                            "responseBody": invalid
                        }
                    end if

                    exit while
                end if
            end while

            return response
        end function

        _buildQueryString: function(qParams as object) as object
            if qParams.count() = 0 then return ""

            queryString = ""
            for each entry in qParams.items()
                key = entry.key
                value = entry.value

                valueStr = ""
                if TypeUtils_isString(value)
                    valueStr = value
                else if TypeUtils_isStringable(value)
                    valueStr = value.toStr()
                end if

                if TypeUtils_isValidString(key) AND TypeUtils_isValidString(valueStr)
                    queryString = queryString + "&" + key + "=" + valueStr
                end if
            end for

            ' remove the leading "&"
            if queryString.len() > 0 then queryString = queryString.mid(1)

            return queryString
        end function
    }
end function
