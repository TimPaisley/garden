module Model exposing (..)

import Messages exposing (Msg)
import Seed exposing (Seed)
import Array2D exposing (Array2D)


type alias Model =
    { time : Int
    , garden : Array2D (Maybe Seed)
    , selected : Maybe Seed
    , bank : Int
    }


initialModel : Model
initialModel =
    let
        size =
            9
    in
        { time = 0
        , garden = Array2D.repeat size size Nothing
        , selected = Nothing
        , bank = 100
        }


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )
