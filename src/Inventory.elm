module Inventory exposing (..)

import Seed exposing (Seed)
import AllDict exposing (AllDict)


type alias Inventory =
    AllDict Seed Int String


init : Inventory
init =
    AllDict.fromList .name [ ( Seed.apple, 10 ), ( Seed.orange, 5 ) ]


addSeedToInventory : Seed -> Inventory -> Inventory
addSeedToInventory seed inventory =
    let
        update : Maybe Int -> Maybe Int
        update count =
            Maybe.map (\i -> i + 1) count
    in
        if Maybe.map (\i -> i > 0) (AllDict.get seed inventory) == Just True then
            AllDict.update seed update inventory
        else
            AllDict.insert seed 1 inventory


removeSeedFromInventory : Seed -> Inventory -> Inventory
removeSeedFromInventory seed inventory =
    let
        update : Maybe Int -> Maybe Int
        update count =
            Maybe.map (\i -> i - 1) count
    in
        if Maybe.map (\i -> i > 0) (AllDict.get seed inventory) == Just True then
            AllDict.update seed update inventory
        else
            AllDict.remove seed inventory
