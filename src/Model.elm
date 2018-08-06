module Model exposing (..)

import Garden exposing (Garden)
import Item exposing (Item)
import Inventory exposing (Inventory)
import Messages exposing (Msg)
import Shop exposing (Shop)
import Html5.DragDrop


type alias Model =
    { time : Float
    , garden : Garden
    , inventory : Inventory
    , shop : Shop
    , bank : Int
    , seedDragDrop : SeedDragDrop
    }


type alias SeedDragDrop =
    { dragDrop : Html5.DragDrop.Model Item ( Int, Int )
    , hoverPos : Maybe ( Int, Int )
    }


initialModel : Model
initialModel =
    let
        size =
            9
    in
        { time = 0
        , garden = Garden.init size
        , inventory = Inventory.init
        , shop = Shop.init
        , bank = 100
        , seedDragDrop = { dragDrop = Html5.DragDrop.init, hoverPos = Nothing }
        }


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )
