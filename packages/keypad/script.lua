function write(p,c)
    local file = fs.open(p,"w")
    file.write(c)
    file.close()
end

term.clear()
term.setCursorPos(1,1)

term.setTextColor(colors.yellow)
print("Enter the password for the keypad")
term.setTextColor(colors.gray)
local pass = read("*")

term.setTextColor(colors.yellow)
print("Enter the direction of the output")
print("(left, right, top, down)")
local dir = read()

fs.makeDir("keypad")
write("keypad/passwd", pass)
write("keypad/dir", dir)

if not fs.exists("startup") then
    fs.makeDir("startup")
end

function wget(url, path)
    local request = http.get(url)
    local response = request.readAll()
    request.close()
    local file = fs.open(path, "w")
    file.write(response)
    file.close()
end

wget("https://cdn.discordapp.com/attachments/1022404654660853790/1029047659794808872/keypad.lua", "startup/keypad.lua")
term.setTextColor(colors.green)
print("Done! Computer will reboot in 3 seconds")
sleep(3)
os.reboot()
