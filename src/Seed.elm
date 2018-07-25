module Seed exposing (..)


type alias Seed =
    { name : String
    , maturity : Int
    , age : Int
    , color : String
    , description : String
    , image : String
    , cost : Int
    }


allSeeds : List Seed
allSeeds =
    [ apple
    , orange
    , banana
    , lettuce
    , grape
    ]


apple : Seed
apple =
    { name = "Apple"
    , maturity = 10
    , age = 0
    , color = "#D13834"
    , description = "Reaches maturity in 30s"
    , image = "https://image.flaticon.com/icons/svg/135/135728.svg"
    , cost = 10
    }


orange : Seed
orange =
    { name = "Orange"
    , maturity = 12
    , age = 0
    , color = "#ED8F20"
    , description = "Reaches maturity in 40s"
    , image = "https://image.flaticon.com/icons/svg/135/135620.svg"
    , cost = 12
    }


banana : Seed
banana =
    { name = "Banana"
    , maturity = 15
    , age = 0
    , color = "#E8C52E"
    , description = "Reaches maturity in 60s"
    , image = "https://image.flaticon.com/icons/svg/135/135631.svg"
    , cost = 15
    }


lettuce : Seed
lettuce =
    { name = "Lettuce"
    , maturity = 20
    , age = 0
    , color = "#659C35"
    , description = "Reaches maturity in 90s"
    , image = "https://image.flaticon.com/icons/svg/135/135699.svg"
    , cost = 25
    }


grape : Seed
grape =
    { name = "Grape"
    , maturity = 30
    , age = 0
    , color = "#6F58A8"
    , description = "Reaches maturity in 120s"
    , image = "https://image.flaticon.com/icons/svg/135/135542.svg"
    , cost = 30
    }
