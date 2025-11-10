defmodule Queue do
  def start(queue \\ []) do
    spawn(fn -> loop (queue) end)
  end

  defp loop(queue) do
    receive do
      {:enqueue, item} ->
        # append and loop
        new_queue = queue ++ [item]
        IO.inspect(new_queue)
        loop(new_queue)

      :dequeue ->
        # remove front and loop
        case queue do
          [] -> IO.puts("Queue is empty")
          [head | tail] ->
            IO.puts("Removed item #{head}")
            IO.inspect("Updated tail #{tail}")
            loop(tail)
        end

      :peek ->
        # print front without removing
        case queue do
          [] ->
            IO.puts("Queue is empty")
            loop(queue)

          [head | _tail] ->
            IO.puts("Next item in queue: #{head}")
            loop(queue)
        end

      :show ->
        IO.inspect(queue, label: "Current queue")
        loop(queue)

      _ ->
        IO.puts("Invalid message.")
    end
  end
end


pid = Queue.start()

# Testing
send(pid, {:enqueue, "coffee"})
send(pid, {:enqueue, "tea"})
send(pid, :peek)
send(pid, :dequeue)
send(pid, :show)

:timer.sleep(100)
