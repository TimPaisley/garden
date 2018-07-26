module Item exposing (..)


type alias Item =
    { name : String
    , description : String
    , image : String
    , cost : Int
    , options : ItemOptions
    }


type ItemOptions
    = Seed SeedOptions
    | Tool ToolOptions



-- SEEDS


type alias SeedOptions =
    { maturity : Int
    , age : Int
    , color : String
    }


allSeeds : List Item
allSeeds =
    [ apple
    , orange
    , banana
    , lettuce
    , grape
    ]


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
        { name = "Apple"
        , description = "Reaches maturity in 30s"
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
        { name = "Orange"
        , description = "Reaches maturity in 40s"
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
        { name = "Banana"
        , description = "Reaches maturity in 60s"
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
        { name = "Lettuce"
        , description = "Reaches maturity in 90s"
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
        { name = "Grape"
        , description = "Reaches maturity in 120s"
        , image = "https://image.flaticon.com/icons/svg/135/135542.svg"
        , cost = 30
        , options = options
        }



-- TOOLS


type alias ToolOptions =
    { thing : String
    }
