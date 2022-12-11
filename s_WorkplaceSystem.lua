db = dbConnect("sqlite","files/results.db")
local markerlar = { }
local px,py,pz
local girismarkerlari = { }
local isyerisatinalmasiniri = 2
local kiradancikma = "kiradancik"

local interiorlar = {
     ["Galeri"] = {
        [1] = { -2159.122802,641.517517,1052.381713,1 },
        [2] = { 1302.519897,-1.787510,1001.028259,18 },
        [3] = { 1412.14,-2.28,1000.92,1 },
        [4] = { 621.45,-23.72,1000.92,1 },
     },
     ["Silahçı"] = {
        [1] = { 315.24,-140.88,999.60,7 },
        [2] = { 285.83,-39.01,1001.51,1 },
        [3] = { 291.76,-80.13,1001.51,4 },
        [4] = { 297.14,-109.87,1001.51,6 },
     },
     ["Kıyafetçi"] = {
        [1] = { 207.52,-109.74,1005.13,15 },
        [2] = { 204.16,-165.76,1000.52,14 },
        [3] = { 161.40,-94.24,1001.80,18 },
        [4] = { 204.11,-46.80,1001.80,1 },
     },
}

addEventHandler("onResourceStart",getRootElement(),function()
    results = dbPoll(dbQuery(db,"SELECT * FROM veriler"),-1)
    for i,v in pairs(results) do
        local lokasyon = fromJSON(v["xyz"])
        local x,y,z = unpack(lokasyon)
        local id = v["id"]
        local tur = v["turu"]
        local mekan = v["mekan"]
        local marker = createMarker ( x, y, z+1, "arrow", 1.2, 255, 127, 0, 170 )
        table.insert(markerlar,{marker,id,tur,mekan})
        addEventHandler("onMarkerHit",marker,markeragiris)
    end
end)


addEvent("WorkPlaceSystem:CreateWorkPlace",true)
addEventHandler("WorkPlaceSystem:CreateWorkPlace",getRootElement(),function(id,sahip,tur,fiyat,mekan,kilit)
    local result = dbPoll(dbQuery(db,"SELECT * FROM veriler"),-1)
    for i,v in pairs(result) do
        if tostring(id) == tostring(v["id"]) then
            outputChatBox("#FF0000[BİLGİLENDİRME] #FFFFFFBu Sıra Numarası zaten kullanılıyor",source,255,255,255,true) return
        end
    end
    if tonumber(fiyat) <= 0 then outputChatBox("#FF0000[BİLGİLENDİRME] #FFFFFFFiyat 0 veya daha düşük bir fiyat olamaz.",source,255,255,255,true) return end
    local x,y,z = getElementPosition(source)
    local tablo = {tostring(x),tostring(y),tostring(z)}
    local konum = toJSON(tablo)
    dbExec(db,"INSERT INTO veriler (id,sahip,turu,kilit,fiyati,kiraci,xyz,durum,mekan,kirafiyati) VALUES (?,?,?,?,?,?,?,?,?,?)",id,sahip,tur,kilit,fiyat,"-",konum,"Satılık",tonumber(mekan),"-")
    local marker = createMarker ( x, y, z+1, "arrow", 1.2, 255, 127, 0, 170 )
    addEventHandler("onMarkerHit",marker,markeragiris)
    table.insert(markerlar,{marker,id,tur,mekan})
    outputChatBox("Başarıyla #ff7f00Yeni Bir İşyeri #ffffffOluşturdunuz!",source,255,255,255,true)
    outputChatBox("#ff7f00● #ffffffİşyeri Sırası: #ff7f00"..id.."#ffffff ✔",source,255,255,255,true)
    outputChatBox("#ff7f00● #ffffffİşyeri Sahibi: #ff7f00"..sahip.."#ffffff ✔",source,255,255,255,true)
    outputChatBox("#ff7f00● #ffffffİşyeri Türü: #ff7f00"..tur.."#ffffff ✔",source,255,255,255,true)
    outputChatBox("#ff7f00● #ffffffİşyeri Fiyatı: #ff7f00"..fiyat.."#ffffff ✔",source,255,255,255,true)
    triggerClientEvent(source,"WorkPlaceSystem:CreatePanel",source,false)
end)

