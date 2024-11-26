import wisp
import gleam/erlang/process
import mist
import wisp/wisp_mist
import web
import database
import gleam/erlang.{priv_directory}
import dot_env
import dot_env/env

pub fn main() {
  wisp.configure_logger()

  dot_env.new()
  |> dot_env.set_path(".env")
  |> dot_env.set_debug(False)
  |> dot_env.load

  let assert Ok(priv) = priv_directory("server")

  let db = database.connect()
  let assert Ok(Nil) = database.migrate(db)

  let assert Ok(secret_key) = env.get_string("SECRET_KEY")
  let router = web.handle_request(_, db, priv)

  let assert Ok(_) = 
    wisp_mist.handler(router, secret_key)
    |> mist.new
    |> mist.port(8000)
    |> mist.start_http

  process.sleep_forever()
}
