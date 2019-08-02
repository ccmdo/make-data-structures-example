module Api.Endpoint exposing (Endpoint, character, characters, request)

import Http
import Url.Builder exposing (QueryParameter)


request : EndpointRequest a -> Cmd a
request config =
    Http.request
        { url = unwrap config.endpoint
        , expect = config.expect
        , method = config.method
        , headers = config.headers
        , body = config.body
        , timeout = config.timeout
        , tracker = config.tracker
        }



-- TYPES


type Endpoint
    = Endpoint String


type alias EndpointRequest a =
    { endpoint : Endpoint
    , expect : Http.Expect a
    , method : String
    , headers : List Http.Header
    , body : Http.Body
    , timeout : Maybe Float
    , tracker : Maybe String
    }



-- HELPERS


unwrap : Endpoint -> String
unwrap (Endpoint str) =
    str


url : List String -> List QueryParameter -> Endpoint
url paths queryParams =
    Url.Builder.crossOrigin "http://localhost:3000"
        ("api" :: paths)
        queryParams
        |> Endpoint



-- ENDPOINTS


character : String -> Endpoint
character name =
    url [ "characters", name ] []


characters : Endpoint
characters =
    url [ "characters" ] []