addEvent("WorkPlaceSystem:UpdateWorkPlace",true)
addEventHandler("WorkPlaceSystem:UpdateWorkPlace",getRootElement(),function(id,sahip,tur,fiyat,mekan,kilit,defid)
    local result = dbPoll(dbQuery(db,"SELECT * FROM veriler"),-1)
    for i,v in pairs(result) do
        if tostring(id) == tostring(v["id"]) and tostring(id) ~= tostring(defid) then
            outputChatBox("#FF0000[BİLGİLENDİRME] #FFFFFFBu Sıra Numarası zaten kullanılıyor",source,255,255,255,true) return
        end
    end
    if tonumber(fiyat) <= 0 then outputChatBox("#FF0000[BİLGİLENDİRME] #FFFFFFFiyat 0 veya daha düşük bir fiyat olamaz.",source,255,255,255,true) return end
    dbExec(db,"UPDATE veriler SET id = ?,sahip = ?,turu = ?,kilit = ?,fiyati = ?,mekan = ? WHERE id = ?",id,sahip,tur,kilit,fiyat,tonumber(mekan),defid)
    for i,v in pairs(markerlar) do 
        if tostring(v[2]) == tostring(defid) then
            v[2] = id
            v[3] = tur
            v[4] = mekan
        end
    end
    outputChatBox("Başarıyla #ff7f00Yeni Bir İş Yeri #ffffffDüzenlendiniz!",source,255,255,255,true)
    outputChatBox("#ff7f00● #ffffffİşyeri Sırası: #ff7f00"..id.."#ffffff ✔",source,255,255,255,true)
    outputChatBox("#ff7f00● #ffffffİşyeri Sahibi: #ff7f00"..sahip.."#ffffff ✔",source,255,255,255,true)
    outputChatBox("#ff7f00● #ffffffİşyeri Türü: #ff7f00"..tur.."#ffffff ✔",source,255,255,255,true)
    outputChatBox("#ff7f00● #ffffffİşyeri Fiyatı: #ff7f00"..fiyat.."#ffffff ✔",source,255,255,255,true)
    outputChatBox("#ff7f00● #ffffffİşyeri Mekan: #ff7f00"..mekan.."#ffffff ✔",source,255,255,255,true)
    if tonumber(kilit) == 1 then
    outputChatBox("#ff7f00● #ffffffİşyeri Kilidi: #ff7f00Kilitli#ffffff ✔",source,255,255,255,true)
    else
        outputChatBox("#ff7f00● #ffffffİşyeri Kilidi: #ff7f00Kilitsiz#ffffff ✔",source,255,255,255,true)
    end
    for i,v in pairs(girismarkerlari) do 
        if tostring(v[1]) == tostring(id) then
            destroyElement(v[2])
            table.remove(girismarkerlari,i)
        end
    end
    triggerClientEvent(source,"WorkPlaceSystem:CreatePanel",source,false)
end)

addEvent("WorkPlaceSystem:DeleteWorkPlace",true)
addEventHandler("WorkPlaceSystem:DeleteWorkPlace",getRootElement(),function(id)
    dbExec(db,"DELETE FROM veriler WHERE id = ?",id)
    for i,v in pairs(markerlar) do
        if tostring(v[2]) == tostring(id) then
            destroyElement(v[1])
            table.remove(markerlar,i)
        end
    end
    outputChatBox("#FF0000[BİLGİLENDİRME] #FFFFFFBaşarıyla #FF0000"..id..". Sıra Numarasına#FFFFFF Sahip İşyeri silindi.",source,255,255,255,true)
    triggerClientEvent(source,"WorkPlaceSystem:CreatePanel",source,false)
end)

function markeragiris(oyuncu)
    local id
    for i,v in pairs(markerlar) do
        if v[1] == source then
            id = v[2]
        end
    end
    local result = dbPoll(dbQuery(db,"SELECT * FROM veriler WHERE id = ?",tonumber(id)),-1)
    triggerClientEvent(oyuncu,"WorkPlaceSystem:LogIN",oyuncu,result,id)
end

addCommandHandler("isyeriolustur",function(oyuncu)
    hesap = getAccountName(getPlayerAccount(oyuncu))
    if isObjectInACLGroup("user."..hesap, aclGetGroup("Console")) then
        local results = dbPoll(dbQuery(db,"SELECT * FROM veriler ORDER BY id ASC"),-1)
        triggerClientEvent(oyuncu,"WorkPlaceSystem:CreatePanel",oyuncu,true,results)
    end
end)

addEvent("WorkPlaceSystem:BuyToWorkPlace",true)
addEventHandler("WorkPlaceSystem:BuyToWorkPlace",getRootElement(),function(id)
    local hesap = getAccountName(getPlayerAccount(source))
    local parasi = getElementData(source, "banka:para") or 0
    local isyerifiyati
    local durum
    local isyerisayisi = 0
    local isyerisahibi
    local tur
    local results = dbPoll(dbQuery(db,"SELECT * FROM veriler"),-1)
    for i,v in pairs(results) do
        if tostring(v["id"]) == tostring(id) then
            if tostring(hesap) == tostring(v["sahip"]) then
                outputChatBox("#FF0000[BİLGİLENDİRME] #ffffffKendi İşyerinizi satın alamazsınız.",source,255,255,255,true)
                return
            end
            durum = v["durum"]
            isyerifiyati = v["fiyati"]
            isyerisahibi = v["sahip"]
            tur = v["turu"]
        end
        if tostring(v["sahip"]) == tostring(hesap) then
            isyerisayisi = isyerisayisi + 1
        end
    end
    if tostring(durum) == "Satılık" then
        if tonumber(parasi) >= tonumber(isyerifiyati) then
            if isyerisatinalmasiniri > isyerisayisi then
                local gonderilecek = 0 - tonumber(isyerifiyati)
                triggerEvent("gecmis:ekle", root, hesap, "Bir İşyeri Satın Aldınız! İşyeri Sıra Numarası: "..id)
                triggerEvent("gecmis:ekle", root, isyerisahibi, "Bir İşyeri Sattınız! Satılan İşyeri Sıra Numarası: "..id)
                triggerEvent("para:ekle", root, isyerisahibi, tonumber(isyerifiyati))
                triggerEvent("para:ekle", root, hesap, tonumber(gonderilecek))
                dbExec(db,"UPDATE veriler SET sahip = ?, durum = ? WHERE id = ?",hesap,"Faaliyette",id)
                outputChatBox("#ff7f00● #ffffffBaşarıyla Bir İşyeri Satın Aldınız!",source,255,255,255,true)
                outputChatBox("#ff7f00● #ffffffİşyeri Sırası: #ff7f00"..tostring(id).."#ffffff ✔",source,255,255,255,true)
                outputChatBox("#ff7f00● #ffffffİşyeri Türü: #ff7f00"..tostring(tur).."#ffffff ✔",source,255,255,255,true)
                outputChatBox("#ff7f00● #ffffffİşyeri Fiyatı: #ff7f00"..tostring(isyerifiyati).."#ffffff ✔",source,255,255,255,true)
                outputChatBox("#ff7f00● #ffffffİşyeri Önceki Sahibi: #ff7f00"..tostring(isyerisahibi).."#ffffff ✔",source,255,255,255,true)
                outputChatBox("#ff7f00● #ffffffİşyeri Yeni Sahibi: #ff7f00"..tostring(hesap).."#ffffff ✔",source,255,255,255,true)
                triggerClientEvent(source,"WorkPlaceSystem:GirisClose",source)
            else
                outputChatBox("#FF0000[BİLGİLENDİRME] #ffffffİşyeri satın alma sınırına ulaştığınız için, satın alamadınız. Satın alma sınırı: #ff0000"..tostring(isyerisatinalmasiniri),source,255,255,255,true)
            end
        else
            outputChatBox("#FF0000[BİLGİLENDİRME] #ffffffBu işyerini satın almak için, bankada yeterli paranız yok. İşyeri Fiyatı: #ff0000"..tostring(isyerifiyati),source,255,255,255,true)
        end
    else
        outputChatBox("#FF0000[BİLGİLENDİRME] #ffffffBu işyeri satılık değil. İşyeri Durumu: #ff0000"..tostring(durum),source,255,255,255,true)
    end
end)

