module Main exposing (..)

import Html.Attributes exposing (..)
import Html exposing (..)
import Http
import Browser
import Json.Decode exposing (Decoder, field, string, maybe)


type Model
  = Loading
  | Success String
  | Failure

type Msg
  = GotText (Result Http.Error String)


getMetObject : String -> Cmd Msg
getMetObject id =
  Http.get
    { url = String.join "" [ "data/image/" , id ]
    , expect = Http.expectJson GotText metDecoder
    }

metDecoder : Decoder String
metDecoder =
  field "x" string

init : () -> (Model, Cmd Msg)
init _ =
  ( Loading
  , getMetObject "1234567"
  )



subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    GotText result ->
      case result of
        Ok fullText ->
          (Success fullText, Cmd.none)

        Err _ ->
          (Failure, Cmd.none)



imageStyle =
  [ style "width" "30%", style "margin-left" "12px" ]





view : Model -> Html Msg
view model =
    case model of
        Failure ->
          div [] [text "fail"]
        Success str ->
          div [] [text str]
        Loading ->
          div [] [text "loading..."]


main =
  Browser.element
    { init = init
    , update = update
    , subscriptions = subscriptions
    , view = view
    }

