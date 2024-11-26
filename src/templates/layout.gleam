import gleam/option
import quiz_item
import lustre/element/html
import lustre/element
import lustre/attribute.{ class }

pub fn quiz_content(quiz: option.Option(quiz_item.QuizItem)) -> element.Element(a) {
  case quiz {
    option.None -> html.text("Loading Quiz...")
    option.Some(quiz) -> html.div([], [
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
  html.div([class("bg-red-50 flex flex-col gap-y-8 min-h-screen p-2 px-4")], [
    html.header([class("flex flex-row justify-between")], [
      html.button([], [html.text("Reset")]),
      html.h1([class("text-xl font-bold")], [html.text("Gleaming Quiz App")]),
      html.button([], [html.text("Score:")])
    ]),
    html.div([class("flex-1 flex flex-col justify-center content-center text-center min-h-full")], [quiz_content(quiz)]),
  ])
}