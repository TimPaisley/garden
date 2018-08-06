module Project exposing (..)


type alias Project =
    { name : String
    , description : String
    , image : String
    , cost : Int
    , perk : Perk
    }


type Perk
    = UnlockTools
    | ProfitMultiplier1


allProjects : List Project
allProjects =
    [ unlockTools, profitMultiplier1 ]


unlockTools : Project
unlockTools =
    { name = "Roadtrip to Bunnings"
    , description = "Unlock Tools in the Shop"
    , image = "https://image.flaticon.com/icons/svg/222/222586.svg"
    , cost = 1000
    , perk = UnlockTools
    }


profitMultiplier1 : Project
profitMultiplier1 =
    { name = "\"GE Free\" Marketing"
    , description = "Earn 1.5x profit for each harvested crop"
    , image = "https://image.flaticon.com/icons/svg/138/138255.svg"
    , cost = 2500
    , perk = ProfitMultiplier1
    }
