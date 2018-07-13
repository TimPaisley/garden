module View exposing (..)

import Messages exposing (Msg(..))
import Model exposing (Model)
import Plant exposing (Plant)
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
        [ div [ class "seeds" ] (renderSeeds)
        , div [ class "garden" ] (renderGarden model.garden)
        ]


renderSeeds : List (Html Messages.Msg)
renderSeeds =
    let
        seedOption seed =
            div [ class "seed-option" ]
                [ img [ class "seed-image", src <| Plant.seedImage seed, height 30 ] []
                , div [ class "seed-details" ]
                    [ div [ class "seed-name" ] [ text <| (toString seed) ++ " Seeds" ]
                    , div [ class "seed-description" ] [ text <| Plant.seedDescription seed ]
                    ]
                , div [ class "seed-cost" ] [ text <| toString (Plant.seedCost seed) ]
                ]
    in
        List.map seedOption Plant.allSeeds


renderGarden : Array2D (Maybe Plant) -> List (Html Messages.Msg)
renderGarden garden =
    let
        plot p =
            div [ class "plot" ] (renderSeed p)

        renderSeed plant =
            case plant of
                Just p ->
                    [ img [ class "plot-seed", src <| Plant.seedImage p.seed ] [] ]

                Nothing ->
                    []

        flatten2DToList : Array2D a -> List a
        flatten2DToList array2D =
            Array.toList <| Array.foldr Array.append Array.empty array2D.data
    in
        Array2D.map (\p -> plot p) garden |> flatten2DToList
