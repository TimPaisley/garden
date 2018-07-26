module Update exposing (..)

import Inventory exposing (addItemToInventory, removeItemFromInventory)
import Item exposing (Item)
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
                        Just ( item, ( row, column ), _ ) ->
                            ( Array2D.set row column (Just item) model.garden, removeItemFromInventory item model.inventory )

                        Nothing ->
                            ( model.garden, model.inventory )
            in
                ( { model | seedDragDrop = newSeedDragDrop, garden = newGarden, inventory = newInventory }, Cmd.none )

        ClickItem row column item ->
            let
                harvestSeed =
                    Array2D.set row column Nothing model.garden

                growSeed options =
                    Array2D.set row column (Just { item | options = Item.Seed { options | age = options.age + 1 } }) model.garden

                newModel =
                    case item.options of
                        Item.Seed options ->
                            if options.age >= options.maturity then
                                { model | bank = model.bank + (item.cost * 2), garden = harvestSeed }
                            else
                                { model | garden = growSeed options }

                        Item.Tool options ->
                            model
            in
                ( newModel, Cmd.none )

        PurchaseItem item ->
            let
                ( newInventory, newBank ) =
                    if model.bank >= item.cost then
                        ( addItemToInventory item model.inventory, model.bank - item.cost )
                    else
                        ( model.inventory, model.bank )
            in
                ( { model | inventory = newInventory, bank = newBank }, Cmd.none )
