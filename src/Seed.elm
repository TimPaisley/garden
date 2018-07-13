module Seed exposing (..)


type alias Seed =
    { name : String
    , maturity : Int
    , description : String
    , image : String
    , cost : Int
    }


allSeeds : List Seed
allSeeds =
    [ { name = "Carrot"
      , maturity = 1000
      , description = "Carrot on my Wayward Son"
      , image = "https://image.flaticon.com/icons/svg/135/135687.svg"
      , cost = 10
      }
    , { name = "Tomato"
      , maturity = 1000
      , description = "Toe-May-Toe Toe-Mah-Toe"
      , image = "https://image.flaticon.com/icons/svg/135/135702.svg"
      , cost = 12
      }
    , { name = "Orange"
      , maturity = 1000
      , description = "Orange you glad you're playing this game?"
      , image = "https://image.flaticon.com/icons/svg/135/135620.svg"
      , cost = 15
      }
    , { name = "Pineapple"
      , maturity = 1000
      , description = "That's a pine apple you've got there"
      , image = "https://image.flaticon.com/icons/svg/135/135598.svg"
      , cost = 25
      }
    , { name = "Strawberry"
      , maturity = 1000
      , description = "These straw are berry tasty"
      , image = "https://image.flaticon.com/icons/svg/135/135717.svg"
      , cost = 30
      }
    ]
