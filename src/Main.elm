module Main exposing (main)

import Browser
import Browser.Navigation as Navigation
import Element exposing (column, row, text)
import Url


type Msg
    = UrlRequest Browser.UrlRequest
    | UrlChanged Url.Url


type alias Model =
    { navKey : Navigation.Key
    , url : Url.Url
    }


main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        , onUrlRequest = UrlRequest
        , onUrlChange = UrlChanged
        }


type alias Flags =
    String


init : Flags -> Url.Url -> Navigation.Key -> ( Model, Cmd Msg )
init _ url navKey =
    ( { navKey = navKey
      , url = url
      }
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UrlRequest _ ->
            ( model, Cmd.none )

        UrlChanged _ ->
            ( model, Cmd.none )


view : Model -> Browser.Document Msg
view model =
    { title = "Vapor chats"
    , body = [ Element.layout [] <| viewChat model ]
    }


viewChat : Model -> Element.Element msg
viewChat model =
    column []
        [ row []
            [ text "Hello "
            , text <| Url.toString model.url
            ]
        ]
