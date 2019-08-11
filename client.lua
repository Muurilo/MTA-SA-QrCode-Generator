setElementData(getLocalPlayer(), "qr.show", false, true)

-- Events
addEvent( "onClientGotQrImage", true )
addEvent( "removeQrImg", true )

-- Render Function
function render()
    if qrImg then
        local w,h = dxGetMaterialSize( qrImg )
        local sw, sh = guiGetScreenSize()
        dxDrawImage( sw/2-w/2, sh/2-h/2, w, h, qrImg )
    end
end

-- Draw Qr Code
addEventHandler( "onClientGotQrImage", resourceRoot,
    function( pixels )
        -- if QrCode exists create other
        if qrImg then
            removeEventHandler("onClientRender", root, render)
        end
        qrImg = dxCreateTexture( pixels )
        addEventHandler("onClientRender", root, render)
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
            end
        end
    end
)
