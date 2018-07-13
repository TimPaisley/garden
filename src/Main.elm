module Main exposing (..)

import Html exposing (program)
import Model exposing (Model, init)
import View exposing (view)
import Update exposing (update)
import Messages exposing (Msg(..))
import Time exposing (every, second, millisecond)


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Messages.Msg
subscriptions model =
    every second Tick
