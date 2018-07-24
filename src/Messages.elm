module Messages exposing (..)

import Seed exposing (Seed)
import Time exposing (Time)
import Html5.DragDrop


type Msg
    = Tick Time
    | NoOp
    | DragDropMsg (Html5.DragDrop.Msg Seed ( Int, Int ))
    | SelectSeed Seed
    | PlantSeed Int Int Seed
    | HarvestSeed Int Int Seed