addEvent("WorkPlaceSystem:RentToWorkPlace",true)
addEventHandler("WorkPlaceSystem:RentToWorkPlace",getRootElement(),function(id)
    local hesap = getAccountName(getPlayerAccount(source))
    local parasi = getElementData(source, "banka:para") or 0
    local durum
    local isyerisahibi
    local kirafiyati
    local tur
    local veriler = dbPoll(dbQuery(db,"SELECT * FROM veriler"),-1)
    for i,v in pairs(veriler) do
        if tostring(v["id"]) == tostring(id) then
            if tostring(hesap) == tostring(v["sahip"]) then
                outputChatBox("#FF0000[BİLGİLENDİRME] #ffffffKendi İşyerinizi kiralayamazsınız.",source,255,255,255,true)
                return
            end
            durum = v["durum"]
            isyerisahibi = v["sahip"]
            kirafiyati = v["kirafiyati"]
            tur = v["turu"]
        end
        if tostring(hesap) == tostring(v["kiraci"]) then
            outputChatBox("#FF0000[BİLGİLENDİRME] #ffffffSadece 1 işyeri kiralayabilirsiniz. Kiradan çıkmak için /"..kiradancikma.." komutunu kullanın.",source,255,255,255,true)
            return
        end
    end
    if tostring(durum) == "Kiralık" then
        if tonumber(parasi) >= tonumber(kirafiyati) then
            local gonderilecek = 0 - tonumber(kirafiyati)
            triggerEvent("gecmis:ekle", root, hesap, "Bir İşyeri Kiraladınız! İşyeri Sıra Numarası: "..id.." Kiralama Fiyatı: "..tostring(kirafiyati))
            triggerEvent("gecmis:ekle", root, isyerisahibi, "İşyeriniz Başka bir oyuncu tarafından kiralandı! İşyeri Sıra Numarası: "..id.." Kazanç: "..tostring(kirafiyati))
            triggerEvent("para:ekle", root, isyerisahibi, tonumber(kirafiyati))
            triggerEvent("para:ekle", root, hesap, tonumber(gonderilecek))
            dbExec(db,"UPDATE veriler SET kiraci = ?, durum = ? WHERE id = ?",hesap,"Kirada",id)
            outputChatBox("#ff7f00● #ffffffBaşarıyla Bir İşyeri Kiraladınız!",source,255,255,255,true)
            outputChatBox("#ff7f00● #ffffffİşyeri Sırası: #ff7f00"..tostring(id).."#ffffff ✔",source,255,255,255,true)
            outputChatBox("#ff7f00● #ffffffİşyeri Türü: #ff7f00"..tostring(tur).."#ffffff ✔",source,255,255,255,true)
            outputChatBox("#ff7f00● #ffffffİşyeri Kira Fiyatı: #ff7f00"..tostring(kirafiyati).."#ffffff ✔",source,255,255,255,true)
            outputChatBox("#ff7f00● #ffffffİşyeri Kiracısı: #ff7f00"..tostring(hesap).."#ffffff ✔",source,255,255,255,true)
            triggerClientEvent(source,"WorkPlaceSystem:GirisClose",source)
        else
            outputChatBox("#FF0000[BİLGİLENDİRME] #ffffffBu işyerini kiralamak için, bankada yeterli paranız yok. İşyeri Kiralama Fiyatı: #ff0000"..tostring(kirafiyati),source,255,255,255,true)
        end
    else
        outputChatBox("#FF0000[BİLGİLENDİRME] #ffffffBu işyeri kiralık değil. İşyeri Durumu: #ff0000"..tostring(durum),source,255,255,255,true)
    end
end)

