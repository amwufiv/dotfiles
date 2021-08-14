---- Plugins
hs.loadSpoon("DeepLTranslate")
-- spoon.DeepLTranslate:start()
spoon.DeepLTranslate:bindHotkeys({
    translateSelectionPopup = { { "ctrl", "alt", "cmd" }, "E" },
 })


 hs.loadSpoon("CountDown")
 hs.hotkey.bind({"cmd", "ctrl"}, "C", function()
    button,minute = hs.dialog.textPrompt("倒计时","设置时间(min)","30","OK","Cancel")
    print(button,minute)
    if button == "OK" then
        spoon.CountDown:startFor(minute)
    end
  end)
  hs.hotkey.bind({"cmd", "ctrl"}, "P", function ()
        spoon.CountDown:pauseOrResume()
  end)

  hs.loadSpoon("PopupTranslateSelection")
  spoon.PopupTranslateSelection:bindHotkeys({
    translate_en_zh = { { "ctrl", "cmd" }, "E" },
 })
-- wifi
wifiWatcher = nil
homeSSID = {"retnuh_5G","retnuh"}
lastSSID = hs.wifi.currentNetwork()

wifiSetupPath = "/Users/hunter/Code/mymac/myscripts/network/setupwifi.sh"
wifiRevertPath = "/Users/hunter/Code/mymac/myscripts/network/revert.sh"

function ssidChangedCallback()
    newSSID = hs.wifi.currentNetwork()
    if newSSID == nil then
        return
    end
    if not itemInList(lastSSID,homeSSID) then
        if itemInList(newSSID, homeSSID) then 
            hs.alert.show("设置WIFI")
            os.execute(wifiSetupPath)
        end
    else
        if not itemInList(newSSID, homeSSID) then
            hs.audiodevice.defaultOutputDevice():setVolume(0)
            hs.alert.show("已静音")
            output = os.execute(wifiRevertPath)
        end       
    end 
    if newSSID ~= nil then
        lastSSID = newSSID
    end 
end

function itemInList(item,itemList)
    for _, value in ipairs(itemList) do
        if item == value then
            return true
        end
    end
    return false
end

wifiWatcher = hs.wifi.watcher.new(ssidChangedCallback)
wifiWatcher:start()

-- window resize
hs.hotkey.bind({"cmd", "ctrl"}, "Left", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()
  
    f.x = max.x
    f.y = max.y
    f.w = max.w / 2
    f.h = max.h
    win:setFrame(f)
  end)
hs.hotkey.bind({"cmd", "ctrl"}, "Right", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()
  
    f.x = max.x + (max.w / 2)
    f.y = max.y
    f.w = max.w / 2
    f.h = max.h
    win:setFrame(f)
  end)
  hs.hotkey.bind({"cmd", "ctrl"}, "Up", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()
  
    f.x = max.x
    f.y = max.y
    f.w = max.w 
    f.h = max.h /2
    win:setFrame(f)
  end)
  hs.hotkey.bind({"cmd", "ctrl"}, "Down", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()
  
    f.x = max.x
    f.y = max.y + (max.h / 2)
    f.w = max.w 
    f.h = max.h /2
    win:setFrame(f)
  end)
  hs.hotkey.bind({"cmd", "ctrl"}, "Home", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()
  
    f.x = max.x
    f.y = max.y
    f.w = max.w / 2
    f.h = max.h / 2
    win:setFrame(f)
  end)
hs.hotkey.bind({"cmd", "ctrl"}, "Pageup", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()
  
    f.x = max.x + (max.w / 2)
    f.y = max.y
    f.w = max.w / 2
    f.h = max.h / 2
    win:setFrame(f)
  end)
  hs.hotkey.bind({"cmd", "ctrl"}, "End", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()
  
    f.x = max.x
    f.y = max.y + (max.h / 2)
    f.w = max.w / 2
    f.h = max.h / 2
    win:setFrame(f)
  end)
  hs.hotkey.bind({"cmd", "ctrl"}, "Pagedown", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()
  
    f.x = max.x + (max.w / 2)
    f.y = max.y + (max.h / 2)
    f.w = max.w / 2
    f.h = max.h / 2
    win:setFrame(f)
  end)
  cachedPos = nil
  hs.hotkey.bind({"cmd", "ctrl"}, "M", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()
    if f.w ~= max.w and f.h ~= max.h then
        cachedPos = {x=f.x,y=f.y,w=f.w,h=f.h}
        f.x = max.x
        f.y = max.y
        f.w = max.w
        f.h = max.h
        win:setFrame(f)
    elseif cachedPos ~= nil then 
        f.x = cachedPos.x
        f.y = cachedPos.y
        f.w = cachedPos.w
        f.h = cachedPos.h
        win:setFrame(f)
    end
  end)
  
-- 设置鼠标贴边自动扩展
function isclose(x,y)
    local threshold = 150
    return math.abs(x - y) < threshold
    -- body
end
function resize()
    local butt = hs.mouse:getButtons()
    if butt[1] then 
        local win = hs.window.focusedWindow()
        local f = win:frame()
        local screen = win:screen()
        local max = screen:frame()
        local abspos = hs.mouse.absolutePosition()
        if isclose(abspos.x , 0) and isclose(abspos.y , 0) then
            f.x = max.x
            f.y = max.y
            f.w = max.w /2
            f.h = max.h /2
            win:setFrame(f)
        elseif isclose(abspos.x , 0) and isclose(abspos.y , max.h) then
            f.x = max.x
            f.y = max.h /2
            f.w = max.w /2
            f.h = max.h /2
            win:setFrame(f)
        elseif isclose(abspos.x , 0)  then
            
            f.x = max.x
            f.y = max.y
            f.w = max.w /2
            f.h = max.h
            win:setFrame(f)
        
        elseif isclose(abspos.x , max.w) and isclose(abspos.y , 0) then
            f.x = max.w /2
            f.y = max.y
            f.w = max.w /2
            f.h = max.h /2
            win:setFrame(f)
        elseif isclose(abspos.x , max.w) and isclose(abspos.y , max.h) then
            f.x = max.w /2
            f.y = max.h /2
            f.w = max.w /2
            f.h = max.h /2
            win:setFrame(f)
        elseif isclose(abspos.x , max.w) and abspos.y ~= max.h then 
            f.x = max.w /2
            f.y = max.y
            f.w = max.w /2
            f.h = max.h
            win:setFrame(f)
        
        end
    end

end


t = hs.timer.doEvery(0.2,function()
    resize()
   
end)
t:start()






----------------------------END--------------------------
