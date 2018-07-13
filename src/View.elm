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
    div [ class "container" ] [ banner, content model ]


banner : Html Messages.Msg
banner =
    div [ class "banner" ]
        [ h1 [ class "title" ] [ text "Garden" ]
        , h2 [ class "subtitle" ] [ text "Plant Stuff and Profit" ]
        ]


content : Model -> Html Messages.Msg
content model =
    div [ class "content" ]
        [ div [ class "seeds" ] (listSeedOptions model.selected)
        , div [ class "garden" ] (renderGarden model.garden model.selected)
        ]


listSeedOptions : Maybe Seed -> List (Html Messages.Msg)
listSeedOptions selected =
    let
        seedOption seed =
            let
                { name, maturity, description, image, cost } =
                    seed
            in
                div
                    [ classList [ ( "seed-option", True ), ( "seed-selected", (Just seed) == selected ) ]
                    , onClick <| SelectSeed seed
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
        plot row column seed =
            let
                plotActive =
                    selectedSeed /= Nothing && seed == Nothing

                msg =
                    if plotActive then
                        PlantSeed row column selectedSeed
                    else
                        NoOp
            in
                div
                    [ classList [ ( "plot", True ), ( "plot-active", plotActive ) ], onClick msg ]
                    (renderSeed seed)

        renderSeed seed =
            case seed of
                Just s ->
                    [ img [ class "plot-seed", src s.image ] [] ]

                Nothing ->
                    []

        flatten2DToList : Array2D a -> List a
        flatten2DToList array2D =
            Array.toList <| Array.foldr Array.append Array.empty array2D.data
    in
        Array2D.indexedMap plot garden |> flatten2DToList
