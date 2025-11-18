defmodule PalindromeCheck do
  def start do
    spawn(fn -> loop() end)
  end

  defp loop() do
    receive do
      {sender, string} ->
        result = string == String.reverse(string)
        send(sender, {:result, result})
        loop()
    end
  end
end

pid = PalindromeCheck.start()

# expected in/out - racecar -> true
send(pid, {self(), "racecar"})

receive do
  {:result, result} ->
    IO.puts("Is racecar a palindrome? #{result}")
end
