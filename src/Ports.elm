port module Ports exposing (join, joined)


port join : String -> Cmd msg


port joined : (String -> msg) -> Sub msg
