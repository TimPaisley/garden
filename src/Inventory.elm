module Inventory exposing (..)

import Item exposing (Item)
import Seeds
import AllDict exposing (AllDict)


type alias Inventory =
    AllDict Item Int String


init : Inventory
init =
    AllDict.fromList .name [ ( Seeds.apple, 10 ), ( Seeds.orange, 5 ) ]


addItemToInventory : Item -> Inventory -> Inventory
addItemToInventory item inventory =
    let
        update : Maybe Int -> Maybe Int
        update count =
            Maybe.map (\i -> i + 1) count
    in
        if Maybe.map (\i -> i > 0) (AllDict.get item inventory) == Just True then
            AllDict.update item update inventory
        else
            AllDict.insert item 1 inventory


removeItemFromInventory : Item -> Inventory -> Inventory
removeItemFromInventory item inventory =
    let
        update : Maybe Int -> Maybe Int
        update count =
            Maybe.map (\i -> i - 1) count
    in
        if Maybe.map (\i -> i > 0) (AllDict.get item inventory) == Just True then
            AllDict.update item update inventory
        else
            AllDict.remove item inventory
