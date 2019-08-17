setElementData(getLocalPlayer(), "qr.show", false, true)

-- Alpha variable to fade in
alpha = 0

-- Events
addEvent("onClientGotQrImage", true)
addEvent("removeQrImg", true)

-- Render Function
function render()
    if qrImg then
        local w,h = dxGetMaterialSize( qrImg )
        local sw, sh = guiGetScreenSize()
        dxDrawImage( sw/2-w/2, sh/2-h/2, w, h, qrImg, 0, 0, 0, tocolor(255,255,255,alpha))
    end
end

-- Draw Qr Code
addEventHandler("onClientGotQrImage", resourceRoot,
    function(pixels)
        -- if QrCode exists create other
        if qrImg then
            -- Remove Fade if exists
            if isTimer(timerFade) == true then killTimer(timerFade) end
            -- Reset Alpha
            alpha = 0
            -- Remove the QrCode
            removeEventHandler("onClientRender", root, render)
        end
        qrImg = dxCreateTexture( pixels )
        addEventHandler("onClientRender", root, render)
        
        -- QrCode Fade in
        timerFade = setTimer(function()
        alpha = alpha+2.7
        end, 0.1, 94)
    end
)

-- Remove Qr Code
addEventHandler("removeQrImg", resourceRoot,
    function()
        -- if QrCode exists remove 
        if qrImg then
            if getElementData(localPlayer, "qr.show") == true then
            destroyElement( qrImg )
            removeEventHandler("onClientRender", root, render)
            -- Reset Alpha
            alpha = 0
            end
        end
    end
)
