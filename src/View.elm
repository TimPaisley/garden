module View exposing (..)

import Messages exposing (Msg(..))
import Model exposing (Model)
import Seed exposing (Seed)
import Array exposing (Array)
import Array2D exposing (Array2D)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import FormatNumber exposing (format)
import FormatNumber.Locales exposing (usLocale)
import FontAwesome exposing (icon)


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
        , div [ class "bank" ] [ text <| toString bank ]
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
        [ div [ class "seeds" ] (listSeedOptions model.selected model.bank)
        , div [ class "garden" ] (renderGarden model.garden model.selected)
        ]


listSeedOptions : Maybe Seed -> Int -> List (Html Messages.Msg)
listSeedOptions selected bank =
    let
        seedOption seed =
            let
                { name, description, image, cost } =
                    seed

                disabled =
                    cost > bank

                msg =
                    if disabled then
                        NoOp
                    else
                        SelectSeed seed
            in
                div
                    [ classList [ ( "seed-option", True ), ( "seed-selected", (Just seed) == selected ), ( "seed-option-disabled", disabled ) ]
                    , onClick msg
                    ]
                    [ img [ class "seed-image", src image, height 30 ] []
                    , div [ class "seed-details" ]
                        [ div [ class "seed-name" ] [ text <| name ++ " Seeds" ]
                        , div [ class "seed-description" ] [ text description ]
                        ]
                    , div [ class "seed-cost" ] [ text <| toString cost ]
                    ]
    in
        List.map seedOption Seed.allSeeds


renderGarden : Array2D (Maybe Seed) -> Maybe Seed -> List (Html Messages.Msg)
renderGarden garden selectedSeed =
    let
        plot row column plantedSeed =
            let
                clickMsg =
                    case ( plantedSeed, selectedSeed ) of
                        ( Nothing, Just selected ) ->
                            PlantSeed row column selected

                        ( Just planted, Nothing ) ->
                            HarvestSeed row column planted

                        ( _, _ ) ->
                            NoOp
            in
                div
                    [ classList [ ( "plot", True ), ( "plot-active", selectedSeed /= Nothing && plantedSeed == Nothing ) ]
                    , onClick clickMsg
                    ]
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
