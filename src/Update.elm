module Update exposing (..)

import Model exposing (Model)
import Messages exposing (Msg(..))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick _ ->
            ( { model | time = model.time + 1 }, Cmd.none )

        NoOp ->
            ( model, Cmd.none )
