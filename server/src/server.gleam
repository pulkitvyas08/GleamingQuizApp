import database
import gleam/erlang.{priv_directory}

pub fn main() {
  let assert Ok(priv) = priv_directory("server")
  let db = database.connect()
  let assert Ok(Nil) = database.migrate(db)
}
