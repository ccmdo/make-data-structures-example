module Page.Character exposing (Model, Msg, init, update, view)

import Html exposing (Html, div, text)
import Html.Attributes exposing (class)
import Http
import Models.Character as Character exposing (Character)



-- MODEL


type alias Model =
    { character : Status Character }


type Status a
    = Loading
    | Loaded a
    | Failed


initialCharacterToLoad =
    -- could come from Flags for example
    "ccmdo"


init : () -> ( Model, Cmd Msg )
init () =
    ( { character = Loading }
    , Character.fetch initialCharacterToLoad FinishedLoadingCharacter
    )



-- VIEW


view : Model -> Html Msg
view model =
    case model.character of
        Loaded character ->
            div
                [ class "character__container" ]
                [ viewCharacter character ]

        Loading ->
            div
                [ class "loading" ]
                [ text "Loading" ]

        Failed ->
            div
                [ class "loading--failed" ]
                [ text "Error loading character" ]


viewCharacter : Character -> Html Msg
viewCharacter character =
    div
        [ class "character" ]
        [ text (Character.name character) ]



-- UPDATE


type Msg
    = FinishedLoadingCharacter (Result Http.Error Character)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        FinishedLoadingCharacter response ->
            case response of
                Ok character ->
                    ( { model | character = Loaded character }, Cmd.none )

                Err error ->
                    ( { model | character = Failed }, Cmd.none )
