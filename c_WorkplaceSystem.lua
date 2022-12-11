loadstring(exports.dgs:dgsImportFunction())()
local id

--Oluşturma Paneli

Genislik,Uzunluk = dgsGetScreenSize()
Genislika,Uzunluka = 590,486
X = (Genislik/2) - (Genislika/2)
Y = (Uzunluk/2) - (Uzunluka/2)
local font0_Font13 = dgsCreateFont("files/Font13.ttf", 10)

createWindow = dgsCreateWindow(X, Y, Genislika, Uzunluka, "İşyeri Oluşturma Panel", false)
dgsWindowSetSizable(createWindow, false)
dgsWindowSetCloseButtonEnabled(createWindow,false)
dgsSetVisible(createWindow,false)

createList = dgsCreateGridList(9, 25, 567, 189, false, createWindow)
dgsGridListAddColumn(createList, "Sıra", 0.2)
dgsGridListAddColumn(createList, "Sahibi", 0.3)
dgsGridListAddColumn(createList, "Türü", 0.3)
dgsGridListAddColumn(createList, "Mekan", 0.3)
dgsGridListAddColumn(createList, "Fiyatı", 0.3)
dgsGridListAddColumn(createList, "Kilit Durumu", 0.3)
createSiraTxt = dgsCreateEdit(33, 251, 139, 30, "....", false, createWindow)
createInfoLbl1 = dgsCreateLabel(89, 228, 23, 19, "Sıra", false, createWindow)
createInfoLbl2 = dgsCreateLabel(281, 228, 39, 19, "Sahibi", false, createWindow)
createSahibiTxt = dgsCreateEdit(229, 251, 139, 30, "....", false, createWindow)
createInfoLbl3 = dgsCreateLabel(473, 228, 39, 19, "Türü", false, createWindow)
createTuruChbox = dgsCreateComboBox(416, 251, 139, 30, "Seçiniz..", false, createWindow)
dgsComboBoxAddItem(createTuruChbox,"Galeri")
dgsComboBoxAddItem(createTuruChbox,"Silahçı")
dgsComboBoxAddItem(createTuruChbox,"Kıyafetçi")
createInfoLbl4 = dgsCreateLabel(89, 298, 33, 19, "Fiyatı", false, createWindow)
createFiyatTxt = dgsCreateEdit(33, 321, 139, 30, "....", false, createWindow)
createInfoLbl5 = dgsCreateLabel(275, 298, 45, 19, "Mekan", false, createWindow)
createMekanChbox = dgsCreateComboBox(229, 321, 139, 30, "Seçiniz..", false, createWindow)
dgsComboBoxAddItem(createMekanChbox,"1")
dgsComboBoxAddItem(createMekanChbox,"2")
dgsComboBoxAddItem(createMekanChbox,"3")
dgsComboBoxAddItem(createMekanChbox,"4")
createInfoLbl6 = dgsCreateLabel(473, 298, 45, 19, "Kilidi", false, createWindow)
createKilitChbox = dgsCreateComboBox(416, 321, 139, 30, "Seçiniz..", false, createWindow)
dgsComboBoxAddItem(createKilitChbox,"Kilitli")
dgsComboBoxAddItem(createKilitChbox,"Kilitsiz")
createIsyeriniSilBtn = dgsCreateButton(43, 391, 139, 44, "İşyerini Sil", false, createWindow)
createIsyeriOlusturBtn = dgsCreateButton(229, 391, 139, 44, "İşyeri Oluştur", false, createWindow)
createIsyeriDuzenleBtn = dgsCreateButton(406, 391, 139, 44, "İşyerini Düzenle", false, createWindow)
createWindowCloseBtn = dgsCreateButton(568, -25, 22, 24, "X", false, createWindow) 

----------------------------------------------------------------------------
--
----------------------------------------------------------------------------

--Giriş Paneli
Genislikb,Uzunlukb = 553,270
Xb = (Genislik/2) - (Genislikb/2)
Yb = (Uzunluk/2) - (Uzunlukb/2)

