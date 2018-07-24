module Model exposing (..)

import Inventory exposing (Inventory)
import Messages exposing (Msg)
import Seed exposing (Seed)
import Array2D exposing (Array2D)
import Html5.DragDrop


type alias Model =
    { time : Int
    , garden : Array2D (Maybe Seed)
    , inventory : Inventory
    , bank : Int
    , seedDragDrop : SeedDragDrop
    }


type alias SeedDragDrop =
    { dragDrop : Html5.DragDrop.Model Seed ( Int, Int )
    , hoverPos : Maybe ( Int, Int )
    }


initialModel : Model
initialModel =
    let
        size =
            9
    in
        { time = 0
        , garden = Array2D.repeat size size Nothing
        , inventory = Inventory.init
        , bank = 100
        , seedDragDrop = { dragDrop = Html5.DragDrop.init, hoverPos = Nothing }
        }


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )
