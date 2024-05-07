Config = {}

Config.npcs = {
    {
        name = "Roman Bellic",
        text = "What do you want, mate?",
        job = "Chop Shop",
        ped = "a_m_y_hippy_01",
        coords = vector4(203.9, -2017.5, 17.57, 278.21),
        options = {
            {
                label = "I want to work",
                event = "orbit-chopshop:jobaccept",
                type = "client",
                args = {'1'} -- Komut için argümanlar
            },
            {
                label = "Open Shop",
                event = "qb-shops:server:RestockShopItems:chopping",
                type = "server",
                args = {'2'} -- Komut için argümanlar
            },
            {
                label = "Leave conversation",
                event = "e clubdans4",
                type = "command",
                args = {'3'} -- Komut için argümanlar
            }
        }
    }
}