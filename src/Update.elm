module Update exposing (..)

import Model exposing (Model)
import Messages exposing (Msg(..))
import Array2D exposing (Array2D)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick _ ->
            let
                newGarden =
                    Array2D.map (Maybe.map updateMaturity) model.garden

                updateMaturity s =
                    { s | maturity = s.maturity - 5 }
            in
                ( { model | time = model.time + 1, garden = newGarden }, Cmd.none )

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
                    Array2D.set row column (Just seed) model.garden

                newModel =
                    if seed.cost <= model.bank then
                        { model | garden = newGarden, selected = Nothing, bank = model.bank - seed.cost }
                    else
                        model
            in
                ( newModel, Cmd.none )

        HarvestSeed row column seed ->
            let
                newGarden =
                    Array2D.set row column Nothing model.garden

                newModel =
                    if seed.maturity <= 0 then
                        { model | bank = model.bank + (seed.cost * 2), garden = newGarden }
                    else
                        model
            in
                ( newModel, Cmd.none )
