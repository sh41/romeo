import Config

config :logger, backends: [:console], level: :warn
config :ex_unit, :assert_receive_timeout, 2000
config :mnesia, dir: 'test/tmp/mnesia/'

config :ejabberd,
  file: "config/ejabberd.test.yml",
  log_path: "test/tmp/logs/ejabberd.test.log"
