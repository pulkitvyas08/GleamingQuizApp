import gleam/erlang/process
import mist
import wisp/wisp_mist
import web
import gleam/erlang/os
import database
import gleam/erlang.{priv_directory}

pub fn main() {
  let assert Ok(priv) = priv_directory("server")

  let db = database.connect()
  let assert Ok(Nil) = database.migrate(db)

  let assert Ok(secret_key) = os.get_env("SECRET_KEY")
  let router = web.handle_request(_, db, priv)

  let assert Ok(_) = 
    wisp_mist.handler(router, secret_key)
    |> mist.new
    |> mist.port(8000)
    |> mist.start_http

  process.sleep_forever()
}
