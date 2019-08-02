module Page.Character exposing (main)

import Browser
import Data.Character as Character exposing (Character)
import Html exposing (Html, div, text)
import Html.Attributes exposing (class)
import Http
import RemoteData exposing (WebData)



-- MODEL


type alias Model =
    { character : WebData Character }


initialCharacterToLoad =
    -- could come from Flags for example
    "ccmdo"


init : () -> ( Model, Cmd Msg )
init () =
    ( { character = RemoteData.Loading }
    , Character.fetch initialCharacterToLoad FinishedLoadingCharacter
    )



-- VIEW


view : Model -> Html Msg
view model =
    case model.character of
        RemoteData.Success character ->
            div
                [ class "character__container" ]
                [ viewCharacter character ]

        RemoteData.Loading ->
            div
                [ class "loading" ]
                [ text "Loading" ]

        RemoteData.Failure _ ->
            div
                [ class "loading--failed" ]
                [ div [] [ text "Failed to load character" ]
                ]

        RemoteData.NotAsked ->
            text ""


viewCharacter : Character -> Html Msg
viewCharacter character =
    div
        [ class "character" ]
        [ text (Character.name character) ]



-- UPDATE


type Msg
    = FinishedLoadingCharacter (WebData Character)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        FinishedLoadingCharacter response ->
            ( { model | character = response }, Cmd.none )


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = always Sub.none
        }
