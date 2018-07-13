module Messages exposing (..)

import Seed exposing (Seed)
import Time exposing (Time)


type Msg
    = Tick Time
    | NoOp
    | SelectSeed Seed
    | PlantSeed Int Int (Maybe Seed)