giriswindow = dgsCreateWindow(Xb, Yb, Genislikb, Uzunlukb, "İşyeri", false)
dgsWindowSetSizable(giriswindow, false)
dgsSetVisible(giriswindow,false)
dgsWindowSetCloseButtonEnabled(giriswindow,false)

giriskapatbtn = dgsCreateButton(527, -25, 26, 25, "X", false, giriswindow)
girisidlbl = dgsCreateLabel(33, 10, 223, 21, "➥ İşyeri Sıra: ", false, giriswindow) 
font2_Font13 = dgsCreateFont("files/Font13.ttf", 11)
dgsSetFont(girisidlbl, font2_Font13)
girissahiblbl = dgsCreateLabel(33, 41, 223, 21, "➥ İşyeri Sahibi: ", false, giriswindow) 
dgsSetFont(girissahiblbl, font2_Font13)
girisdurumlbl = dgsCreateLabel(284, 10, 259, 21, "➥ İşyeri Durumu: ", false, giriswindow) 
dgsSetFont(girisdurumlbl, font2_Font13)
giristurulbl = dgsCreateLabel(33, 72, 223, 21, "➥ İşyeri Türü: ", false, giriswindow)
dgsSetFont(giristurulbl, font2_Font13)
girisfiyatlbl = dgsCreateLabel(284, 41, 259, 21, "➥ İşyeri Satış Fiyatı: ", false, giriswindow)
dgsSetFont(girisfiyatlbl, font2_Font13)
giriskilitdrm = dgsCreateLabel(284, 72, 259, 21, "➥ İşyeri Kilidi: ", false, giriswindow)
dgsSetFont(giriskilitdrm, font2_Font13)
cizgi5 = dgsCreateLabel(0, 90, 560, 15, "_______________________________________________________________________________", false, giriswindow)
giriskiracilbl = dgsCreateLabel(33, 120, 259, 21, "➥ İşyeri Kiracısı: ", false, giriswindow)
dgsSetFont(giriskiracilbl, font2_Font13)
giriskirafiyatlbl = dgsCreateLabel(284, 120, 259, 21, "➥ İşyeri Kira Fiyatı: ", false, giriswindow)
dgsSetFont(giriskirafiyatlbl, font2_Font13)
cizgi5 = dgsCreateLabel(0, 145, 560, 15, "_______________________________________________________________________________", false, giriswindow)
girissatinalbtn = dgsCreateButton(21, 180, 142, 51, "Satın Al", false, giriswindow)
dgsSetFont(girissatinalbtn, font2_Font13)
giriskiralabtn = dgsCreateButton(385, 180, 142, 51, "Kirala", false, giriswindow)
dgsSetFont(giriskiralabtn, font2_Font13)
girisgirisyapbtn = dgsCreateButton(211, 180, 142, 51, "Giriş Yap", false, giriswindow)
dgsSetFont(girisgirisyapbtn, font2_Font13)

----------------------------------------------------------------------------
--
----------------------------------------------------------------------------

-- Yönetim Paneli
Genisliky,Uzunluky = 531,230
Xy = (Genislik/2) - (Genisliky/2)
Yy = (Uzunluk/2) - (Uzunluky/2)

yonetimwindow = dgsCreateWindow(Xy, Yy, Genisliky, Uzunluky, "Yönetim", false)
dgsWindowSetSizable(yonetimwindow, false)
dgsSetVisible(yonetimwindow,false)
dgsWindowSetCloseButtonEnabled(yonetimwindow,false)

