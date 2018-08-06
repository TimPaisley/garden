module Seeds exposing (..)

import Item exposing (Item, ItemOptions(..), SeedOptions)


allSeeds : List Item
allSeeds =
    [ apple
    , orange
    , banana
    , lettuce
    , grape
    ]


growSeed : SeedOptions -> SeedOptions
growSeed options =
    if options.age < options.maturity then
        { options | age = options.age + 1 }
    else
        options


apple : Item
apple =
    let
        options =
            Seed
                { maturity = 10
                , age = 0
                , color = "#D13834"
                }
    in
        { name = "Apple Seeds"
        , description = "Fully grown in 10 clicks"
        , image = "https://image.flaticon.com/icons/svg/135/135728.svg"
        , cost = 10
        , options = options
        }


orange : Item
orange =
    let
        options =
            Seed
                { maturity = 12
                , age = 0
                , color = "#ED8F20"
                }
    in
        { name = "Orange Seeds"
        , description = "Fully grown in 12 clicks"
        , image = "https://image.flaticon.com/icons/svg/135/135620.svg"
        , cost = 12
        , options = options
        }


banana : Item
banana =
    let
        options =
            Seed
                { maturity = 15
                , age = 0
                , color = "#E8C52E"
                }
    in
        { name = "Banana Seeds"
        , description = "Fully grown in 15 clicks"
        , image = "https://image.flaticon.com/icons/svg/135/135631.svg"
        , cost = 15
        , options = options
        }


lettuce : Item
lettuce =
    let
        options =
            Seed
                { maturity = 20
                , age = 0
                , color = "#659C35"
                }
    in
        { name = "Lettuce Seeds"
        , description = "Fully grown in 25 clicks"
        , image = "https://image.flaticon.com/icons/svg/135/135699.svg"
        , cost = 25
        , options = options
        }


grape : Item
grape =
    let
        options =
            Seed
                { maturity = 30
                , age = 0
                , color = "#6F58A8"
                }
    in
        { name = "Grape Seeds"
        , description = "Full grown in 30 clicks"
        , image = "https://image.flaticon.com/icons/svg/135/135542.svg"
        , cost = 30
        , options = options
        }
