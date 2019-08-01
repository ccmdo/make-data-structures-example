module Api.Endpoint exposing (Endpoint, character, characters, request)

import Http
import Url.Builder exposing (QueryParameter)


request :
    { body : Http.Body
    , expect : Http.Expect a
    , headers : List Http.Header
    , method : String
    , timeout : Maybe Float
    , url : Endpoint
    , tracker : Maybe String
    }
    -> Cmd a
request config =
    Http.request
        { body = config.body
        , expect = config.expect
        , headers = config.headers
        , method = config.method
        , timeout = config.timeout
        , url = unwrap config.url
        , tracker = config.tracker
        }



-- TYPES


type Endpoint
    = Endpoint String


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
