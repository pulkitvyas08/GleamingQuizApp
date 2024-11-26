import dot_env/env
import gleam/list
import gleam/option.{Some}
import pog.{type Connection}

pub fn connect() -> Connection {
  let assert Ok(host) = env.get_string("DB_HOST")
  let assert Ok(user) = env.get_string("DB_USER")
  let assert Ok(pass) = env.get_string("DB_PASS")
  let assert Ok(db_name) = env.get_string("DB_NAME")

  pog.connect(
    pog.Config(
      ..pog.default_config(),
      host: host,
      database: db_name,
      user: user,
      password: Some(pass),
      port: 5432
    ),
  )
}

pub fn migrate(db: Connection) -> Result(Nil, pog.QueryError) {
  let migrations = [
  "CREATE TABLE IF NOT EXISTS quizzes (
    id SERIAL PRIMARY KEY,
    question TEXT NOT NULL,
    option1 TEXT NOT NULL,
    option2 TEXT NOT NULL,
    option3 TEXT NOT NULL,
    option4 TEXT NOT NULL,
    correct_option INT NOT NULL CHECK (correct_option BETWEEN 1 AND 4)
  )"
]

  migrations
  |> list.try_each(fn(migration) {
    pog.query(migration)
    |> pog.execute(db)
  })
}