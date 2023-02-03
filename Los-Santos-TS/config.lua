Config = { }

Config.totalDamage = true

Config.location = {
    { 
        name = "El Burro",
        x=1713.942, 
        y=-1471.953, 
        z=112.949, 
        spawnLocationTrailer = { x=1700.503, y=-1499.508, z=112.9621 }, 
        spawnHeadingTrailer = 69.227905273438,
        spawnLocationTruck = { x=1699.379, y=-1463.631, z=112.969 },
        spawnHeadingTruck = 159.33056640625
    },
    { 
        name = "Docks",
        x=1184.238, 
        y=-3178.949, 
        z=7.097519, 
        spawnLocationTrailer = { x=1201.3835, y=-3185.469, z=7 }, 
        spawnHeadingTrailer = 181.19378662109, 
        spawnLocationTruck = { x=1171.799, y=-3191.95, z=5.800682 },
        spawnHeadingTruck = 357.32150268555
    },
    {
        name = "24/7",
        x=1240.1829,
        y=-3178.288,
        z=7.1049,
        spawnLocationTrailer = { x=1244.9346, y=-3155.924, z=6 },
        spawnHeadingTrailer = -91.2548,
        spawnLocationTruck = { x=1252.0159, y=-3176.724, z=5.8110 },
        spawnHeadingTruck = -0.1718
    }
}

Config.spawnTruckCode = {
    {
        spawnName = 'None',
        spawnCode = 'n/a'
    },
    {
        spawnName = 'Phantom',
        spawnCode = 'phantom'
    },
    {
        spawnName = 'Hauler',
        spawnCode = 'hauler'
    }, 
    {
        spawnName = 'Packer',
        spawnCode = 'packer'
    }
}

Config.jobs = {
    { 
        startJob = "El Burro", 
        jobName = "Cluckin' Bell Paleto Bay", 
        jobTrailerCode = "trailers", 
        jobTrailerLiv = 3,
        -- giveMoney = 10000,
        finalLocation = {x=4.013825, y=6277.184, z=31.22961},
        time = 300000, -- 5 Mins
    },
    { 
        startJob = "Docks", 
        jobName = "Dolar Pills Sandy Shores", 
        jobTrailerCode = "trailers", 
        jobTrailerLiv = 3, 
        -- giveMoney = 10000,
        finalLocation = {x=593.5133, y=2813.884, z=41.92601},
        time = 300000, -- 5 Mins
    },
    { 
        startJob = "Docks", 
        jobName = "Dolar Pills Davis", 
        jobTrailerCode = "trailers", 
        jobTrailerLiv = 3, 
        -- giveMoney = 10000,
        finalLocation = {x=107.6295, y=-1611.022, z=29.4247},
        time = 180000, -- 3 Mins
    },
    {
        startJob = "24/7",
        jobName = "Grove Str Store",
        jobTrailerCode = "trailers",
        jobTrailerLiv = 3,
        -- giveMoney = 10000,
        finalLocation = {x=-17.5638, y=-1766.689, z=29.1402},
        time = 120000, -- 2 Mins
    },
    {
        startJob = "24/7",
        jobName = "Strawberry Store",
        jobTrailerCode = "trailers",
        jobTrailerLiv = 3,
        -- giveMoney = 10000,
        finalLocation = {x=-22.0919, y=-1307.718, z=29.2381},
        time = 120000, -- 2 Mins
    },
    {
        startJob = "24/7",
        jobName = "Murrieta Heights Store",
        jobTrailerCode = "trailers",
        jobTrailerLiv = 3,
        -- giveMoney = 10000,
        finalLocation = {x=1148.3676, y=-988.5480, z=45.7874},
        time = 180000, -- 3 Mins
    },
    {
        startJob = "24/7",
        jobName = "Mirror Park Store",
        jobTrailerCode = "trailers",
        jobTrailerLiv = 3,
        -- giveMoney = 10000,
        finalLocation = {x=1173.2247, y=-315.9913, z=69.1788},
        time = 240000, -- 4 Mins
    },
    {
        startJob = "24/7",
        jobName = "Little Soul Store",
        jobTrailerCode = "trailers",
        jobTrailerLiv = 3,
        -- giveMoney = 10000,
        finalLocation = {x=-707.5034, y=-926.2511, z=19.0139},
        time = 300000, -- 5 Mins
    },
    {
        startJob = "24/7",
        jobName = "Vespucci Store",
        jobTrailerCode = "trailers",
        jobTrailerLiv = 3,
        -- giveMoney = 10000,
        finalLocation = {x=-1223.507, y=-892.9241, z=12.3428},
        time = 300000, -- 5 Mins
    },
    {
        startJob = "24/7",
        jobName = "Morningwood Store",
        jobTrailerCode = "trailers",
        jobTrailerLiv = 3,
        -- giveMoney = 10000,
        finalLocation = {x=-1461.033, y=-383.3216, z=38.7019},
        time = 300000, -- 5 Mins
    },
    {
        startJob = "24/7",
        jobName = "Chumash Store",
        jobTrailerCode = "trailers",
        jobTrailerLiv = 3,
        -- giveMoney = 10000,
        finalLocation = {x=-2958.059, y=400.0016, z=15.0390},
        time = 300000, -- 5 Mins
    },
    {
        startJob = "24/7",
        jobName = "Palomino Store",
        jobTrailerCode = "trailers",
        jobTrailerLiv = 3,
        -- giveMoney = 10000,
        finalLocation = {x=2565.0811, y=397.6402, z=108.4640},
        time = 480000, -- 8 Mins
    },
    {
        startJob = "24/7",
        jobName = "Route 68 Store",
        jobTrailerCode = "trailers",
        jobTrailerLiv = 3,
        -- giveMoney = 10000,
        finalLocation = {x=1162.5521, y=2726.5342, z=38.0041},
        time = 480000, -- 8 Mins
    },
    {
        startJob = "24/7",
        jobName = "Senora Store",
        jobTrailerCode = "trailers",
        jobTrailerLiv = 3,
        -- giveMoney = 10000,
        finalLocation = {x=2655.2563, y=3265.6750, z=55.2406},
        time = 480000, -- 8 Mins
    },
    {
        startJob = "24/7",
        jobName = "Sandy Shores Store",
        jobTrailerCode = "trailers",
        jobTrailerLiv = 3,
        -- giveMoney = 10000,
        finalLocation = {x=1962.8306, y=3766.7546, z=32.1970},
        time = 480000, -- 8 Mins
    },
    {
        startJob = "24/7",
        jobName = "Grapeseed Store",
        jobTrailerCode = "trailers",
        jobTrailerLiv = 3,
        -- giveMoney = 10000,
        finalLocation = {x=1716.1366, y=4938.3887, z=42.0783},
        time = 480000, -- 8 Mins
    }
}