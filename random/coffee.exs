defmodule TestQueue do
  def add(queue, item) do
    new_queue = queue ++ [item]
    IO.inspect(new_queue)
  end

  def remove([head | tail]) do
    IO.puts("Removed item: #{head}")
    IO.inspect(tail, label: "Updated queue")
    tail
  end

  def remove([]), do: (IO.puts("Queue is empty"); [])
end

queue = [1, 2, 3]
TestQueue.add(queue, 4)
TestQueue.remove(queue)
