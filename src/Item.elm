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


type alias SeedOptions =
    { maturity : Int
    , age : Int
    , color : String
    }


type alias ToolOptions =
    { effect : Item -> Item
    , area : ( Int, Int ) -> List ( Int, Int )
    }
