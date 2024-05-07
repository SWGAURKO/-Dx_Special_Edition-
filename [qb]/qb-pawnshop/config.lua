Config = {}

Config.PawnLocation = {
    [1] = {
            coords = vector3(174.75, -1322.05, 29.36),
            length = 1.5,
            width = 1.8,
            heading = 207.0,
            debugPoly = false,
            minZ = 1.97,
            maxZ = 105.42,
            distance = 10.0
        },
    }

Config.BankMoney = false -- Set to true if you want the money to go into the players bank
Config.UseTimes = false -- Set to false if you want the pawnshop open 24/7
Config.TimeOpen = 7 -- Opening Time
Config.TimeClosed = 17 -- Closing Time
Config.SendMeltingEmail = true

Config.UseTarget = GetConvar('UseTarget', 'false') == 'true'

Config.PawnItems = {
    [1] = {
        item = 'goldchain',
        price = math.random(50,6780)
    },
    [2] = {
        item = 'diamond_ring',
        price = math.random(50,14600)
    },
    [3] = {
        item = 'rolex',
        price = math.random(50,7500)
    },
    [4] = {
        item = '10kgoldchain',
        price = math.random(50,4350)
    },
    [5] = {
        item = 'tablet',
        price = math.random(50,550)
    },
    [6] = {
        item = 'iphone',
        price = math.random(50,600)
    },
    [7] = {
        item = 'samsungphone',
        price = math.random(50,455)
    },
    [8] = {
        item = 'laptop',
        price = math.random(50,725)
    }
}

Config.MeltingItems = { -- meltTime is amount of time in minutes per item
    [1] = {
        item = 'goldchain',
        rewards = {
            [1] = {
                item = 'goldbar',
                amount = 2
            }
        },
        meltTime = 0.15
    },
    [2] = {
        item = 'diamond_ring',
        rewards = {
            [1] = {
                item = 'diamond',
                amount = 1
            },
            [2] = {
                item = 'goldbar',
                amount = 1
            }
        },
        meltTime = 0.15
    },
    [3] = {
        item = 'rolex',
        rewards = {
            [1] = {
                item = 'diamond',
                amount = 1
            },
            [2] = {
                item = 'goldbar',
                amount = 1
            },
            [3] = {
                item = 'electronickit',
                amount = 1
            }
        },
        meltTime = 0.15
    },
    [4] = {
        item = '10kgoldchain',
        rewards = {
            [1] = {
                item = 'diamond',
                amount = 5
            },
            [2] = {
                item = 'goldbar',
                amount = 1
            }
        },
        meltTime = 0.15
    },
}
