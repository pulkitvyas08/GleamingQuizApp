import shared
import decode/zero
import pog

/// Runs the `find_quizzes` query
/// defined in `./src/quizzes/sql/find_quizzes.sql`.
///
/// > 🐿️ This function was generated automatically using v2.0.0 of
/// > the [squirrel package](https://github.com/giacomocavalieri/squirrel).
///
pub fn find_quizzes(db) {
  let decoder = {
    use id <- zero.field(0, zero.int)
    use question <- zero.field(1, zero.string)
    use option1 <- zero.field(2, zero.string)
    use option2 <- zero.field(3, zero.string)
    use option3 <- zero.field(4, zero.string)
    use option4 <- zero.field(5, zero.string)
    use correct_option <- zero.field(6, zero.int)
    zero.success(
      shared.QuizItem(
        id:,
        question:,
        option1:,
        option2:,
        option3:,
        option4:,
        correct_option:,
      ),
    )
  }

  let query = "SELECT
  *
FROM
  quizzes;"

  pog.query(query)
  |> pog.returning(zero.run(_, decoder))
  |> pog.execute(db)
}
