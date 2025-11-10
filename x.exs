defmodule Reverse do
  def start do
    spawn(fn -> loop() end)
  end

  defp loop do
    receive do
      {sender, input} ->
      result = String.reverse(input)
      send(sender, {:result, result})
      loop()
    end
  end
end

pid = Reverse.start()
send(pid, {self(), "fishers"})

receive do
  {:result, output} ->
    IO.puts("Reversed string: #{output}")
end
