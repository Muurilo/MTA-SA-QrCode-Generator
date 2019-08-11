function qrGen(playerToReceive, str, sizex, sizey)
    if sizex == nil or sizey == nil then 
        -- if no have custom size will draw in default size
        -- Default size recommended is 250
        sizex = 250
        sizey = 250
    end
    -- Check if the parameters of size is inside of range recommended
    if tonumber(sizex) > 24 and tonumber(sizex) < 561 and tonumber(sizey) > 24 and tonumber(sizey) < 561 then 
        -- Send information to an online api for Qr code generation
        fetchRemote ( "https://api.qrserver.com/v1/create-qr-code/?size="..sizex.."x"..sizey.."&data="..tostring(str), qrCallback, "", false, playerToReceive) 
    end
end

function qrCallback( responseData, errno, playerToReceive )
    if errno == 0 then
        -- Draw qr code on client
        triggerClientEvent( playerToReceive, "onClientGotQrImage", resourceRoot, responseData )
        setElementData(playerToReceive, "qr.show", true, true)     
    end
end

function qrCommand(player, commandName, ...)
    local arg = {...}
    -- remove qr code if no have arg
    if #arg == 0 then 
        triggerClientEvent(player, "removeQrImg", resourceRoot)
        show = false
    end

    -- Draw qr code in custom width and height
    if #arg == 3 then 
        qrGen(player, arg[1], arg[2], arg[3])
        -- If no have custom height draw with default size
        elseif #arg == 1 then 
        qrGen(player, arg[1])
    end

end
addCommandHandler('qr', qrCommand)