module Messages exposing (..)

import Item exposing (Item)
import Time exposing (Time)
import Html5.DragDrop


type Msg
    = Tick Time
    | NoOp
    | DragDropMsg (Html5.DragDrop.Msg Item ( Int, Int ))
    | ClickItem Int Int Item
    | PurchaseItem Item
    | ShopNextSection
    | ShopPreviousSection
