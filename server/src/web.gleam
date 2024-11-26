import gleam/io
import gleam/http/request.{type Request}
import wisp.{type Connection}
import gleam/pgo.{type Connection as DbConnection}
import gleam/dynamic

pub fn handle_request(
  req: Request(Connection),
  db: DbConnection,
  asset_dir: String
) {
  use <- wisp.serve_static(req, "/static", asset_dir)

  let assert Ok(resp) = pgo.execute("select * from quizzes", db, [], dynamic.dynamic)
  io.debug(resp)

  case request.path_segments(req) {
    _ -> 
      wisp.response(200)
      |> wisp.string_body("Ok")
  }
}