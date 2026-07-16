local relay = peripheral.find("redstone_relay")

while true do
    print(relay.getInput("front"))
    sleep(0.5)
end
