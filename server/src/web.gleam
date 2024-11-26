import gleam/string_tree
import gleam/string
import gleam/list
import gleam/json
import shared
import quizzes/sql
import gleam/http
import gleam/http/request.{type Request}
import wisp.{type Connection}
import pog.{type Connection as DbConnection}

fn quiz_to_json(quiz: shared.QuizItem) -> String {
  json.object([
    #("id", json.int(quiz.id)),
    #("question", json.string(quiz.question)),
    #("correct_option", json.int(quiz.correct_option)),
    #("option1", json.string(quiz.option1)),
    #("option2", json.string(quiz.option2)),
    #("option3", json.string(quiz.option3)),
    #("option4", json.string(quiz.option4)),
  ])
  |> json.to_string
}

fn quizzes_to_json(quizzes: List(shared.QuizItem)) -> String {
  "["
  <> quizzes
  |> list.map(quiz_to_json)
  |> string.join(",")
  <>
  "]"
}

pub fn handle_request(
  req: Request(Connection),
  db: DbConnection,
  asset_dir: String
) {
  use <- wisp.serve_static(req, "/static", asset_dir)

  case request.path_segments(req) {
    ["quizzes"] -> {
      use <- wisp.require_method(req, http.Get)
      let assert Ok(quizzes) = sql.find_quizzes(db)
      let quiz_rows = quizzes.rows

      wisp.response(200)
      |> wisp.json_body(string_tree.from_string(quizzes_to_json(quiz_rows)))
    }

    _ -> 
      wisp.response(200)
      |> wisp.string_body("Ok")
  }
}