yonetimgirisbtn = dgsCreateButton(299, 17, 162, 43, "İşyerine Gir", false, yonetimwindow)
dgsSetFont(yonetimgirisbtn, font0_Font13)
yonetimkilitbtn = dgsCreateButton(82, 17, 162, 43, "Kilit: Kilitsiz", false, yonetimwindow)
dgsSetFont(yonetimkilitbtn, font0_Font13)
yonetimcizgilbl = dgsCreateLabel(0, 70, 527, 15, "⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻", false, yonetimwindow)
yonetimkiraliksatiliktxt = dgsCreateEdit(184, 100, 175, 33, "", false, yonetimwindow)
yonetimkiraligacikartbtn = dgsCreateButton(299, 142, 162, 43, "Kiralığa Çıkart", false, yonetimwindow)
dgsSetFont(yonetimkiraligacikartbtn, font0_Font13)
yonetimsatiligacikartbtn = dgsCreateButton(82, 142, 162, 43, "Satılığa Çıkart", false, yonetimwindow)
dgsSetFont(yonetimsatiligacikartbtn, font0_Font13)
yonetimkapatbtn = dgsCreateButton(506, -25  , 25, 25, "X", false, yonetimwindow)

--Kodlar

addEventHandler("onDgsMouseClickUp",getRootElement(),function()
    if source == createIsyeriOlusturBtn then
        if dgsGetText(createSiraTxt) == "" or dgsGetText(createSiraTxt) == "...." or dgsGetText(createSahibiTxt) == "" or dgsGetText(createSahibiTxt) == "...." or dgsGetText(createFiyatTxt) == "" or dgsGetText(createFiyatTxt) == "...." then
            outputChatBox("#ff0000[BİLGİLENDİRME] #ffffffLütfen yazı alanlarını boş bırakmayınız.",255,255,255,true) return
        elseif dgsComboBoxGetSelectedItem(createTuruChbox) == -1 or dgsComboBoxGetSelectedItem(createMekanChbox) == -1 or dgsComboBoxGetSelectedItem(createKilitChbox) == -1 then
            outputChatBox("#ff0000[BİLGİLENDİRME] #ffffffLütfen tüm seçimleri yaptığınıza emin olun.",255,255,255,true) return
        end
        local secim1 = dgsComboBoxGetSelectedItem(createTuruChbox)
        local secim2 = dgsComboBoxGetSelectedItem(createMekanChbox)
        local id,sahibi,turu,fiyati,mekan,kilidi = dgsGetText(createSiraTxt),dgsGetText(createSahibiTxt),dgsComboBoxGetItemText(createTuruChbox,secim1),dgsGetText(createFiyatTxt),dgsComboBoxGetItemText(createMekanChbox,secim2),dgsComboBoxGetSelectedItem(createKilitChbox)
        triggerServerEvent("WorkPlaceSystem:CreateWorkPlace",localPlayer,id,sahibi,turu,fiyati,mekan,kilidi)
    elseif source == createIsyeriDuzenleBtn then
        local sel = dgsGridListGetSelectedItem(createList)
        if sel ~= -1 then 
        if dgsGetText(createSiraTxt) == "" or dgsGetText(createSiraTxt) == "...." or dgsGetText(createSahibiTxt) == "" or dgsGetText(createSahibiTxt) == "...." or dgsGetText(createFiyatTxt) == "" or dgsGetText(createFiyatTxt) == "...." then
            outputChatBox("#ff0000[BİLGİLENDİRME] #ffffffLütfen yazı alanlarını boş bırakmayınız.",255,255,255,true) return
        elseif dgsComboBoxGetSelectedItem(createTuruChbox) == -1 or dgsComboBoxGetSelectedItem(createMekanChbox) == -1 or dgsComboBoxGetSelectedItem(createKilitChbox) == -1 then
            outputChatBox("#ff0000[BİLGİLENDİRME] #ffffffLütfen tüm seçimleri yaptığınıza emin olun.",255,255,255,true) return
        end
        local defid = dgsGridListGetItemText(createList,sel,1)
        local secim1 = dgsComboBoxGetSelectedItem(createTuruChbox)
        local secim2 = dgsComboBoxGetSelectedItem(createMekanChbox)
        local id,sahibi,turu,fiyati,mekan,kilidi = dgsGetText(createSiraTxt),dgsGetText(createSahibiTxt),dgsComboBoxGetItemText(createTuruChbox,secim1),dgsGetText(createFiyatTxt),dgsComboBoxGetItemText(createMekanChbox,secim2),dgsComboBoxGetSelectedItem(createKilitChbox)
        triggerServerEvent("WorkPlaceSystem:UpdateWorkPlace",localPlayer,id,sahibi,turu,fiyati,mekan,kilidi,defid)
    else
        outputChatBox("#ff0000[BİLGİLENDİRME] #ffffffLütfen listeden düzenlenecek işyerini seçin.",255,255,255,true)
    end
    elseif source == createIsyeriniSilBtn then
        local sel = dgsGridListGetSelectedItem(createList)
        if sel ~= -1 then 
            local text = dgsGetText(createIsyeriniSilBtn)
            if text == "İşyerini Sil" then
                dgsSetText(createIsyeriniSilBtn,"İşyerini Sil (3)")
            elseif text == "İşyerini Sil (3)" then
                dgsSetText(createIsyeriniSilBtn,"İşyerini Sil (2)")
            elseif text == "İşyerini Sil (2)" then
                dgsSetText(createIsyeriniSilBtn,"İşyerini Sil (1)")
            elseif text == "İşyerini Sil (1)" then
                local id = dgsGridListGetItemText(createList,sel,1)
                triggerServerEvent("WorkPlaceSystem:DeleteWorkPlace",localPlayer,id)
                dgsSetText(createIsyeriniSilBtn,"İşyerini Sil")
            end
        else
            outputChatBox("#ff0000[BİLGİLENDİRME] #ffffffLütfen listeden silinecek işyerini seçin.",255,255,255,true)
        end
    end
end)

