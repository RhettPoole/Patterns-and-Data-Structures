# Create a stateful process that maintains a list of unique elements, allowing additions and removals.

defmodule Unique do
  def start(state) do
    spawn(fn -> loop(state) end)
  end

  defp loop(state) do
    receive do
      {:add, value} ->
        new_state = [value | state]
        IO.inspect(new_state, label: "New list")
        loop(new_state)

      {:remove, value} ->
        new_state = List.delete(state, value)
        IO.inspect(new_state, label: "New list")
        loop(new_state)
    end
  end
end

pid = Unique.start(["rhett", "poole", "brother", "barney"])

send(pid, {:add, "joseph"})
send(pid, {:remove, "rhett"})

:timer.sleep(100)
