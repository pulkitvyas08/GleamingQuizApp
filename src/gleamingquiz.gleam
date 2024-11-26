import templates/layout
import lustre
import lustre/effect
import lustre/element
import gleam/option.{type Option, None, Some}

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
   let initial_quiz_item = quiz_item.QuizItem(
    id: 1,
    question: "What is the capital of France?",
    option1: "London",
    option2: "Paris",
    option3: "New Delhi",
    option4: "Moscow"
  )

  #(
    Model(
      // current_quiz_item: None
      current_quiz_item: Some(initial_quiz_item)
    ),
    effect.none()
  )
}

fn update(model: Model, msg: Msg) -> #(Model, effect.Effect(Msg)) {
  case msg{
    UserSelectedOption(_option) -> #(model, effect.none())
  }
}

fn view(model: Model) -> element.Element(msg) {
  layout.layout(model.current_quiz_item)
}