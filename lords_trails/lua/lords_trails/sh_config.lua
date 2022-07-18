LTrails.Config.NPC = {
    HeadText = "Trails",
    Model = "models/Barney.mdl",
}

LTrails.Config.Trails = {
    --[[
    Example on how to add a trail
    {
        name = "Hearts", -- Name 
        price = 10000, -- Price
        path = "trails/love", -- Material Path
        id = "trails:Unique", -- Unique ID
        bones = { -- Bone that the trail attaches to
            "Head",
            "Chest",
            "Feet",
        },
    },
    ]]--
    {
        name = "Hearts",
        price = 10000,
        path = "trails/love",
        id = "LTrail:Hearts",
        bones = {
            "Feet",
        },
    },
    {
        name = "Smoke",
        price = 15000,
        path = "trails/smoke",
        id = "LTrail:Smoke",
        bones = {
            "Chest",
        },
    },
    {
        name = "Physics Beam",
        price = 2500,
        path = "trails/physbeam",
        id = "LTrail:PhysBeam",
        bones = {
            "Feet",
        },
    },
    {
        name = "Tube",
        price = 10000,
        path = "trails/tube",
        id = "LTrail:Tube",
        bones = {
            "Head",
            "Feet",
        },
    },
    {
        name = "Electric",
        price = 10000,
        path = "trails/electric",
        id = "LTrail:Electric",
        bones = {
            "Head",
            "Chest",
            "Feet",
        },
    },
    {
        name = "Plasma",
        price = 3000,
        path = "trails/plasma",
        id = "LTrail:Plasma",
        bones = {
            "Head",
            "Feet",
        },
    },
    {
        name = "Laser",
        price = 10000,
        path = "trails/laser",
        id = "LTrail:Laser",
        bones = {
            "Head",
            "Feet",
        },
    },
    {
        name = "LOL",
        price = 10000,
        path = "trails/lol",
        id = "LTrail:LOL",
        bones = {
            "Feet",
        },
    },
}