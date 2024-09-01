port = property.getNumber("Port")

position = {}
respponseMessage = ""
resultDistance = ""

function onTick()
    isSendGetRequest = input.getBool(1)
    isCalcDisntace = input.getBool(2)
    position[1] = {x = input.getNumber(1), y = input.getNumber(2)}
    position[2] = {x = input.getNumber(3), y = input.getNumber(4)}

    if isSendGetRequest then
        async.httpGet(port, "/hello")
    elseif isCalcDisntace then
        url = string.format("/calc?x[]=%f&y[]=%f&x[]=%f&y[]=%f", position[1].x, position[1].y, position[2].x, position[2].y)
        async.httpGet(port, url)
    end
end

function httpReply(_, requestBody, responseBody)
    if string.startWith(requestBody, "/hello") then
        respponseMessage = responseBody
    end
    if string.startWith(requestBody, "/calc") then
        resultDistance = responseBody
    end
end

function string.startWith(text,start)
    return string.sub(text, 1, string.len(start)) == start
end

function onDraw()
    centerWidth = screen.getWidth() / 2

    -- Hello Message
    screen.drawText(10, 10, respponseMessage)
    
    -- Distance Calc Result
    screen.drawText(centerWidth, 10, "Pos1")
    screen.drawText(centerWidth, 20, string.format("x: %f", position[1].x))
    screen.drawText(centerWidth, 26, string.format("y: %f", position[1].y))
    screen.drawText(centerWidth, 37, "Pos2")
    screen.drawText(centerWidth, 47, string.format("x: %f", position[2].x))
    screen.drawText(centerWidth, 53, string.format("y: %f", position[2].y))
    screen.drawText(centerWidth, 70, "Result")
    screen.drawText(centerWidth, 80, resultDistance)
end
