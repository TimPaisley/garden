module Tools exposing (..)

import Array2D
import Garden exposing (Garden)
import Item exposing (Item, ItemOptions(..))
import Seeds


toolToEffectArea : Int -> ( Int, Maybe Item ) -> Maybe ( List ( Int, Int ), Item -> Item )
toolToEffectArea width ( index, maybeItem ) =
    let
        toolPosition =
            ( index // width, index % width )

        itemToEffectArea : Item -> Maybe ( List ( Int, Int ), Item -> Item )
        itemToEffectArea item =
            case item.options of
                Item.Tool options ->
                    Just ( options.area toolPosition, options.effect )

                _ ->
                    Nothing
    in
        Maybe.andThen itemToEffectArea maybeItem


allTools : List Item
allTools =
    [ sprinkler
    ]


sprinkler : Item
sprinkler =
    let
        effect : Item -> Item
        effect item =
            let
                newOptions =
                    case item.options of
                        Item.Seed options ->
                            Seed (Seeds.growSeed options)

                        _ ->
                            item.options
            in
                { item | options = newOptions }

        area : ( Int, Int ) -> List ( Int, Int )
        area ( row, column ) =
            [ ( row - 1, column )
            , ( row + 1, column )
            , ( row, column - 1 )
            , ( row, column + 1 )
            , ( row - 1, column - 1 )
            , ( row + 1, column + 1 )
            , ( row - 1, column + 1 )
            , ( row + 1, column - 1 )
            ]

        options =
            Tool
                { effect = effect
                , area = area
                }
    in
        { name = "Sprinkler"
        , description = "Grows all adjacent seeds once every 0.5s"
        , image = "https://image.flaticon.com/icons/svg/135/135746.svg"
        , cost = 100
        , options = options
        }
