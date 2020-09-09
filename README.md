# ObanUi

Unofficial ui for oban. This repo is not a replacement for  [obanpro](https://getoban.pro/)

# Who should use this repo?

If you are not able to afford the pro version, you can use this. It lacks a lot of features so PR's are welcomed to improve it.

# Installation

Add `{:oban_ui, git: "https://github.com/sushant12/oban_ui.git", branch: "master"}` to your mix.exs file and run `mix deps.get`

# Configuration

ObanUi does not start a separate phoenix application. It will attach to your own phoenix application.

Add this to your **config.exs** file

```elixir
config :oban_ui, repo: MyApp.Repo, app_name: MyAppWeb
```
# Usage

In you router.ex file add the following
```elixir
defmodule MyAppWeb.Router do
  import ObanUi.Router
  scope "/", MyAppWeb do
    pipe_through :browser
    oban_web("/oban")
  end
end
```
`oban_web/1` will accept any path you give to it

# Features
- List all Jobs
- Delete or Discard single job

# TODO
- delete all jobs
- pagination