addEvent("WorkPlaceSystem:LoginToWorkPlace",true)
addEventHandler("WorkPlaceSystem:LoginToWorkPlace",getRootElement(),function(id)
    local hesap = getAccountName(getPlayerAccount(source))
    local turu
    local mekani
    local kilidi
    local sahibi
    local kiraci
    local result = dbPoll(dbQuery(db,"SELECT * FROM veriler WHERE id = ?",id),-1)
    for i,v in pairs(result) do
        turu = tostring(v["turu"])
        mekani = v["mekan"]
        kilidi = v["kilit"]
        sahibi = v["sahip"]
        kiraci = v["kiraci"]
    end
    if tostring(hesap) == tostring(sahibi) then
        triggerClientEvent(source,"WorkPlaceSystem:GirisClose",source)
        triggerClientEvent(source,"WorkPlaceSystem:AdminPanel",source,true,"Sahibi")
    elseif tostring(hesap) == tostring(kiraci) then
        triggerClientEvent(source,"WorkPlaceSystem:GirisClose",source)
        triggerClientEvent(source,"WorkPlaceSystem:AdminPanel",source,true,"Kiracı")
    else
        if tostring(kilidi) == "1" then
            outputChatBox("#FF0000[BİLGİLENDİRME] #ffffffBu işyeri #ff0000Kilitli #ffffffolduğu için, giriş yapamadınız.",source,255,255,255,true)
        else
            setElementFrozen(source,false)
            fadeCamera(source,false)
            toggleAllControls(source,false)
            local varmi = false
            for i,v in pairs(girismarkerlari) do
                if tonumber(v[1]) == tonumber(id) then
                    varmi = true
                end
            end
            if varmi == false then
                local markersasd = createMarker ( interiorlar[turu][tonumber(mekani)][1],interiorlar[turu][tonumber(mekani)][2],interiorlar[turu][tonumber(mekani)][3]+1, "arrow", 1.2, 255, 127, 0, 170 )
                addEventHandler("onMarkerHit",markersasd,isyerindencikis)
                setElementInterior( markersasd, interiorlar[turu][tonumber(mekani)][4])
                setElementDimension(markersasd,tonumber(id))
                table.insert( girismarkerlari,{id,markersasd})
            end
            px,py,pz = getElementPosition(source)
            triggerClientEvent(source,"WorkPlaceSystem:GirisClose",source)
            setTimer( function( player )
                if getPedOccupiedVehicle( player ) then removePedFromVehicle( player ) end
                setElementInterior( player , interiorlar[turu][tonumber(mekani)][4],interiorlar[turu][tonumber(mekani)][1],interiorlar[turu][tonumber(mekani)][2],interiorlar[turu][tonumber(mekani)][3])
                  setElementDimension( player , tonumber(id))
                  toggleAllControls( player, true );
                  fadeCamera( player, true ); 
                  setAccountData(getPlayerAccount(player),"WorkPlaceSystem:Girdimi","false")
              end, 1200, 1, client, t );
              setTimer(function(player)
                setAccountData(getPlayerAccount(player),"WorkPlaceSystem:Girdimi","true")
            end,2000,1,client,t)
        end 
    end
end)

function isyerindencikis(oyuncu)
    if getAccountData(getPlayerAccount(oyuncu),"WorkPlaceSystem:Girdimi") == "true" then
        if getElementInterior(oyuncu) > 0 then
            toggleAllControls(oyuncu,false)
            fadeCamera(oyuncu,false)
            setTimer(function()
                setElementDimension(oyuncu,0)
                setElementInterior( oyuncu, 0,px,py,pz)
                toggleAllControls(oyuncu,true)
                fadeCamera(oyuncu,true)
            end, 1200,1,client,t)
        end
    end
end

