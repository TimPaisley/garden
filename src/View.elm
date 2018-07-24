module View exposing (..)

import Inventory exposing (Inventory)
import Messages exposing (Msg(..))
import Model exposing (Model)
import Seed exposing (Seed)
import Array exposing (Array)
import AllDict exposing (AllDict)
import Array2D exposing (Array2D)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import FormatNumber exposing (format)
import FormatNumber.Locales exposing (usLocale)
import FontAwesome exposing (icon)
import Html5.DragDrop


view : Model -> Html Messages.Msg
view model =
    div [ class "container" ] [ banner model.time model.bank, content model ]


banner : Int -> Int -> Html Messages.Msg
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
        ]


renderInventory : Inventory -> List (Html Messages.Msg)
renderInventory inventory =
    let
        stack ( seed, count ) =
            if count > 0 then
                div [ class "seed-option", style [ ( "border-color", seed.color ) ] ]
                    [ img ([ class "seed-image", src seed.image ] ++ Html5.DragDrop.draggable DragDropMsg seed) []
                    , div [ class "seed-count", style [ ( "background-color", seed.color ) ] ] [ text <| toString count ]
                    ]
            else
                div [] []
    in
        AllDict.toList inventory
            |> List.map stack


renderGarden : Array2D (Maybe Seed) -> List (Html Messages.Msg)
renderGarden garden =
    let
        plot row column plantedSeed =
            let
                clickMsg =
                    case plantedSeed of
                        Just planted ->
                            HarvestSeed row column planted

                        _ ->
                            NoOp

                droppable =
                    case plantedSeed of
                        Just _ ->
                            []

                        Nothing ->
                            Html5.DragDrop.droppable DragDropMsg ( row, column )
            in
                div
                    ([ class "plot", onClick clickMsg ] ++ droppable)
                    (renderSeed plantedSeed)

        renderSeed seed =
            case seed of
                Just s ->
                    let
                        background =
                            if s.maturity <= 0 then
                                div [ class "plot-background", style [ ( "background-color", s.color ) ] ] []
                            else
                                div [] []
                    in
                        [ background
                        , img [ class "plot-seed", src s.image ] []
                        ]

                Nothing ->
                    []

        flatten2DToList : Array2D a -> List a
        flatten2DToList array2D =
            Array.toList <| Array.foldr Array.append Array.empty array2D.data
    in
        Array2D.indexedMap plot garden |> flatten2DToList
