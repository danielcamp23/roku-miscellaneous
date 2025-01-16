sub main()
    screen = createObject("roSGScreen")
    port = createObject("roMessagePort")
    screen.setMessagePort(port)

    scene = screen.createScene("MainScene")
    screen.show()

    while true
        msg = wait(0, port)
        msgType = type(msg)

        if msg = "roSGScreenEvent"
            if msg.isScreenClosed() then return
        end if
    end while
end sub
