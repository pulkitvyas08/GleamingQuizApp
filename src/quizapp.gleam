import lustre/element/html
import lustre
import lustre/effect
import lustre/element
import gleam/option.{type Option, None}

import quiz_item

pub fn main() {
  let app = lustre.application(init, update, view)
  let assert Ok(_) = lustre.start(app, "#app", Nil)

  Nil
}

type Msg {
  UserSelectedOption(String)
}

type Model {
  Model(
    current_quiz_item: Option(quiz_item.QuizItem)
  )
}

fn init(_flags) -> #(Model, effect.Effect(Msg)) {
  #(
    Model(
      current_quiz_item: None
    ),
    effect.none()
  )
}

fn update(model: Model, msg: Msg) -> #(Model, effect.Effect(Msg)) {
  case msg{
    UserSelectedOption(_option) -> #(model, effect.none())
  }
}

fn view(_model: Model) -> element.Element(msg) {
  html.div([], [
    html.text("Hello Quiz")
  ])
}