addEvent("WorkPlaceSystem:GirisClose",true)
addEventHandler("WorkPlaceSystem:GirisClose",getRootElement(),function()
    dgsSetVisible(giriswindow,false)
    showCursor(false)
end)

addEvent("WorkPlaceSystem:YonetimClose",true)
addEventHandler("WorkPlaceSystem:YonetimClose",getRootElement(),function()
    dgsSetVisible(yonetimwindow,false)
    showCursor(false)
end)

addEventHandler("onDgsMouseClickUp",getRootElement(),function()
    if source == girissatinalbtn then
        triggerServerEvent("WorkPlaceSystem:BuyToWorkPlace",localPlayer,id)
    end
    if source == giriskiralabtn then
        triggerServerEvent("WorkPlaceSystem:RentToWorkPlace",localPlayer,id)
    end
    if source == girisgirisyapbtn then
        triggerServerEvent("WorkPlaceSystem:LoginToWorkPlace",localPlayer,id)
    end
    if source == yonetimkapatbtn then
        dgsSetVisible(yonetimwindow,false)
        showCursor(false)
    end
    if source == yonetimkilitbtn then
        if dgsGetText(yonetimkilitbtn) == "Kilit: Kilitli" then
            triggerServerEvent("WorkPlaceSystem:Lock",localPlayer,"kilitiac",id)
            dgsSetText(yonetimkilitbtn,"Kilit: Kilitsiz")
        else
            triggerServerEvent("WorkPlaceSystem:Lock",localPlayer,"kilitle",id)
            dgsSetText(yonetimkilitbtn,"Kilit: Kilitli")
        end
    end
    if source == yonetimgirisbtn then
        triggerServerEvent("WorkPlaceSystem:IsyerineGir",localPlayer,id)
    end
    if source == yonetimsatiligacikartbtn then
        local sayi = dgsGetText(yonetimkiraliksatiliktxt)
        triggerServerEvent("WorkPlaceSystem:SatiligaCikar",localPlayer,id,sayi)
    end 
    if source == yonetimkiraligacikartbtn then
        local sayi = dgsGetText(yonetimkiraliksatiliktxt)
        triggerServerEvent("WorkPlaceSystem:KiraligaCikar",localPlayer,id,sayi)
    end
end)

