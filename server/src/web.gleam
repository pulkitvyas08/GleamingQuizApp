import gleam/http/request.{type Request}
import wisp.{type Connection}
import pog.{type Connection as DbConnection}

pub fn handle_request(
  req: Request(Connection),
  _db: DbConnection,
  asset_dir: String
) {
  use <- wisp.serve_static(req, "/static", asset_dir)

  // let assert Ok(resp) = pog.execute("select * from quizzes", db, [], dynamic.dynamic)
  // io.debug(resp)

  case request.path_segments(req) {
    _ -> 
      wisp.response(200)
      |> wisp.string_body("Ok")
  }
}
