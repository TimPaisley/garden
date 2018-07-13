module Update exposing (..)

import Model exposing (Model)
import Messages exposing (Msg(..))
import Array2D exposing (Array2D)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick _ ->
            ( { model | time = model.time + 1 }, Cmd.none )

        NoOp ->
            ( model, Cmd.none )

        SelectSeed s ->
            let
                newModel =
                    if model.selected == Just s then
                        { model | selected = Nothing }
                    else
                        { model | selected = Just s }
            in
                ( newModel, Cmd.none )

        PlantSeed row column seed ->
            let
                newGarden =
                    Array2D.set row column seed model.garden
            in
                ( { model | garden = newGarden, selected = Nothing }, Cmd.none )
