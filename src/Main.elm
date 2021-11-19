module Main exposing (main)

import Browser
import Browser.Navigation as Navigation
import Element exposing (Attribute, column, padding, row, text)
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Html
import Html.Attributes exposing (autoplay, poster)
import Ports
import Url


type Msg
    = UrlRequest Browser.UrlRequest
    | UrlChanged Url.Url
    | JoinCall
    | Joined String


type CallState
    = NoCall
    | Joining
    | JoinedCall String
    | Leaving


type alias Model =
    { navKey : Navigation.Key
    , url : Url.Url
    , callState : CallState
    }


main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions =
            \_ ->
                Sub.batch
                    [ Ports.joined Joined
                    ]
        , onUrlRequest = UrlRequest
        , onUrlChange = UrlChanged
        }


type alias Flags =
    String


init : Flags -> Url.Url -> Navigation.Key -> ( Model, Cmd Msg )
init _ url navKey =
    ( { navKey = navKey
      , url = url
      , callState = NoCall
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

        JoinCall ->
            ( { model | callState = Joining }, Ports.join "room" )

        Joined call ->
            ( { model | callState = JoinedCall call }, Cmd.none )


view : Model -> Browser.Document Msg
view model =
    { title = "Vapor chats"
    , body = [ Element.layout [] <| viewChat model ]
    }


viewChat : Model -> Element.Element Msg
viewChat model =
    column []
        [ row []
            [ text "Hello "
            , text <| Url.toString model.url
            ]
        , Input.button actionButtonStyle
            { onPress = Just JoinCall
            , label = text <| "Join call"
            }
        , viewSelfVideo
        , viewPeerVideo
        ]


viewSelfVideo : Element.Element msg
viewSelfVideo =
    Element.html <|
        Html.video
            [ autoplay True
            , Html.Attributes.attribute "muted" "true"
            , playsInline
            , poster "img/placeholder.png"
            ]
            []


viewPeerVideo : Element.Element msg
viewPeerVideo =
    Element.html <|
        Html.video
            [ autoplay True
            , playsInline
            , poster "img/placeholder.png"
            ]
            []


playsInline : Html.Attribute msg
playsInline =
    Html.Attributes.attribute "playsinline" "true"


actionButtonStyle : List (Attribute msg)
actionButtonStyle =
    [ Font.size 16, Border.rounded 5, Border.width 2, padding 5 ]
