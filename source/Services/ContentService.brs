function ContentService()
    return {
        httpComponent: HttpComponent()

        getProducts: function(args as object)
            nextPageIndex = args.nextPageIndex
            if nextPageIndex = invalid then nextPageIndex = 0

            url = "https://dummyjson.com/products"
            headers = {}
            qParams = {
                limit: 10
                skip: nextPageIndex
            }

            return m.httpComponent.get(url, headers, qParams)
        end function

        getRecipes: function(args as object)
            nextPageIndex = args.nextPageIndex
            if nextPageIndex = invalid then nextPageIndex = 0

            url = "https://dummyjson.com/recipes"
            headers = {}
            qParams = {
                limit: 10
                skip: nextPageIndex
            }

            return m.httpComponent.get(url, headers, qParams)
        end function
    }
end function