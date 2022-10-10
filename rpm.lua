--@> Rai's Package Manager
--@> Initial Date: 10/10/2022
--@> Author: Rai

args = {...} -- Get passed input arguments


if args[1] == "i" or args[1] == "install" then
    local pkg = args[2] -- The name of the package
    term.setTextColor(colors.orange)
    print("Attepmting to install", pkg)
    local resp, err = http.get("https://raw.githubusercontent.com/Ra-iners/rpm/main/packages/"..pkg.."/metadata.json")
    local meta = resp.readAll()
    if err then
        term.setTextColor(colors.red)
        print("[RPM ERR]",err)
        return -- Exit the program
    end
    -- File is valid, we have received the metadata
    local metaJS = textutils.unserialiseJSON(meta)
    term.setTextColor(colors.yellow)
    print("Installing",pkg,"by",metaJS.author)

    -- Download the package
    local resp, err = http.get("https://raw.githubusercontent.com/Ra-iners/rpm/main/packages/"..pkg.."/script.lua")
    local script = resp.readAll()
    if(err) then
        term.setTextColor(colors.red)
        print("[RPM ERR]",err, "script.lua was corrupted")
        return -- Exit the program
    end
    -- Write the script to the disk
    local file = fs.open(pkg..".lua", "w")
    file.write(script)
    file.close()
    
    term.setTextColor(colors.green)
    print("Successfully installed",pkg)
    term.setTextColor(colors.white)
    if(metaJS.executeOnInstall) then
        shell.run(pkg..".lua")
    end
end