addEvent("WorkPlaceSystem:LogIN",true)
addEventHandler("WorkPlaceSystem:LogIN",getRootElement(),function(result,ida)
    for i,v in pairs(result) do
        dgsSetText(girisidlbl,"➥ İşyeri Sıra: "..v["id"])
        dgsSetText(girissahiblbl,"➥ İşyeri Sahibi: "..v["sahip"])
        dgsSetText(girisdurumlbl,"➥ İşyeri Durumu: "..v["durum"])
        dgsSetText(giristurulbl,"➥ İşyeri Türü: "..v["turu"])
        dgsSetText(giriskiracilbl,"➥ İşyeri Kiracısı: "..v["kiraci"])
        dgsSetText(giriskirafiyatlbl,"➥ İşyeri Kira Fiyatı: "..v["kirafiyati"])
        if tostring(v["durum"]) == "Faaliyette" then
            dgsSetText(girisfiyatlbl,"➥ İşyeri Önceki Fiyatı: "..v["fiyati"])
            dgsSetText(giriskirafiyatlbl,"➥ İşyeri Kira Fiyatı: "..v["kirafiyati"])
            dgsSetText(yonetimsatiligacikartbtn,"Satılığa Çıkart")
            dgsSetText(yonetimkiraligacikartbtn,"Kiralığa Çıkart")
        elseif tostring(v["durum"]) == "Satılık" then
            dgsSetText(girisfiyatlbl,"➥ İşyeri Satış Fiyatı: "..v["fiyati"])
            dgsSetText(giriskirafiyatlbl,"➥ İşyeri Kira Fiyatı: "..v["kirafiyati"])
            dgsSetText(yonetimsatiligacikartbtn,"Satılıktan Kaldır")
            dgsSetText(yonetimkiraligacikartbtn,"Kiralığa Çıkart")
        elseif tostring(v["durum"]) == "Kiralık" then
            dgsSetText(girisfiyatlbl,"➥ İşyeri Önceki Fiyatı: "..v["fiyati"])
            dgsSetText(giriskirafiyatlbl,"➥ İşyeri Kira Fiyatı: "..v["kirafiyati"])
            dgsSetText(yonetimsatiligacikartbtn,"Satılığa Çıkart")
            dgsSetText(yonetimkiraligacikartbtn,"Kiralıktan Kaldır")
        elseif tostring(v["durum"]) == "Kirada" then
            dgsSetText(girisfiyatlbl,"➥ İşyeri Önceki Fiyatı: "..v["fiyati"])
            dgsSetText(giriskirafiyatlbl,"➥ İşyeri Kira Fiyatı: "..v["kirafiyati"])
            dgsSetText(yonetimsatiligacikartbtn,"Satılığa Çıkart")
            dgsSetText(yonetimkiraligacikartbtn,"Kiralıktan Kaldır")
        end
        if tostring(v["kilit"]) == "1" then
            dgsSetText(giriskilitdrm,"➥ İşyeri Kilidi: Kilitli")
            dgsSetText(yonetimkilitbtn,"Kilit: Kilitli")
        else
            dgsSetText(yonetimkilitbtn,"Kilit: Kilitsiz")
            dgsSetText(giriskilitdrm,"➥ İşyeri Kilidi: Kilitsiz")
        end
    end
    id = ida
    dgsSetVisible(giriswindow,true)
    showCursor(true)
end)

addEvent("WorkPlaceSystem:AdminPanel",true)
addEventHandler("WorkPlaceSystem:AdminPanel",getRootElement(),function(durum,kim)
    if durum then
        if kim == "Sahibi" then
            dgsSetEnabled(yonetimkiraligacikartbtn,true)
            dgsSetEnabled(yonetimsatiligacikartbtn,true)
            dgsSetEnabled(yonetimkiraliksatiliktxt,true)
            dgsSetVisible(yonetimwindow,true)
            showCursor(true)
        else
            dgsSetEnabled(yonetimkiraligacikartbtn,false)
            dgsSetEnabled(yonetimsatiligacikartbtn,false)
            dgsSetEnabled(yonetimkiraliksatiliktxt,false)
            dgsSetVisible(yonetimwindow,true)
            showCursor(true)
        end
    else
        dgsSetVisible(yonetimwindow,false)
        showCursor(false)
    end
end)

