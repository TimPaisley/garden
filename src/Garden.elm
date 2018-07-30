module Garden exposing (..)

import Array
import Array2D exposing (Array2D)
import Item exposing (Item)


type alias Garden =
    Array2D (Maybe Item)


init : Int -> Garden
init size =
    Array2D.repeat size size Nothing


updateItems : List ( Int, Int ) -> (Item -> Item) -> Garden -> Garden
updateItems coordinates update garden =
    let
        updateItem row column item =
            if List.member ( row, column ) coordinates then
                Maybe.map update item
            else
                item
    in
        Array2D.indexedMap updateItem garden


flatten : Garden -> List ( Int, Maybe Item )
flatten garden =
    Array.foldr (++) [] (Array.map Array.toList garden.data)
        |> List.indexedMap (,)
