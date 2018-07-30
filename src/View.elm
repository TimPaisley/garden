module View exposing (..)

import Item exposing (Item)
import Inventory exposing (Inventory)
import Messages exposing (Msg(..))
import Model exposing (Model)
import Seeds
import Tools
import Array exposing (Array)
import AllDict exposing (AllDict)
import Array2D exposing (Array2D)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html5.DragDrop


view : Model -> Html Messages.Msg
view model =
    div [ class "container" ] [ banner model.time model.bank, content model ]


banner : Float -> Int -> Html Messages.Msg
banner time bank =
    div [ class "banner" ]
        [ div []
            [ h1 [ class "title" ] [ text "Garden" ]
            , h2 [ class "subtitle" ] [ text "Plant Stuff and Profit" ]
            ]
        ]


formatTime : Int -> String
formatTime time =
    let
        timeOfDay =
            time % 12

        timeString =
            if timeOfDay < 10 then
                if timeOfDay == 0 then
                    "12"
                else
                    "0" ++ (toString timeOfDay)
            else
                (toString timeOfDay)

        meridian =
            if (time // 12) % 2 == 0 then
                " AM"
            else
                " PM"
    in
        timeString ++ meridian


content : Model -> Html Messages.Msg
content model =
    div [ class "content" ]
        [ div [ class "seeds" ] (renderInventory model.inventory)
        , div [ class "garden" ] (renderGarden model.garden)
        , div [ class "shop" ] (renderShop model.bank)
        , div [ class "research" ] (renderResearch)
        ]


renderInventory : Inventory -> List (Html Messages.Msg)
renderInventory inventory =
    let
        color item =
            case item.options of
                Item.Seed options ->
                    options.color

                _ ->
                    "black"

        stack ( item, count ) =
            if count > 0 then
                div [ class "seed-option", style [ ( "border-color", color item ) ] ]
                    [ img ([ class "seed-image", src item.image ] ++ Html5.DragDrop.draggable DragDropMsg item) []
                    , div [ class "seed-count", style [ ( "background-color", color item ) ] ] [ text <| toString count ]
                    ]
            else
                div [] []
    in
        AllDict.toList inventory
            |> List.map stack


renderGarden : Array2D (Maybe Item) -> List (Html Messages.Msg)
renderGarden garden =
    let
        plot row column planted =
            let
                clickMsg =
                    case planted of
                        Just p ->
                            ClickItem row column p

                        _ ->
                            NoOp

                droppable =
                    case planted of
                        Just _ ->
                            []

                        Nothing ->
                            Html5.DragDrop.droppable DragDropMsg ( row, column )
            in
                div
                    ([ classList [ ( "plot", True ), ( "plot-active", planted /= Nothing ) ], onClick clickMsg ] ++ droppable)
                    (Maybe.withDefault [] <| Maybe.map renderItem planted)

        renderItem : Item -> List (Html Messages.Msg)
        renderItem item =
            case item.options of
                Item.Seed options ->
                    let
                        seedGrowth =
                            (toFloat options.age) / (toFloat options.maturity) * 100

                        background =
                            div
                                [ class "plot-background"
                                , style [ ( "background-color", options.color ), ( "height", (toString seedGrowth) ++ "%" ) ]
                                ]
                                []
                    in
                        [ background
                        , img [ class "plot-seed", src item.image ] []
                        ]

                Item.Tool options ->
                    [ img [ class "plot-seed", src item.image ] [] ]

        flatten2DToList : Array2D a -> List a
        flatten2DToList array2D =
            Array.toList <| Array.foldr Array.append Array.empty array2D.data
    in
        Array2D.indexedMap plot garden |> flatten2DToList


renderShop : Int -> List (Html Messages.Msg)
renderShop bank =
    let
        header =
            div [ class "section-header" ]
                [ div [ class "title" ] [ text "Shop" ]
                , div [ class "subtitle" ] [ text <| "$" ++ (toString bank) ]
                ]

        itemOption item =
            let
                { name, description, image, cost } =
                    item

                disabled =
                    cost > bank
            in
                div
                    [ classList [ ( "shop-option", True ), ( "shop-option-disabled", disabled ) ]
                    , onClick <| PurchaseItem item
                    ]
                    [ img [ class "shop-image", src image, height 30 ] []
                    , div [ class "shop-details" ]
                        [ div [ class "shop-name" ] [ text <| name ++ " Seeds" ]
                        , div [ class "shop-description" ] [ text description ]
                        ]
                    , div [ class "shop-cost" ] [ text <| toString cost ]
                    ]
    in
        header :: (List.map itemOption (Seeds.allSeeds ++ Tools.allTools))


renderResearch : List (Html Messages.Msg)
renderResearch =
    let
        header =
            div [ class "section-header" ]
                [ div [ class "title" ] [ text "Research" ]
                , div [ class "subtitle" ] [ text <| "1 point" ]
                ]
    in
        [ header ]
