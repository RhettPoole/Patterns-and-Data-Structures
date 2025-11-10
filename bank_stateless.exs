defmodule BankStateless do
  def deposit(balance, amount) do
    new_balance = balance + amount
    IO.puts("Deposited #{amount}, new balance: #{new_balance}")
    new_balance
  end

  def withdraw(balance, amount) when amount <= balance do
    new_balance = balance - amount
    IO.puts("Withdrew #{amount}, new balance: #{new_balance}")
    new_balance
  end

  def withdraw(balance, amount) do
    IO.puts("Cannot withdraw #{amount}, insufficient funds")
    balance
  end

  def show_balance(balance) do
    IO.puts("Current balance: #{balance}")
    balance
  end
end

# Usage example
balance = 100
balance = BankStateless.deposit(balance, 25)
balance = BankStateless.withdraw(balance, 10)
BankStateless.show_balance(balance)
