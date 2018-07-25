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
            ( { model | time = model.time + 1 }, Cmd.none )

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

        ClickSeed row column seed ->
            let
                harvestSeed =
                    Array2D.set row column Nothing model.garden

                growSeed =
                    Array2D.set row column (Just { seed | age = seed.age + 1 }) model.garden

                newModel =
                    if seed.age >= seed.maturity then
                        { model | bank = model.bank + (seed.cost * 2), garden = harvestSeed }
                    else
                        { model | garden = growSeed }
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
