# Server for GleamingQuiz

If you encounter this error with Squirrel:

```bash
  Running squirrel.main Error: Cannot authenticate Invalid password for user postgres. Hint: You can change the default password used to authenticate by setting the PGPASSWORD environment variable
```

When running

```bash
  gleam run -m squirrel
```

Then export your env variables like this:

1. Create a .env.local and add your env vars like this:

   ```env
     export ENV_VAR = value
   ```

2. Source them like this:

   ```bash
     source .env.local
   ```

To share types between FE and BE add a `shared` gleam project and add it as a dependency in the server and client projects in `gleam.toml` as:

```toml
  shared = { path = "../shared" }
```
