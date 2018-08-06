module Update exposing (..)

import Array
import Garden exposing (Garden)
import Inventory exposing (addItemToInventory, removeItemFromInventory)
import Item exposing (Item)
import Model exposing (Model)
import Messages exposing (Msg(..))
import Seeds
import Shop
import Tools
import Array2D exposing (Array2D)
import Html5.DragDrop


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick _ ->
            let
                effectArea =
                    Array2D.columns model.garden
                        |> Tools.toolToEffectArea

                toolEffects =
                    Garden.flatten model.garden
                        |> List.filterMap effectArea

                newGarden =
                    List.foldl (uncurry Garden.updateItems) model.garden toolEffects
            in
                ( { model | time = model.time + 0.5, garden = newGarden }, Cmd.none )

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
                    Array2D.set row column (Just { item | options = Item.Seed (Seeds.growSeed options) }) model.garden

                newModel =
                    case item.options of
                        Item.Seed options ->
                            if options.age >= options.maturity then
                                { model | bank = model.bank + (Seeds.calculateProfit item.cost model.projects), garden = harvestSeed }
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

        ShopNextSection ->
            ( { model | shop = Shop.nextSection model.shop }, Cmd.none )

        ShopPreviousSection ->
            ( { model | shop = Shop.previousSection model.shop }, Cmd.none )

        ResearchProject project ->
            let
                ( newProjects, newBank ) =
                    if model.bank >= project.cost then
                        ( project :: model.projects, model.bank - project.cost )
                    else
                        ( model.projects, model.bank )
            in
                ( { model | projects = newProjects, bank = newBank }, Cmd.none )
