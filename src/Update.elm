module Update exposing (..)

import Inventory exposing (addSeedToInventory, removeSeedFromInventory)
import Model exposing (Model)
import Messages exposing (Msg(..))
import Array2D exposing (Array2D)
import Html5.DragDrop


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

        DragDropMsg msg_ ->
            let
                ( newDragDrop, result ) =
                    Html5.DragDrop.update msg_ model.seedDragDrop.dragDrop

                dragId =
                    Html5.DragDrop.getDragId newDragDrop

                dropId =
                    Html5.DragDrop.getDropId newDragDrop

                newSeedDragDrop =
                    case ( dragId, dropId ) of
                        ( Just _, _ ) ->
                            { dragDrop = newDragDrop, hoverPos = dropId }

                        _ ->
                            model.seedDragDrop

                ( newGarden, newInventory ) =
                    case result of
                        Just ( seed, ( row, column ), _ ) ->
                            ( Array2D.set row column (Just seed) model.garden, removeSeedFromInventory seed model.inventory )

                        Nothing ->
                            ( model.garden, model.inventory )
            in
                ( { model | seedDragDrop = newSeedDragDrop, garden = newGarden, inventory = newInventory }, Cmd.none )

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

        PurchaseSeed seed ->
            let
                ( newInventory, newBank ) =
                    if model.bank >= seed.cost then
                        ( addSeedToInventory seed model.inventory, model.bank - seed.cost )
                    else
                        ( model.inventory, model.bank )
            in
                ( { model | inventory = newInventory, bank = newBank }, Cmd.none )
