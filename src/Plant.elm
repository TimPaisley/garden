module Plant exposing (..)

import Char


type alias Plant =
    { seed : Seed
    , age : Int
    }


type Seed
    = Carrot
    | Tomato
    | Orange
    | Pineapple
    | Strawberry


allSeeds : List Seed
allSeeds =
    [ Carrot, Tomato, Orange, Pineapple, Strawberry ]


seedImage : Seed -> String
seedImage seed =
    case seed of
        Carrot ->
            "https://image.flaticon.com/icons/svg/135/135687.svg"

        Tomato ->
            "https://image.flaticon.com/icons/svg/135/135702.svg"

        Orange ->
            "https://image.flaticon.com/icons/svg/135/135620.svg"

        Pineapple ->
            "https://image.flaticon.com/icons/svg/135/135598.svg"

        Strawberry ->
            "https://image.flaticon.com/icons/svg/135/135717.svg"


seedDescription : Seed -> String
seedDescription seed =
    case seed of
        Carrot ->
            "Carrot on my Wayward Son"

        Tomato ->
            "Toe-May-Toe Toe-Mah-Toe"

        Orange ->
            "Orange you glad you're playing this game?"

        Pineapple ->
            "That's a pine apple you've got there"

        Strawberry ->
            "These straw are berry tasty"


seedCost : Seed -> Int
seedCost seed =
    case seed of
        Carrot ->
            10

        Tomato ->
            12

        Orange ->
            15

        Pineapple ->
            25

        Strawberry ->
            30
