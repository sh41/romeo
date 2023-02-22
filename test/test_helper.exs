System.at_exit(fn _ ->
  :mnesia.stop()
  :mnesia.delete_schema([node()])
end)

ExUnit.start(capture_log: true)
