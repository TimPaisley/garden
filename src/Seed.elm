module Seed exposing (..)


type alias Seed =
    { name : String
    , maturity : Int
    , color : String
    , description : String
    , image : String
    , cost : Int
    }


allSeeds : List Seed
allSeeds =
    [ { name = "Apple"
      , maturity = 30
      , color = "red"
      , description = "Reaches maturity in 30s"
      , image = "https://image.flaticon.com/icons/svg/135/135728.svg"
      , cost = 10
      }
    , { name = "Orange"
      , maturity = 40
      , color = "orange"
      , description = "Reaches maturity in 40s"
      , image = "https://image.flaticon.com/icons/svg/135/135620.svg"
      , cost = 12
      }
    , { name = "Banana"
      , maturity = 60
      , color = "yellow"
      , description = "Reaches maturity in 60s"
      , image = "https://image.flaticon.com/icons/svg/135/135631.svg"
      , cost = 15
      }
    , { name = "Lettuce"
      , maturity = 90
      , color = "green"
      , description = "Reaches maturity in 90s"
      , image = "https://image.flaticon.com/icons/svg/135/135699.svg"
      , cost = 25
      }
    , { name = "Grapes"
      , maturity = 120
      , color = "purple"
      , description = "Reaches maturity in 120s"
      , image = "https://image.flaticon.com/icons/svg/135/135542.svg"
      , cost = 30
      }
    ]
