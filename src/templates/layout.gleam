import gleam/option
import quiz_item
import lustre/element/html
import lustre/element
import lustre/attribute.{ class }

pub fn quiz_content(quiz: option.Option(quiz_item.QuizItem)) -> element.Element(a) {
  case quiz {
    option.None -> html.text("Loading Quiz...")
    option.Some(quiz) -> html.div([class("flex flex-col justify-center content-center")], [
      html.h2([], [html.text(quiz.question)]),
      html.div([], [
        html.text(quiz.option1),
        html.text(quiz.option2),
        html.text(quiz.option3),
        html.text(quiz.option4),
      ])
    ])
  }
}

pub fn layout(quiz: option.Option(quiz_item.QuizItem)) -> element.Element(a) {
  html.div([class("bg-red-50 flex flex-col")], [
    html.header([class("flex flex-row justify-between")], [
      html.button([], [html.text("Reset")]),
      html.h1([], [html.text("Quiz App")]),
      html.button([], [html.text("Score:")])
    ]),
    quiz_content(quiz)
  ])
}