addEvent("WorkPlaceSystem:Lock",true)
addEventHandler("WorkPlaceSystem:Lock",getRootElement(),function(durum,id)
    if durum == "kilitiac" then
        dbExec(db,"UPDATE veriler SET kilit = ? WHERE id = ?",2,id)
        outputChatBox("#ff7f00● #ffffffBaşarıyla İşyeri kilidi açıldı!",source,255,255,255,true)
    elseif durum == "kilitle" then
        dbExec(db,"UPDATE veriler SET kilit = ? WHERE id = ?",1,id)
        outputChatBox("#ff7f00● #ffffffBaşarıyla İşyeri kilidi kilitlendi!",source,255,255,255,true)
    end
end)

addEvent("WorkPlaceSystem:IsyerineGir",true)
addEventHandler("WorkPlaceSystem:IsyerineGir",getRootElement(),function(id)
    local turu
    local mekani
    local kilidi
    local sahibi
    local kiraci
    local result = dbPoll(dbQuery(db,"SELECT * FROM veriler WHERE id = ?",id),-1)
    for i,v in pairs(result) do
        turu = tostring(v["turu"])
        mekani = v["mekan"]
        kilidi = v["kilit"]
        sahibi = v["sahip"]
        kiraci = v["kiraci"]
    end
    setElementFrozen(source,false)
    fadeCamera(source,false)
    toggleAllControls(source,false)
    local varmi = false
    for i,v in pairs(girismarkerlari) do
        if tonumber(v[1]) == tonumber(id) then
            varmi = true
        end
    end
    if varmi == false then
        local markersasd = createMarker ( interiorlar[turu][tonumber(mekani)][1],interiorlar[turu][tonumber(mekani)][2],interiorlar[turu][tonumber(mekani)][3]+1, "arrow", 1.2, 255, 127, 0, 170 )
        addEventHandler("onMarkerHit",markersasd,isyerindencikis)
        setElementInterior( markersasd, interiorlar[turu][tonumber(mekani)][4])
        setElementDimension(markersasd,tonumber(id))
        table.insert( girismarkerlari,{id,markersasd})
    end
    px,py,pz = getElementPosition(source)
    triggerClientEvent(source,"WorkPlaceSystem:YonetimClose",source)
    setTimer( function( player )
        if getPedOccupiedVehicle( player ) then removePedFromVehicle( player ) end
        setElementInterior( player , interiorlar[turu][tonumber(mekani)][4],interiorlar[turu][tonumber(mekani)][1],interiorlar[turu][tonumber(mekani)][2],interiorlar[turu][tonumber(mekani)][3])
          setElementDimension( player , tonumber(id))
          toggleAllControls( player, true );
          fadeCamera( player, true ); 
          setAccountData(getPlayerAccount(player),"WorkPlaceSystem:Girdimi","false")
      end, 1200, 1, client, t );
      setTimer(function(player)
        setAccountData(getPlayerAccount(player),"WorkPlaceSystem:Girdimi","true")
    end,2000,1,client,t)
end)

addEvent("WorkPlaceSystem:SatiligaCikar",true)
addEventHandler("WorkPlaceSystem:SatiligaCikar",getRootElement(),function(id,sayi)   
    local durum
    local results = dbPoll(dbQuery(db,"SELECT * FROM veriler"),-1)
    for i,v in pairs(results) do
        if tostring(v["id"]) == tostring(id) then
            durum = tostring(v["durum"])
        end
    end
    if tostring(durum) == "Satılık" then
        dbExec(db,"UPDATE veriler SET durum = ? WHERE id = ?","Faaliyette",id)
        outputChatBox("#ff7f00● #ffffffBaşarıyla Satılıktan çıkardınız!",source,255,255,255,true)
        outputChatBox("#ff7f00● #ffffffİşyeri Durumu: #ff7f00Faaliyette",source,255,255,255,true)
        triggerClientEvent(source,"WorkPlaceSystem:YonetimClose",source)
    elseif tostring(durum) == "Faaliyette" then
        if tostring(sayi) == "" or tonumber(sayi) <= 0 then outputChatBox("#FF0000[BİLGİLENDİRME] #ffffffİşyerini, #ff0000en az 1 #ffffffBirime satabilirsin.",source,255,255,255,true) return end
        dbExec(db,"UPDATE veriler SET durum = ?, fiyati = ? WHERE id = ?","Satılık",tostring(sayi),id)
        outputChatBox("#ff7f00● #ffffffBaşarıyla Satışa çıkardınız!",source,255,255,255,true)
        outputChatBox("#ff7f00● #ffffffİşyeri Durumu: #ff7f00Satılık",source,255,255,255,true)
        outputChatBox("#ff7f00● #ffffffİşyeri Fiyatı: #ff7f00"..tostring(sayi),source,255,255,255,true)
        triggerClientEvent(source,"WorkPlaceSystem:YonetimClose",source)
    else
        outputChatBox("#FF0000[BİLGİLENDİRME] #ffffffİşyeriniz zaten #ff0000Kiralık veya Kirada #ffffffolduğu için, satışa çıkartamadınız.",source,255,255,255,true)
    end
end)

