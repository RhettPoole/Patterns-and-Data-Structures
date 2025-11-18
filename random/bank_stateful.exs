defmodule Bank do
  def start(balance) do
    spawn(fn -> loop(balance) end)
  end

  defp loop(balance) do
    receive do
      {:deposit, amount} ->
        new_balance = balance + amount
        IO.puts("Deposited #{amount}, new balance: #{new_balance}")
        loop(new_balance)

      {:withdraw, amount} when amount <= balance ->
        new_balance = balance - amount
        IO.puts("Withdrew #{amount}, new balance: #{new_balance}")
        loop(new_balance)

      {:withdraw, amount} ->
        IO.puts("Cannot withdraw #{amount}, insufficient funds")
        loop(balance)

      :balance ->
        IO.puts("Current balance: #{balance}")
        loop(balance)
    end
  end
end

pid = Bank.start(100)
send(pid, :balance)
send(pid, {:deposit, 25})
send(pid, {:withdraw, 10})
send(pid, :balance)

# Give the process a moment to output before script exits
:timer.sleep(100)
