module Main exposing (main)

import Browser
import Page.Character as Page


main : Program () Page.Model Page.Msg
main =
    Browser.element
        { init = Page.init
        , view = Page.view
        , update = Page.update
        , subscriptions = always Sub.none
        }