addEvent("WorkPlaceSystem:KiraligaCikar",true)
addEventHandler("WorkPlaceSystem:KiraligaCikar",getRootElement(),function(id,sayi)
    local durum
    local results = dbPoll(dbQuery(db,"SELECT * FROM veriler"),-1)
    for i,v in pairs(results) do
        if tostring(v["id"]) == tostring(id) then
            durum = tostring(v["durum"])
        end
    end
    if tostring(durum) == "Kiralık" or tostring(durum) == "Kirada" then
        dbExec(db,"UPDATE veriler SET durum = ? WHERE id = ?","Faaliyette",id)
        outputChatBox("#ff7f00● #ffffffBaşarıyla Kiralıktan çıkardınız!",source,255,255,255,true)
        outputChatBox("#ff7f00● #ffffffİşyeri Durumu: #ff7f00Faaliyette",source,255,255,255,true)
        triggerClientEvent(source,"WorkPlaceSystem:YonetimClose",source)
    elseif tostring(durum) == "Faaliyette" then
        if tostring(sayi) == "" or tonumber(sayi) <= 0 then outputChatBox("#FF0000[BİLGİLENDİRME] #ffffffİşyerini, #ff0000en az 1 #ffffffBirime kiralayabilirsin.",source,255,255,255,true) return end
        dbExec(db,"UPDATE veriler SET durum = ?, kirafiyati = ? WHERE id = ?","Kiralık",tostring(sayi),id)
        outputChatBox("#ff7f00● #ffffffBaşarıyla Kiralığa çıkardınız!",source,255,255,255,true)
        outputChatBox("#ff7f00● #ffffffİşyeri Durumu: #ff7f00Kiralık",source,255,255,255,true)
        outputChatBox("#ff7f00● #ffffffİşyeri Kira Fiyatı: #ff7f00"..tostring(sayi),source,255,255,255,true)
        triggerClientEvent(source,"WorkPlaceSystem:YonetimClose",source)
    else
        outputChatBox("#FF0000[BİLGİLENDİRME] #ffffffİşyeriniz zaten #ff0000Satılık #ffffffolduğu için, kiralığa çıkartamadınız.",source,255,255,255,true)
    end
end)

addCommandHandler(kiradancikma,function(oyuncu)
    local hesap = getAccountName(getPlayerAccount(oyuncu))
    local durum = false
    local id
    local veriler = dbPoll(dbQuery(db,"SELECT * FROM veriler"),-1)
    for i,v in pairs(veriler) do
        if tostring(v["kiraci"]) == tostring(hesap) then
            id = v["id"]
            durum = true
        end
    end
    if durum == true then
        dbExec(db,"UPDATE veriler SET kiraci = ?, durum = ?, kirafiyati = ? WHERE id = ?","-","Faaliyette","-",id)
        outputChatBox("#ff7f00● #ffffffBaşarıyla İşyeri kiracılığından çıktınız!",source,255,255,255,true)
    else
        outputChatBox("#FF0000[BİLGİLENDİRME] #ffffffHerhangi bir #ff0000işyeri kiralamamışsınız.",source,255,255,255,true)
    end
end)