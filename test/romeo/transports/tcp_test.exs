defmodule Romeo.Transports.TCPTest do
  use ExUnit.Case
  import Mock

  import Romeo.Test.Support.UserHelper

  setup do
    {:ok, romeo: build_user("romeo")}
  end

  test_with_mock "error on connect", %{romeo: romeo}, :gen_tcp, [:unstick],
    connect: fn _, _, _, _ -> {:error, :kaboom} end do
    {:ok, pid} = Romeo.Connection.start_link(romeo)

    assert {:error, _} = Connection.call(pid, "anything")
  end

  test_with_mock "error on send", %{romeo: romeo}, :gen_tcp, [:passthrough, :unstick],
    send: fn _, _ -> {:error, :kaboom} end do
    {:ok, pid} = Romeo.Connection.start_link(romeo)

    assert {:error, _} = Romeo.Connection.send(pid, "anything")
  end
end