addEventHandler("onDgsMouseClickUp",getRootElement(),function()
    if source == createSiraTxt then
        if dgsGetText(createSiraTxt) == "...." then
        dgsSetText(createSiraTxt,"")
        end
    elseif source == createSahibiTxt then
        if dgsGetText(createSahibiTxt) == "...." then
        dgsSetText(createSahibiTxt,"") 
        end
    elseif source == createFiyatTxt then
        if dgsGetText(createFiyatTxt) == "...." then
        dgsSetText(createFiyatTxt,"")
        end
    end
    if source == createWindowCloseBtn then
        dgsSetVisible(createWindow,false)
        showCursor(false)
        dgsSetInputEnabled(false)
    end
    if source == createList then
        local sel = dgsGridListGetSelectedItem(createList)
        if sel ~= -1 then 
            dgsSetText(createSiraTxt,dgsGridListGetItemText(createList,sel,1))
            dgsSetText(createSahibiTxt,dgsGridListGetItemText(createList,sel,2))
            if dgsGridListGetItemText(createList,sel,3) == "Galeri" then
                dgsComboBoxSetSelectedItem(createTuruChbox,1)
            elseif dgsGridListGetItemText(createList,sel,3) == "Silahçı" then
                dgsComboBoxSetSelectedItem(createTuruChbox,2)
            elseif dgsGridListGetItemText(createList,sel,3) == "Kıyafetçi" then
                dgsComboBoxSetSelectedItem(createTuruChbox,3)
            end
            dgsSetText(createFiyatTxt,dgsGridListGetItemText(createList,sel,5))
            if dgsGridListGetItemText(createList,sel,4) == "1" then
                dgsComboBoxSetSelectedItem(createMekanChbox,1)
            elseif dgsGridListGetItemText(createList,sel,4) == "2" then
                dgsComboBoxSetSelectedItem(createMekanChbox,2)
            elseif dgsGridListGetItemText(createList,sel,4) == "3" then
                dgsComboBoxSetSelectedItem(createMekanChbox,3)
            elseif dgsGridListGetItemText(createList,sel,4) == "4" then
                dgsComboBoxSetSelectedItem(createMekanChbox,4)
            end
            if dgsGridListGetItemText(createList,sel,6) == "Kilitli" then
            dgsComboBoxSetSelectedItem(createKilitChbox,1)
            elseif dgsGridListGetItemText(createList,sel,6) == "Kilitsiz" then
                dgsComboBoxSetSelectedItem(createKilitChbox,2)
            end 
        else
            dgsSetText(createSiraTxt,"....")
            dgsSetText(createSahibiTxt,"....")
            dgsSetText(createFiyatTxt,"....")
            dgsComboBoxSetSelectedItem(createTuruChbox,-1)
            dgsComboBoxSetSelectedItem(createMekanChbox,-1)
            dgsComboBoxSetSelectedItem(createKilitChbox,-1)
        end
    end
    if source == giriskapatbtn then
        dgsSetVisible(giriswindow,false)
        showCursor(false)
    end
end)

addEvent("WorkPlaceSystem:CreatePanel",true)
addEventHandler("WorkPlaceSystem:CreatePanel",getRootElement(),function(durum,veriler)
    if durum == true then
        dgsGridListClear(createList)
        for i,v in pairs(veriler) do
            row = dgsGridListAddRow(createList)
            dgsGridListSetItemText(createList,row,1,v["id"])
            dgsGridListSetItemText(createList,row,2,v["sahip"])
            dgsGridListSetItemText(createList,row,3,v["turu"])
            dgsGridListSetItemText(createList,row,4,v["mekan"])
            dgsGridListSetItemText(createList,row,5,v["fiyati"])
            if tonumber(v["kilit"]) == 1 then
                dgsGridListSetItemText(createList,row,6,"Kilitli")
            else
                dgsGridListSetItemText(createList,row,6,"Kilitsiz")
            end
        end
        dgsSetVisible(createWindow,true)
        showCursor(true)
        dgsSetInputEnabled(true)
    else
        dgsSetVisible(createWindow,false)
        showCursor(false)
        dgsSetInputEnabled(false)
    end
end)