module Shop exposing (..)

import Item exposing (Item)
import Seeds exposing (allSeeds)
import Tools exposing (allTools)


type alias Shop =
    { activeSection : ShopSection
    }


init : Shop
init =
    { activeSection = Seeds
    }


nextSection : Shop -> Shop
nextSection shop =
    case shop.activeSection of
        Seeds ->
            { shop | activeSection = Tools }

        Tools ->
            { shop | activeSection = Seeds }


previousSection : Shop -> Shop
previousSection shop =
    case shop.activeSection of
        Seeds ->
            { shop | activeSection = Tools }

        Tools ->
            { shop | activeSection = Seeds }


shopItems : Shop -> List Item
shopItems shop =
    case shop.activeSection of
        Seeds ->
            allSeeds

        Tools ->
            allTools


type ShopSection
    = Seeds
    | Tools
