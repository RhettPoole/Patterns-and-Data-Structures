defmodule Sort do
  def start do
    spawn(fn -> loop() end)
  end

  defp loop() do
    receive do
      {sender, list} ->
        result = Enum.sort(list)
        send(sender, {:result, result})
        loop()
    end
  end
end

pid = Sort.start()
send(pid, {self(), ["a", "f", "b", "c", "h", "p"]})

receive do
  {:result, new_list} ->
    IO.puts("Sorted List: #{new_list}")
end
