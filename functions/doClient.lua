--|| ***************************************************************************************************************** [[
--|| PROJECT:       MTA Ingame Handling Editor
--|| FILE:          functions/doClient.lua
--|| DEVELOPERS:    Remi-X <rdg94@live.nl>
--|| PURPOSE:       Creating clientside functions
--||
--|| COPYRIGHTED BY REMI-X
--|| YOU ARE NOT ALLOWED TO MAKE MIRRORS OR RE-RELEASES OF THIS SCRIPT WITHOUT PERMISSION FROM THE OWNERS
--|| THIS RESOURCE HAS BEEN UPLOADED TO COMMUNITY.MTASA.COM
--|| ***************************************************************************************************************** ]]

--------------------------------------------------------------------------------------------------------------------------
--//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
--------------------------------------------------------------------------------------------------------------------------

function round ( num )
    if type(num)=="number" then
        return tonumber ( string.format ( "%.3f", num ) ) end
    return num
end

--------------------------------------------------------------------------------------------------------------------------
--//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
--------------------------------------------------------------------------------------------------------------------------

function updateHandlingData ( )
    local cVeh = getPedOccupiedVehicle ( localPlayer )
    if cVeh ~= lVeh then
        showData ( mProperty[1] )
        lVeh = cVeh
    else updateData ( cm ) end
end

--------------------------------------------------------------------------------------------------------------------------
--//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
--------------------------------------------------------------------------------------------------------------------------

function getDefaultHandling ( veh, handling )
    local data = getOriginalHandling ( veh )[handling]
    if type(data) == "table" then return round(data[1])..", "..round(data[2])..", "..round(data[3])
    elseif type(data) == "number" then
        if isInt[handling] then return string.format ( "%.0f", data )
        else return tostring ( round ( data ) ) end
    end
end

--------------------------------------------------------------------------------------------------------------------------
--//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
--------------------------------------------------------------------------------------------------------------------------

function unpackHandling ( str )
    local tbl = {}
    local i = 1
    for w in string.gmatch ( str, "[^%s]+" ) do
        if i==1 and not tonumber(w) then
            tbl[2] = w
            i=i+2
        else
            tbl[i] = w
            i=i+1
        end
    end
    return tbl
end

--------------------------------------------------------------------------------------------------------------------------
--//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
--------------------------------------------------------------------------------------------------------------------------

function packHandling ( veh )
    local hnd = getVehicleHandling ( veh )
    local mdl = getElementModel ( veh )
    local tbl = { mdl }
    --------------------------------------------------------
    for i=2,#hProperty do
        if hnd[ hProperty[i] ] then
            if type ( hnd[ hProperty[i] ] ) == "table" then
                tbl[i]      = hnd[ hProperty[i] ][1]
                tbl[i+1]    = hnd[ hProperty[i] ][2]
                tbl[i+2]    = hnd[ hProperty[i] ][3]
                i=i+3
            else
                tbl[i] = hnd[ hProperty[i] ]
            end
        else tbl[i] = 0
        end
    end
    --------------------------------------------------------
    local str = ""
    for k,v in ipairs ( tbl ) do
        str = str..v.." "
    end
    return str
end

--------------------------------------------------------------------------------------------------------------------------
--//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
--------------------------------------------------------------------------------------------------------------------------

function stopResource() triggerServerEvent("stopTheResource",resourceRoot)  end