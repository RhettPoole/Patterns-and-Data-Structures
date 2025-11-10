defmodule Todo do
  def start(list) do
    spawn(fn -> loop(list) end)
  end

  defp loop(list) do
    receive do
      {:add, todo} ->
        new_list = [todo | list]
        #IO.inspect("You've added '#{todo}' to your To Do List.")
        loop(new_list)

      {:remove, todo} ->
        new_list = List.delete(list, todo)
        #IO.inspect("You've deleted #{todo} from the To Do List. Current To Do List: #{list}")
        loop(new_list)

      {:view} ->
        IO.inspect({list})
        loop(list)
    end
  end
end

pid = Todo.start(["Wake up", "Claim Competency in Stateful Processes", "Claim Competency in Queue's"])

send(pid, {:remove, "Wake up"})
send(pid, {:add, "Sleep"})
send(pid, {:view})

:timer.sleep(100)
