defmodule Warehouse do
  def start(inventory) do
    spawn(fn -> loop(inventory) end)
  end

  def check_zero(0), do: IO.puts("Inventory alert: count is zero!")
  def check_zero(_), do: :ok

  defp loop(inventory) do
    receive do
      {:add, amount} ->
        new_inventory = inventory + amount
        IO.puts("Deposited #{amount}, new balance: #{new_inventory}")
        check_zero(new_inventory)
        loop(new_inventory)

      {:remove, amount} when amount <= inventory ->
        new_inventory = inventory - amount
        IO.puts("Withdrew #{amount}, new balance: #{new_inventory}")
        check_zero(new_inventory)
        loop(new_inventory)

      {:remove, amount} ->
        IO.puts("Cannot take #{amount}, out of inventory. That would put us in the negative.")
        loop(inventory)

      :inventory_count ->
        IO.puts("Current inventory level: #{inventory}")
        loop(inventory)
    end
  end
end

pid2 = Warehouse.start(1000)
send(pid2, {:add, 2400})
send(pid2, {:remove, 3400})
send(pid2, :inventory_count)

:timer.sleep(100)
