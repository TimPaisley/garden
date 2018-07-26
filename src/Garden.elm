module Garden exposing (..)

import Array2D exposing (Array2D)
import Item exposing (Item)


type alias Garden =
    Array2D (Maybe Item)


init : Int -> Garden
init size =
    Array2D.repeat size size Nothing
